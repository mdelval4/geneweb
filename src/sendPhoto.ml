(* camlp4r ./pa_lock.cmo ./pa_html.cmo *)
(* $Id: sendPhoto.ml,v 1.3 1999-02-18 15:52:53 ddr Exp $ *)

open Gutil;
open Util;
open Config;
open Def;

value incorrect conf =
  do incorrect_request conf; return raise Update.ModErr
;

value raw_get conf key =
  try List.assoc key conf.env with
  [ Not_found -> incorrect conf ]
;

(* Send photo form *)

value print_send_photo conf base p =
  let title h =
    do Wserver.wprint "%s"
         (capitale (transl_decline conf "send" (transl conf "photo")));
       if h then ()
       else
         let fn = sou base p.first_name in
         let sn = sou base p.surname in
         let occ =
         if fn = "?" || sn = "?" then Adef.int_of_iper p.cle_index
           else p.occ
         in
         do Wserver.wprint ": ";
            Wserver.wprint "%s.%d %s" (coa conf fn) occ (coa conf sn);
         return ();
    return ()
  in
  let digest = Update.digest_person p in
  do header conf title;
     tag "form"
       "method=POST action=\"%s\" enctype=\"multipart/form-data\""
       conf.command
     begin
       Srcfile.hidden_env conf;
       Wserver.wprint "<input type=hidden name=m value=SND_PHOTO_OK>\n";
       Wserver.wprint "<input type=hidden name=i value=%d>\n"
         (Adef.int_of_iper p.cle_index);
       Wserver.wprint "<input type=hidden name=digest value=\"%s\">\n" digest;
       Wserver.wprint "\n";
       Wserver.wprint "%s:\n" (capitale (transl conf "file"));
       Wserver.wprint
         "<input type=file name=file size=50 maxlength=250 \
           accept=\"image/*\">\n";
       Wserver.wprint "<p>\n";
       Wserver.wprint "<input type=submit value=Ok>\n";
     end;
     trailer conf;
  return ()
;

value print conf base =
  match p_getint conf.env "i" with
  [ Some ip ->
      let p = base.data.persons.get ip in
      if sou base p.photo <> "" then incorrect_request conf
      else print_send_photo conf base p
  | _ -> incorrect_request conf ]
;

(* Delete photo form *)

value print_delete_photo conf base p =
  let title h =
    do Wserver.wprint "%s"
         (capitale (transl_decline conf "delete" (transl conf "photo")));
       if h then ()
       else
         let fn = sou base p.first_name in
         let sn = sou base p.surname in
         let occ =
         if fn = "?" || sn = "?" then Adef.int_of_iper p.cle_index
           else p.occ
         in
         do Wserver.wprint ": ";
            Wserver.wprint "%s.%d %s" (coa conf fn) occ (coa conf sn);
         return ();
    return ()
  in
  do header conf title;
     Wserver.wprint "\n";
     tag "form" "method=POST action=\"%s\"" conf.command begin
       Srcfile.hidden_env conf;
       Wserver.wprint "<input type=hidden name=m value=DEL_PHOTO_OK>\n";
       Wserver.wprint "<input type=hidden name=i value=%d>\n\n"
         (Adef.int_of_iper p.cle_index);
       Wserver.wprint "\n";
       html_p conf;
       Wserver.wprint "<input type=submit value=Ok>\n";
     end;
     Wserver.wprint "\n";
     trailer conf;
  return ()
;

value print_del conf base =
  match p_getint conf.env "i" with
  [ Some ip ->
      let p = base.data.persons.get ip in
      if sou base p.photo <> "" then incorrect_request conf
      else
        match auto_photo_file conf base p with
        [ Some _ -> print_delete_photo conf base p
        | _ -> incorrect_request conf ]
  | _ -> incorrect_request conf ]
;

(* Send photo form validated *)

value print_sent conf base p =
  let title _ =
    Wserver.wprint "%s" (capitale (transl conf "photo received"))
  in
  do header conf title;
     tag "ul" begin
       html_li conf;
       afficher_personne_referencee conf base p;
       Wserver.wprint "\n";
     end;
     trailer conf;
  return ()
;

value write_file fname content =
  let oc = open_out_bin fname in
  do output_string oc content;
     flush oc;
     close_out oc;
  return ()
;

value move_file_to_old conf typ fname bfname =
  let old_dir =
    List.fold_right Filename.concat
      [Util.base_dir.val; "images"; conf.bname] "old"
  in
  if Sys.file_exists (Filename.concat old_dir bfname ^ ".gif")
  || Sys.file_exists (Filename.concat old_dir bfname ^ ".jpg") then
    try Sys.remove (fname ^ typ) with [ Sys_error _ -> () ]
  else
    do try Unix.mkdir old_dir 0o777 with [ Unix.Unix_error _ _ _ -> () ];
       try Unix.rename (fname ^ typ) (Filename.concat old_dir bfname ^ typ)
       with
       [ Unix.Unix_error _ _ _ -> () ];
    return ()
;

value buff = ref (String.create 80);
value store len x =
  do if len >= String.length buff.val then
       buff.val := buff.val ^ String.create (String.length buff.val)
     else ();
     buff.val.[len] := x;
  return succ len
;
value get_buff len = String.sub buff.val 0 len;

value effective_send_ok conf base p file =
  let strm = Stream.of_string file in
  let (request, content) =
    Wserver.get_request_and_content strm
  in
  let content =
    let s =
      loop 0 strm where rec loop len =
        parser
        [ [: `x :] -> loop (store len x) strm
        | [: :] -> get_buff len ]
    in
    content ^ s
  in
  let content_type = Wserver.extract_param "content-type: " '\n' request in
  let typ =
    match content_type with
    [ "image/gif" -> ".gif"
    | "image/jpeg" -> ".jpg"
    | _ -> incorrect conf ]
  in
  let bfname = default_photo_name base p in
  let fname =
    List.fold_right Filename.concat [Util.base_dir.val; "images"; conf.bname]
      bfname
  in
  do if Sys.file_exists (fname ^ ".gif") then
       move_file_to_old conf ".gif" fname bfname
     else if Sys.file_exists (fname ^ ".jpg") then
       move_file_to_old conf ".jpg" fname bfname
     else
       let d = Filename.concat Util.base_dir.val "images" in
       do try Unix.mkdir d 0o777 with [ Unix.Unix_error _ _ _ -> () ];
          try Unix.mkdir (Filename.concat d conf.bname) 0o777
          with [ Unix.Unix_error _ _ _ -> () ];
       return ();
     write_file (fname ^ typ) content;
     print_sent conf base p;
  return ()
;

value print_send_ok conf base =
  let bfile = Filename.concat Util.base_dir.val conf.bname in
  lock (Iobase.lock_file bfile) with
  [ Accept ->
      try
        let ip =
          let s = raw_get conf "i" in
          try int_of_string s with
          [ Failure _ -> incorrect conf ]
        in
        let p = base.data.persons.get ip in
        let digest = Update.digest_person p in
        if digest = raw_get conf "digest" then
          let file = raw_get conf "file" in
          effective_send_ok conf base p file
        else Update.error_digest conf base
      with
      [ Update.ModErr -> () ]
  | Refuse -> Update.error_locked conf base ]
;

(* Delete photo form validated *)

value print_deleted conf base p =
  let title _ =
    Wserver.wprint "%s" (capitale (transl conf "photo deleted"))
  in
  do header conf title;
     tag "ul" begin
       html_li conf;
       afficher_personne_referencee conf base p;
       Wserver.wprint "\n";
     end;
     trailer conf;
  return ()
;

value effective_delete_ok conf base p =
  let bfname = default_photo_name base p in
  let fname =
    List.fold_right Filename.concat [Util.base_dir.val; "images"; conf.bname]
      bfname
  in
  do if Sys.file_exists (fname ^ ".gif") then
       move_file_to_old conf ".gif" fname bfname
     else if Sys.file_exists (fname ^ ".jpg") then
       move_file_to_old conf ".jpg" fname bfname
     else incorrect conf;
     print_deleted conf base p;
  return ()
;

value print_del_ok conf base =
  let bfile = Filename.concat Util.base_dir.val conf.bname in
  lock (Iobase.lock_file bfile) with
  [ Accept ->
      try
        match p_getint conf.env "i" with
        [ Some ip ->
            let p = base.data.persons.get ip in
            effective_delete_ok conf base p
        | None -> incorrect conf ]
      with
      [ Update.ModErr -> () ]
  | Refuse -> Update.error_locked conf base ]
;
