(* camlp4r ./pa_lock.cmo ./pa_html.cmo *)
(* $Id: relation.ml,v 3.60 2000-11-13 20:48:25 ddr Exp $ *)
(* Copyright (c) 2000 INRIA *)

open Def;
open Gutil;
open Config;
open Util;

value round_2_dec x = floor (x *. 100.0 +. 0.5) /. 100.0;

value print_with_relation text conf base p r is =
  fun
  [ Some ic ->
      let c = poi base ic in
      do html_li conf;
         Wserver.wprint "<input type=radio name=select value=%d>\n"
           (Adef.int_of_iper ic);
         Wserver.wprint "(%s)\n" (text conf r.r_type is);
         afficher_personne_sans_titre conf base c;
         afficher_titre conf base c;
         Wserver.wprint "\n";
      return ()
  | None -> () ]
;

value print_with_related conf base p ip =
  let c = poi base ip in
  List.iter
    (fun r ->
       do match r.r_fath with
          [ Some ip1 when p.cle_index == ip1 ->
              print_with_relation rchild_type_text conf base p r
                (index_of_sex c.sex) (Some ip)
          | _ -> () ];
          match r.r_moth with
          [ Some ip1 when p.cle_index == ip1 ->
              print_with_relation rchild_type_text conf base p r
                (index_of_sex c.sex) (Some ip)
          | _ -> () ];
       return ())
    c.rparents
;

value print_with_witness conf base p fam ip =
  let w = poi base ip in
  do html_li conf;
     Wserver.wprint "<input type=radio name=select value=%d>\n"
       (Adef.int_of_iper ip);
     Wserver.wprint "(%s)\n"
       (nominative (transl_nth conf "witness/witnesses" 0));
     afficher_personne_sans_titre conf base w;
     afficher_titre conf base w;
     Wserver.wprint "\n";
  return ()
;

value print_menu conf base p =
  let title h =
    do Wserver.wprint "%s " (capitale (transl conf "link between"));
       if h then
         match sou base p.public_name with
         [ "" ->
             Wserver.wprint "%s %s" (p_first_name base p) (p_surname base p)
         | n -> Wserver.wprint "%s" n ]
       else Wserver.wprint "%s" (person_text conf base p);
       Wserver.wprint " %s..." (transl conf "and");
    return ()
  in
  let is = index_of_sex p.sex in
  let u = uoi base p.cle_index in
  do header conf title;
     tag "form" "method=get action=\"%s\"" conf.command begin
       Util.hidden_env conf;
       Wserver.wprint "<input type=hidden name=em value=R>\n";
       wprint_hidden_person conf base "e" p;
       tag "ul" begin
         html_li conf;
         Wserver.wprint "<input type=hidden name=m value=NG>\n";
         Wserver.wprint "<input type=radio name=select value=input checked>\n";
         Wserver.wprint "<input name=n size=40 maxlength=200>\n";
         html_p conf;
         tag "ul" begin
           html_li conf;
           Wserver.wprint "<input type=radio name=t value=PN checked>\n";
           Wserver.wprint "\
<em>%s %s</em> %s <em>%s</em> %s <em>%s</em> %s <em>%s</em>
" (transl_nth conf "first name/first names" 0)
             (transl_nth conf "surname/surnames" 0) (transl conf "or")
             (transl conf "public name") (transl conf "or")
             (nominative (transl conf "alias")) (transl conf "or")
             (transl_nth conf "surname/surnames" 0);
           match Util.find_person_in_env conf base "z" with
           [ Some p ->
               do Wserver.wprint "%s " (transl conf "or");
                  Wserver.wprint
                    (ftransl conf "<em>Sosa number</em> relative to %t")
                    (fun _ ->
                       Wserver.wprint "%s"
                         (referenced_person_title_text conf base p));
               return ()
           | None -> () ];
           html_li conf;
           Wserver.wprint "<input type=radio name=t value=P> <em>%s</em>\n"
             (transl_nth conf "first name/first names" 0);
           html_li conf;
           Wserver.wprint "<input type=radio name=t value=N> <em>%s</em>\n"
             (transl_nth conf "surname/surnames" 0);
         end;
         let auth = age_autorise conf base p in
         Array.iter
           (fun ifam ->
              let fam = foi base ifam in
              let cpl = coi base ifam in
              let c = spouse p.cle_index cpl in
              let c = poi base c in
              if p_first_name base c <> "?" || p_surname base c <> "?" then
                do html_li conf;
                   Wserver.wprint "<input type=radio name=select value=%d>\n"
                     (Adef.int_of_iper c.cle_index);
                   afficher_personne_sans_titre conf base c;
                   afficher_titre conf base c;
                   Wserver.wprint "\n";
                return ()
              else ())
           u.family;
         List.iter
           (fun r ->
              do print_with_relation relation_type_text conf base p r 0
                   r.r_fath;
                 print_with_relation relation_type_text conf base p r 1
                   r.r_moth;
              return ())
           p.rparents;
         List.iter (print_with_related conf base p) p.related;
         Array.iter
           (fun ifam ->
              let fam = foi base ifam in
              Array.iter (print_with_witness conf base p ifam) fam.witnesses)
           u.family;
       end;
       html_p conf;
       tag "table" "border=%d width=\"90%%\"" conf.border begin
         tag "tr" begin
           tag "td" "align=right" begin
             Wserver.wprint "%s\n" (capitale (transl conf "long display"));
             Wserver.wprint "<input type=checkbox name=long value=on><br>\n";
             Wserver.wprint "%s\n" (capitale (transl conf "include spouses"));
             Wserver.wprint "<input type=checkbox name=spouse value=on><br>\n";
           end;
           tag "td" "align=right" begin
             Wserver.wprint "%s\n"
               (capitale (transl_nth conf "image/images" 1));
             Wserver.wprint "<input type=checkbox name=image value=on><br>\n";
             Wserver.wprint "%s\n"
               (capitale (transl conf "cancel GeneWeb links"));
             Wserver.wprint "<input type=checkbox name=cgl value=on><br>\n";
           end;
         end;
         tag "tr" begin
           tag "td" "align=center colspan=2" begin
             Wserver.wprint "<table><tr><td>\n";
             Wserver.wprint "<input type=radio name=et value=A checked>\n";
             Wserver.wprint "%s<br>\n"
               (capitale (transl conf "ancestors"));
             Wserver.wprint "<input type=radio name=et value=M>\n";
             Wserver.wprint "%s<br>\n"
               (capitale (transl conf "relationships by marriage"));
             Wserver.wprint "<input type=radio name=et value=S>\n";
             Wserver.wprint "%s<br>\n"
               (capitale (transl conf "shortest path"));
             Wserver.wprint "</td></tr></table>\n";
           end;
         end;
         tag "tr" begin
           tag "td" "align=center colspan=2" begin
             Wserver.wprint "<input type=submit value=\"Ok\">\n";
           end;
         end;
       end;
     end;
     trailer conf;
  return ()
;

(* find shortest path :
 * parents, siblings, mates and children are at distance 1.
 *)
type famlink = [ Self | Parent | Sibling | HalfSibling | Mate | Child ];

open Dag2html;

type dag_ind 'a =
  { di_val : 'a;
    di_famc : mutable dag_fam 'a;
    di_fams : mutable dag_fam 'a }
and dag_fam 'a =
  { df_pare : list (dag_ind 'a);
    df_chil : list (dag_ind 'a) }
;

value dag_ind_list_of_path path =
  let (indl, _) =
    let merge l1 l2 = if l1 == l2 then l1 else l1 @ l2 in
    List.fold_left
      (fun (indl, prev_ind) (ip, fl) ->
         let (ind, indl) =
           try (List.find (fun di -> di.di_val = Some ip) indl, indl) with
           [ Not_found ->
               let rec ind = {di_val = Some ip; di_famc = famc; di_fams = fams}
               and famc = {df_pare = []; df_chil = [ind]}
               and fams = {df_pare = [ind]; df_chil = []} in
               (ind, [ind :: indl]) ]
         in
         let fam =
           match prev_ind with
           [ None -> {df_pare = []; df_chil = []}
           | Some p_ind ->
               match fl with
               [ Parent ->
                   {df_pare = merge p_ind.di_famc.df_pare ind.di_fams.df_pare;
                    df_chil = merge p_ind.di_famc.df_chil ind.di_fams.df_chil}
               | Child ->
                   {df_pare = merge p_ind.di_fams.df_pare ind.di_famc.df_pare;
                    df_chil = merge p_ind.di_fams.df_chil ind.di_famc.df_chil}
               | Sibling | HalfSibling ->
                   {df_pare = merge p_ind.di_famc.df_pare ind.di_famc.df_pare;
                    df_chil = merge p_ind.di_famc.df_chil ind.di_famc.df_chil}
               | Mate ->
                   {df_pare = merge p_ind.di_fams.df_pare ind.di_fams.df_pare;
                    df_chil = merge p_ind.di_fams.df_chil ind.di_fams.df_chil}
               | Self -> {df_pare = []; df_chil = []} ] ]
         in
         do List.iter (fun ind -> ind.di_famc := fam) fam.df_chil;
            List.iter (fun ind -> ind.di_fams := fam) fam.df_pare;
         return (indl, Some ind))
      ([], None) (List.rev path)
  in
  indl
;

value add_missing_parents_of_siblings base indl =
  List.fold_right
    (fun ind indl ->
       let indl =
         match ind.di_famc with
         [ {df_pare = []; df_chil = [_]} -> indl
         | {df_pare = []; df_chil = children} ->
             let ip =
               match ind.di_val with
               [ Some ip ->
                   match (aoi base ip).parents with
                   [ Some ifam -> (coi base ifam).father
                   | None -> assert False ]
               | _ -> assert False ]
             in
             let rec indp =
               {di_val = Some ip; di_famc = famc; di_fams = fams}
             and famc = {df_pare = []; df_chil = [indp]}
             and fams = {df_pare = [indp]; df_chil = children} in
             do List.iter (fun ind -> ind.di_famc := fams) children;
             return
             [indp :: indl]
         | _ -> indl ]
       in
       [ind :: indl])
    indl []
;

value dag_fam_list_of_ind_list indl =
  List.fold_left
    (fun faml ind ->
       let faml =
         if List.memq ind.di_famc faml then faml else [ind.di_famc :: faml]
       in
       if List.memq ind.di_fams faml then faml else [ind.di_fams :: faml])
    [] indl
;

value add_phony_children indl faml =
  List.fold_right
    (fun fam (indl, faml) ->
       match fam with
       [ {df_pare = [_]; df_chil = []} -> (indl, [fam :: faml])
       | {df_pare = pare; df_chil = []} ->
           let rec ind = {di_val = None; di_famc = famc; di_fams = fams}
           and famc = {df_pare = pare; df_chil = [ind]}
           and fams = {df_pare = [ind]; df_chil = []} in
           do List.iter (fun ind -> ind.di_fams := famc) pare; return
           ([ind :: indl], [famc; fams :: faml])
       | _ -> (indl, [fam :: faml]) ])
    faml (indl, [])
;

value dag_of_ind_dag_list indl =
  let (indl, _) =
    List.fold_right (fun ind (indl, cnt) -> ([(ind, cnt) :: indl], cnt + 1))
      indl ([], 0)
  in
  let idag_of_di_ind ind = idag_of_int (List.assq ind indl) in
  List.map
    (fun (ind, cnt) ->
       {pare = List.map idag_of_di_ind ind.di_famc.df_pare;
        valu =
          match ind.di_val with
          [ Some ic -> Dag.Left ic
          | None -> Dag.Right cnt ];
        chil = List.map idag_of_di_ind ind.di_fams.df_chil})
    indl
;

value print_relation_path_dag conf base print_elem path =
  let indl = dag_ind_list_of_path path in
  let indl = add_missing_parents_of_siblings base indl in
  let faml = dag_fam_list_of_ind_list indl in
  let (indl, faml) = add_phony_children indl faml in
  let nl = dag_of_ind_dag_list indl in
  let d = {dag = Array.of_list (List.rev nl)} in
(*
  do Array.iter
       (fun n ->
          if n.chil <> [] then
            do match n.valu with
               [ Dag.Left ip ->
                   Printf.eprintf "\no %s\n" (denomination base (poi base ip))
               | Dag.Right c -> Printf.eprintf "\no %d\n" c ];
               List.iter
                 (fun i ->
                    let n = d.dag.(int_of_idag i) in
                    match n.valu with
                    [ Dag.Left ip ->
                        Printf.eprintf "- %s\n"
                          (denomination base (poi base ip))
                    | Dag.Right c -> Printf.eprintf "- %d\n" c ])
                 n.chil;
            return ()
          else ())
       d.dag;
  return
*)
  let set =
    List.fold_left
      (fun set n ->
         match n.valu with
         [ Dag.Left ip -> Dag.Pset.add ip set
         | Dag.Right _ -> set ])
      Dag.Pset.empty nl
  in
  let spouse_on =
    match Util.p_getenv conf.env "spouse" with
    [ Some "on" -> True
    | _ -> False ]
  in
  let invert =
    match Util.p_getenv conf.env "invert" with
    [ Some "on" -> True
    | _ -> False ]
  in
  Dag.print_only_dag conf base print_elem spouse_on invert set [] d
;

value print_relation_path conf base ip1 ip2 path excl_faml =
  if path == [] then ()
  else
    let print_elem conf base p =
      do Wserver.wprint "%s" (Util.referenced_person_title_text conf base p);
         Wserver.wprint "%s" (Date.short_dates_text conf base p);
      return ()
    in
    do Wserver.wprint "<p>\n";
       print_relation_path_dag conf base print_elem path;
       Wserver.wprint "<p>\n";
       Wserver.wprint "<a href=\"%s" (commd conf);
       Wserver.wprint "em=R;ei=%d;i=%d%s;et=S" (Adef.int_of_iper ip1)
         (Adef.int_of_iper ip2)
         (if conf.cancel_links then ";cgl=on" else "");
       let _ =
         List.fold_left
           (fun i ifam ->
              do Wserver.wprint ";ef%d=%d" i (Adef.int_of_ifam ifam); return
              i + 1)
           0 (List.rev excl_faml)
       in ();
       Wserver.wprint "\">&gt;&gt;</a>\n";
    return ()
;

type node = [ NotVisited | Visited of (bool * iper * famlink) ];

value get_shortest_path_relation base ip1 ip2 excl_faml =
  let mark_per = Array.create base.data.persons.len NotVisited in
  let mark_fam = Array.create base.data.families.len False in
  do List.iter
        (fun i ->
           let i = Adef.int_of_ifam i in
           if i < Array.length mark_fam then mark_fam.(i) := True else ())
        excl_faml;
  return
  let parse_fam ifam =
    if mark_fam.(Adef.int_of_ifam ifam) then []
    else
      let cpl = coi base ifam in
      do mark_fam.(Adef.int_of_ifam ifam) := True; return
      let result = [(cpl.father, Parent, ifam); (cpl.mother, Parent, ifam)] in
      let result =
        result @
          List.fold_right
            (fun child children -> [(child, Sibling, ifam) :: children])
            (Array.to_list (doi base ifam).children) []
      in
      let result =
        result @
          List.fold_right
            (fun fam children ->
               if ifam = fam then children
               else if mark_fam.(Adef.int_of_ifam fam) then children
               else
                 List.fold_right
                   (fun child children ->
                      [(child, HalfSibling, fam) :: children])
                   (Array.to_list (doi base fam).children) children)
            (Array.to_list (uoi base cpl.father).family) []
      in
      let result =
        result @
          List.fold_right
            (fun fam children ->
               if ifam = fam then children
               else if mark_fam.(Adef.int_of_ifam fam) then children
               else
                 List.fold_right
                   (fun child children ->
                      [(child, HalfSibling, fam) :: children])
                   (Array.to_list (doi base fam).children) children)
            (Array.to_list (uoi base cpl.mother).family) []
      in
      result
  in
  let neighbours iper =
    let result =
      List.fold_right
        (fun ifam nb ->
           if mark_fam.(Adef.int_of_ifam ifam) then nb
           else
             let cpl = coi base ifam in
             do mark_fam.(Adef.int_of_ifam ifam) := True; return
             List.fold_right
               (fun child children -> [(child, Child, ifam) :: children])
               (Array.to_list (doi base ifam).children)
               [(cpl.father, Mate, ifam); (cpl.mother, Mate, ifam)] @
               nb)
        (Array.to_list (uoi base iper).family) []
    in
    let result =
      result @
        (match (aoi base iper).parents with
         [ Some ifam -> parse_fam ifam
         | _ -> [] ])
    in
    result
  in
  let rec make_path path vertex =
    match List.hd path with
    [ (iper, Self) -> path
    | (iper, _) ->
        match mark_per.(Adef.int_of_iper vertex) with
        [ NotVisited -> assert False
        | Visited (s, v, f) -> make_path [(vertex, f) :: path] v ] ]
  in
  let merge_path p1 p2 =
    let swap_order el =
      match el with
      [ (iper, Parent) -> (iper, Child)
      | (iper, Child) -> (iper, Parent)
      | _ -> el ]
    in
    List.map2 (fun (ip1, fl1) (ip2, fl2) -> swap_order (ip1, fl2))
      (List.rev (List.tl (List.rev p1))) (List.tl p1) @
      List.rev p2
  in
  let one_step_further source queue =
    loop1 [] queue where rec loop1 newvertexlist =
      fun
      [ [vertex :: vertexlist] ->
          loop2 newvertexlist (neighbours vertex)
          where rec loop2 result =
            fun
            [ [(iper, fl, ifam) :: neighbourslist] ->
                match mark_per.(Adef.int_of_iper iper) with
                [ NotVisited ->
                    do mark_per.(Adef.int_of_iper iper) :=
                         Visited (source, vertex, fl);
                    return loop2 [iper :: result] neighbourslist
                | Visited (s, v, f) ->
                    if s == source then loop2 result neighbourslist
                    else
                      let p1 = make_path [(iper, fl)] vertex in
                      let p2 = make_path [(iper, f)] v in
                      let path =
                        if source then merge_path p2 p1 else merge_path p1 p2
                      in
                      Left (path, ifam) ]
            | [] -> loop1 result vertexlist ]
      | [] -> Right newvertexlist ]
  in
  let rec width_search queue1 visited1 queue2 visited2 =
    if queue1 == [] || queue2 == [] then None
    else if visited1 > visited2 then
      let visited2 = visited2 + List.length queue2 in
      match one_step_further False queue2 with
      [ Left (path, ifam) -> Some (path, ifam)
      | Right queue2 -> width_search queue1 visited1 queue2 visited2 ]
    else
      let visited1 = visited1 + List.length queue1 in
      match one_step_further True queue1 with
      [ Left (path, ifam) -> Some (path, ifam)
      | Right queue1 -> width_search queue1 visited1 queue2 visited2 ]
  in
  do mark_per.(Adef.int_of_iper ip1) := Visited (True, ip1, Self);
     mark_per.(Adef.int_of_iper ip2) := Visited (False, ip2, Self);
  return width_search [ip1] 0 [ip2] 0
;

value print_shortest_path conf base p1 p2 =
  if p1.cle_index = p2.cle_index then
    let title _ =
      Wserver.wprint "%s" (capitale (transl conf "relationship"))
    in
    do header conf title;
       Wserver.wprint "%s\n" (capitale (transl conf "it is the same person!"));
       trailer conf;
    return ()
  else
    let _ = base.data.ascends.array () in
    let _ = base.data.unions.array () in
    let _ = base.data.couples.array () in
    let _ = base.data.descends.array () in
    let excl_faml =
      loop [] 0 where rec loop list i =
        match p_getint conf.env ("ef" ^ string_of_int i) with
        [ Some k -> loop [Adef.ifam_of_int k :: list] (i + 1)
        | None ->
            match find_person_in_env conf base ("ef" ^ string_of_int i) with
            [ Some p ->
                let n =
                  match p_getint conf.env ("fef" ^ string_of_int i) with
                  [ Some n -> n
                  | None -> 0 ]
                in
                let u = uoi base p.cle_index in
                loop [u.family.(n) :: list] (i + 1)
            | None -> list ] ]
    in
    let title _ =
      Wserver.wprint "%s" (capitale (transl conf "relationship"))
    in
    let ip1 = p1.cle_index in
    let ip2 = p2.cle_index in
    do header_no_page_title conf title;
       match get_shortest_path_relation base ip1 ip2 excl_faml with
       [ Some (path, ifam) ->
           let excl_faml = [ifam :: excl_faml] in
           print_relation_path conf base ip1 ip2 path excl_faml
       | None ->
           let s1 = gen_referenced_person_title_text raw_access conf base p1 in
           let s2 = gen_referenced_person_title_text raw_access conf base p2 in
           if excl_faml = [] then
             do Wserver.wprint "<center><h1><font color=%s>" conf.highlight;
                title False;
                Wserver.wprint "</font></h1></center>\n";
                Util.print_link_to_welcome conf True;
                Wserver.wprint "%s\n"
                  (capitale
                     (cftransl conf
                        "no known relationship link between %s and %s"
                        [s1; s2]));
             return ()
           else
             tag "ul" begin
               Wserver.wprint "<li>%s\n" s1;
               Wserver.wprint "<li>%s\n" s2;
             end ];
       trailer conf;
    return ()
;

value parents_label conf =
  fun
  [ 1 -> transl conf "the parents"
  | 2 -> transl conf "grand-parents"
  | 3 -> transl conf "great-grand-parents"
  | n ->
      transl conf "ancestors (some)" ^ " " ^
        Printf.sprintf (ftransl conf "of the %s generation")
          (transl_nth conf "nth (generation)" n) ]
;

value parent_in_law_label conf sex =
  let is = index_of_sex sex in
  transl_nth conf "the father-in-law/the mother-in-law" is
;

value ancestor_label conf x sex =
  let is = index_of_sex sex in
  match x with
  [ 1 -> transl_nth conf "the father/the mother/a parent" is
  | 2 -> transl_nth conf "a grandfather/a grandmother/a grandparent" is
  | 3 ->
      transl_nth conf
        "a great-grandfather/a great-grandmother/a great-grandparent" is
  | n ->
      transl_nth conf "an ancestor" is ^ " " ^
        Printf.sprintf (ftransl conf "of the %s generation")
          (transl_nth conf "nth (generation)" n) ]
;

value child_in_law_label conf sex =
  let is = index_of_sex sex in
  transl_nth conf "a son-in-law/a daughter-in-law" is
;

value descendant_label conf x p =
  let is = index_of_sex p.sex in
  match x with
  [ 1 -> transl_nth conf "a son/a daughter/a child" is
  | 2 -> transl_nth conf "a grandson/a granddaughter/a grandchild" is
  | 3 ->
      transl_nth conf
        "a great-grandson/a great-granddaughter/a great-grandchild" is
  | n ->
      transl_nth conf "a descendant" is ^ " " ^
        Printf.sprintf (ftransl conf "of the %s generation")
          (transl_nth conf "nth (generation)" n) ]
;

value brother_label conf x sex =
  let is = index_of_sex sex in
  match x with
  [ 1 -> transl_nth conf "a brother/a sister/a sibling" is
  | 2 -> transl_nth conf "a cousin" is
  | 3 -> transl_nth conf "a 2nd cousin" is
  | 4 -> transl_nth conf "a 3rd cousin" is
  | n ->
      Printf.sprintf (ftransl_nth conf "a %s cousin" is)
        (transl_nth conf (transl_nth conf "*nth (cousin)*" is) (n - 1)) ]
;

value half_brother_label conf sex =
  let is = index_of_sex sex in
  transl_nth conf "a half-brother/a half-sister/a half-sibling" is
;

value brother_in_law_label conf sex =
  let is = index_of_sex sex in
  transl_nth conf "a brother-in-law/a sister-in-law" is
;

value nb_fields s =
  loop 1 0 where rec loop cnt i =
    if i == String.length s then cnt
    else if s.[i] == '/' then loop (cnt + 1) (i + 1)
    else loop cnt (i + 1)
;

value uncle_label conf x p side =
  let is = index_of_sex p.sex in
  match x with
  [ 1 ->
      let txt = transl conf "an uncle/an aunt" in
      let is = if nb_fields txt == 4 && side == Female then is + 2 else is in
      nth_field txt is
  | 2 ->
      let txt = transl conf "a great-uncle/a great-aunt" in
      let is = if nb_fields txt == 4 && side == Female then is + 2 else is in
      nth_field txt is
  | n ->
      transl_nth conf "an uncle/an aunt" is ^ " " ^
        Printf.sprintf (ftransl conf "of the %s generation")
          (transl_nth conf "nth (generation)" n) ]
;

value uncle_in_law_label conf sex side =
  let is = index_of_sex sex in
  let txt = transl conf "an uncle (aunt's husband)/an aunt (uncle's wife)" in
  let is = if nb_fields txt == 4 && side == Female then is + 2 else is in
  nth_field txt is
;

value nephew_label conf x p =
  let is = index_of_sex p.sex in
  match x with
  [ 1 -> transl_nth conf "a nephew/a niece" is
  | 2 -> transl_nth conf "a great-nephew/a great-niece" is
  | n ->
      transl_nth conf "a nephew/a niece" is ^ " " ^
        Printf.sprintf (ftransl conf "of the %s generation")
          (transl_nth conf "nth (generation)" n) ]
;

value nephew_in_law_label conf sex =
  let is = index_of_sex sex in
  transl_nth conf "a nephew (spouse's nephew)/a niece (spouse's niece)" is
;

value same_parents base p1 p2 =
  (aoi base p1.cle_index).parents = (aoi base p2.cle_index).parents
;

value ancestors_n base =
  loop [] where rec loop list n ip =
    if n == 0 then [(aoi base ip).parents :: list]
    else
      match (aoi base ip).parents with
      [ Some ifam ->
          let cpl = coi base ifam in
          let list = loop list (n - 1) cpl.father in
          let list = loop list (n - 1) cpl.mother in
          list
      | None -> list ]
;

value uncle_relation_side base p1 p2 x2 =
  let a_fam = (aoi base p1.cle_index).parents in
  match (aoi base p2.cle_index).parents with
  [ Some ifam ->
      let cpl = coi base ifam in
      let fath_side = ancestors_n base (x2 - 2) cpl.father in
      let moth_side = ancestors_n base (x2 - 2) cpl.mother in
      if List.mem a_fam fath_side then Male
      else if List.mem a_fam moth_side then Female
      else Neuter
  | None -> Neuter ]
;

value print_link conf base n p1 p2 pp1 pp2 x1 x2 =
  let (p1, pp1, x1, p2, pp2, x2) =
    if p1.sex <> Neuter then (p1, pp1, x1, p2, pp2, x2)
    else (p2, pp2, x2, p1, pp1, x1)
  in
  do afficher_personne_sans_titre conf base p1;
     afficher_titre conf base p1;
     Wserver.wprint " %s" (transl conf "is");
     if n > 1 then Wserver.wprint " %s" (transl conf "also") else ();
     Wserver.wprint "\n";
     let (s, sp1, sp2) =
       let ini_p1 = p1 and ini_p2 = p2 in
       let p1 = match pp1 with [ Some p1 -> p1 | _ -> p1 ] in
       let p2 = match pp2 with [ Some p2 -> p2 | _ -> p2 ] in
       let sp1 = pp1 <> None in
       let sp2 = pp2 <> None in
       if x1 == 0 then
         if sp2 && x2 == 1 then
           (parent_in_law_label conf ini_p1.sex, sp1, False)
         else (ancestor_label conf x2 p1.sex, sp1, sp2)
       else if x2 == 0 then
         if sp1 && x1 == 1 then
           (child_in_law_label conf ini_p1.sex, False, sp2)
         else (descendant_label conf x1 p1, sp1, sp2)
       else if x1 == x2 then
         if x1 == 1 && not (same_parents base p1 p2) then
           (half_brother_label conf p1.sex, sp1, sp2)
         else if x1 == 1 && (sp1 || sp2) && p1.sex <> Neuter then
           (brother_in_law_label conf ini_p1.sex, False, False)
         else (brother_label conf x2 p1.sex, sp1, sp2)
       else if x1 == 1 then
         let side =
           if x2 <= 3 then uncle_relation_side base p1 p2 x2 else Neuter
         in
         if x2 == 2 && sp1 then
           (uncle_in_law_label conf ini_p1.sex side, False, sp2)
         else (uncle_label conf (x2 - x1) p1 side, sp1, sp2)
       else if x2 == 1 then
         if x1 == 2 && x2 == 1 && sp2 then
           (nephew_in_law_label conf p1.sex, sp1, False)
         else (nephew_label conf (x1 - x2) p1, sp1, sp2)
       else if x1 < x2 then
         let s =
           transl_decline2 conf "%1 of (same or greater generation level) %2"
             (brother_label conf x1 p1.sex)
             (ancestor_label conf (x2 - x1) Neuter)
         in
         (s, sp1, sp2)
       else
         let s =
           transl_decline2 conf "%1 of (same or greater generation level) %2"
             (descendant_label conf (x1 - x2) p1)
             (brother_label conf x2 Male)
         in
         (s, sp1, sp2)
     in
     let s =
       if sp1 then
         transl_decline2 conf "%1 of (same or greater generation level) %2"
           (transl_nth conf "the spouse" (index_of_sex p1.sex)) s
       else s
     in
     let s =
       if sp2 then
         transl_decline2 conf "%1 of (same or greater generation level) %2"
           s (transl_nth conf "the spouse" (1 - index_of_sex p2.sex))
       else s
     in
     let s1 = "<strong>" ^ std_color conf s ^ "</strong>" in     
     let s2 = gen_person_title_text raw_access conf base p2 in
     let s =
       if x1 < x2 then transl_decline2 conf "%1 of %2" s1 s2
       else
         transl_decline2 conf "%1 of (same or greater generation level) %2"
           s1 s2
     in
     Wserver.wprint "%s.\n" (nominative s);
  return ()
;

value wprint_num conf n =
  Num.print (fun x -> Wserver.wprint "%s" x)
    (transl conf "(thousand separator)") n
;

value string_of_big_int conf i =
  let sep = transl conf "(thousand separator)" in
  let rec glop i =
    if i == 0 then ""
    else
      let s = glop (i / 1000) in
      if s = "" then string_of_int (i mod 1000)
      else s ^ sep ^ Printf.sprintf "%03d" (i mod 1000)
  in
  glop i
;

value print_solution_ancestor conf base long p1 p2 pp1 pp2 x1 x2 list =
  let image_opt =
    match p_getenv conf.env "image" with
    [ Some "on" -> ";image=on"
    | _ -> "" ]
  in
  tag "ul" begin
    List.iter
      (fun (a, n) ->
         do html_li conf;
            Wserver.wprint "<em>%s %s" (string_of_big_int conf n)
              (transl_nth conf "branch/branches" (if n = 1 then 0 else 1));
            if not long then
              let propose_dag =
                n > 1 && n <= 10 && not (browser_doesnt_have_tables conf)
              in
              do Wserver.wprint ":\n%s " (transl conf "click");
                 let dp1 = match pp1 with [ Some p -> p | _ -> p1 ] in
                 let dp2 = match pp2 with [ Some p -> p | _ -> p2 ] in
                 Wserver.wprint
                   "<a href=\"%sm=RL;%s;l1=%d;%s;l2=%d;%s%s%s%s%s\">"
                   (commd conf) (acces conf base a) x1
                   (acces_n conf base "1" dp1) x2 (acces_n conf base "2" dp2)
                   (if pp1 = None then ""
                    else ";" ^ acces_n conf base "3" p1)
                   (if pp2 = None then ""
                    else ";" ^ acces_n conf base "4" p2)
                   (if propose_dag then ";dag=on" else "")
                   image_opt;
                 Wserver.wprint "%s</a>" (transl conf "here");
                 if n > 1 && not propose_dag then
                   Wserver.wprint "%s"
                     (transl conf " to see the first branch")
                 else ();
              return ()
            else ();
            Wserver.wprint ".</em>\n";
         return ())
      list;
  end
;

value print_solution_not_ancestor conf base long p1 p2 pp1 pp2 x1 x2 list =
  let image_opt =
    match p_getenv conf.env "image" with
    [ Some "on" -> ";image=on"
    | _ -> "" ]
  in
  do Wserver.wprint "<ul>\n";
     html_li conf;
     Wserver.wprint "%s\n" (capitale (transl conf "indeed,"));
     tag "ul" begin
       List.iter
         (fun (a, n) ->
            do html_li conf;
               afficher_personne_sans_titre conf base a;
               afficher_titre conf base a;
               Wserver.wprint "\n<em>(";
               Wserver.wprint "%d %s" n
                 (transl_nth conf "relationship link/relationship links"
                    (if n = 1 then 0 else 1));
               if not long then
                 let propose_dag =
                   n > 1 && n <= 10 && not (browser_doesnt_have_tables conf)
                 in
                 do Wserver.wprint ":\n%s" (transl conf "click");
                    let dp1 = match pp1 with [ Some p -> p | _ -> p1 ] in
                    let dp2 = match pp2 with [ Some p -> p | _ -> p2 ] in
                    Wserver.wprint
                      " <a href=\"%sm=RL;%s;l1=%d;%s;l2=%d;%s%s%s%s%s\">"
                      (commd conf) (acces conf base a) x1
                      (acces_n conf base "1" dp1) x2
                      (acces_n conf base "2" dp2)
                      (if pp1 = None then ""
                       else ";" ^ acces_n conf base "3" p1)
                      (if pp2 = None then ""
                       else ";" ^ acces_n conf base "4" p2)
                      (if propose_dag then ";dag=on" else "")
                      image_opt;
                    Wserver.wprint "%s</a>" (transl conf "here");
                    if n > 1 && not propose_dag then
                      Wserver.wprint "%s"
                        (transl conf " to see the first relationship link")
                    else ();
                 return ()
               else ();
               Wserver.wprint "</em>).\n";
            return ())
         list;
     end;
     let is_are =
       match list with
       [ [_] -> transl conf "is"
       | _ -> transl conf "are" ]
     in
     Wserver.wprint "%s %s\n" is_are (transl conf "at the same time");
  return
  let lab x =
    match list with
    [ [(a, _)] -> ancestor_label conf x a.sex
    | _ -> parents_label conf x ]
  in
  do tag "ul" begin
       html_li conf;
       let s = gen_person_title_text raw_access conf base p1 in
       let s =
         if pp1 = None then s
         else
           transl_decline2 conf "%1 of (same or greater generation level) %2"
             (transl_nth conf "the spouse" (1 - index_of_sex p1.sex)) s
       in
       let s = transl_decline2 conf "%1 of %2" (lab x1) s in
       Wserver.wprint "%s\n" s;
       html_li conf;
       let s = gen_person_title_text raw_access conf base p2 in
       let s =
         if pp2 = None then s
         else
           transl_decline2 conf "%1 of (same or greater generation level) %2"
             (transl_nth conf "the spouse" (1 - index_of_sex p2.sex)) s
       in
       let s = transl_decline2 conf "%1 of %2" (lab x2) s in
       Wserver.wprint "%s\n" s;
     end;
     Wserver.wprint "</ul>\n";
  return ()
;

value print_solution conf base long n p1 p2 (pp1, pp2, (x1, x2, list)) =
  do print_link conf base n p2 p1 pp2 pp1 x2 x1;
     if x1 == 0 || x2 == 0 then
       print_solution_ancestor conf base long p1 p2 pp1 pp2 x1 x2 list
     else print_solution_not_ancestor conf base long p1 p2 pp1 pp2 x1 x2 list;
     Wserver.wprint "\n";
  return ()
;

open RelationLink;

value max_br = 33;

value print_dag_links conf base p1 p2 rl =
  let module O = struct type t = iper; value compare = compare; end in
  let module M = Map.Make O in
  let anc_map =
    List.fold_left
      (fun anc_map (pp1, pp2, (x1, x2, list)) ->
         List.fold_left
           (fun anc_map (p, n) ->
              let (pp1, pp2, nn, nt, maxlev) =
                try M.find p.cle_index anc_map with
                [ Not_found -> (pp1, pp2, 0, 0, 0) ]
              in
              if nn >= max_br then anc_map
              else
                let v = (pp1, pp2, nn + n, nt + 1, max maxlev (max x1 x2)) in
                M.add p.cle_index v anc_map)
           anc_map list)
      M.empty rl
  in
  let is_anc =
    match rl with
    [ [(_, _, (x1, x2, _)) :: _] -> x1 = 0 || x2 = 0
    | _ -> False ]
  in
  let something =
    M.fold
      (fun ip (_, _, nn, nt, maxlev) something ->
         something || nt > 1 && nn > 1 && nn < max_br)
      anc_map False
  in
  if something then
    let rest = ref False in
    do if is_anc then Wserver.wprint "(" else Wserver.wprint "<ul>\n";
       M.iter
         (fun ip (pp1, pp2, nn, nt, maxlev) ->
            let dp1 = match pp1 with [ Some p -> p | _ -> p1 ] in
            let dp2 = match pp2 with [ Some p -> p | _ -> p2 ] in
            if nt > 1 && nn > 1 && nn < max_br then
              let a = poi base ip in
              do if is_anc then () else html_li conf;
                 if not is_anc then
                   do afficher_personne_sans_titre conf base a;
                      afficher_titre conf base a;
                      Wserver.wprint ":\n";
                   return ()
                 else ();
                 Wserver.wprint "<a href=\"%sm=RL" (commd conf);
                 Wserver.wprint ";%s" (acces conf base a);
                 Wserver.wprint ";%s" (acces_n conf base "1" dp1);
                 Wserver.wprint ";%s" (acces_n conf base "2" dp2);
                 if pp1 = None then ()
                 else Wserver.wprint ";%s" (acces_n conf base "2" p1);
                 if pp2 = None then ()
                 else Wserver.wprint ";%s" (acces_n conf base "4" p2);
                 let (l1, l2) =
                   List.fold_left
                     (fun (l1, l2) (_, _, (x1, x2, list)) ->
                        List.fold_left
                          (fun (l1, l2) (a, _) ->
                             if a.cle_index = ip then
                               let l1 =
                                 if List.mem x1 l1 then l1 else [x1 :: l1]
                               in
                               let l2 =
                                 if List.mem x2 l2 then l2 else [x2 :: l2]
                               in
                               (l1, l2)
                             else (l1, l2))
                          (l1, l2) list)
                     ([], []) rl
                 in
                 do Wserver.wprint ";l1=";
                    let _ = List.fold_right
                      (fun x sep -> do Wserver.wprint "%s%d" sep x; return ",")
                      l1 ""
                    in ();
                    Wserver.wprint ";l2=";
                    let _ = List.fold_right
                      (fun x sep -> do Wserver.wprint "%s%d" sep x; return ",")
                      l2 ""
                    in ();
                 return ();
                 Wserver.wprint ";dag=on\">";
                 if is_anc then Wserver.wprint "%s" (transl conf "tree")
                 else
                   Wserver.wprint "%d %s" nn
                     (transl_nth conf "relationship link/relationship links"
                        1);
                 Wserver.wprint "</a>";
                 if is_anc then () else Wserver.wprint "\n";
              return ()
            else rest.val := True)
         anc_map;
       if rest.val then do html_li conf; Wserver.wprint "...\n"; return ()
       else ();
       if is_anc then Wserver.wprint ")\n" else Wserver.wprint "</ul>\n";
    return ()
  else ()
;

value print_propose_upto conf base p1 p2 rl =
  match rl with
  [ [(None, None, (x1, x2, _)) :: _] when x1 == 0 || x2 == 0 ->
      let maxlen =
        List.fold_right
          (fun (_, _, (x1, x2, _)) maxlen -> max maxlen (max x1 x2)) rl 0
      in
      let (p, a) = if x1 == 0 then (p2, p1) else (p1, p2) in
      do html_p conf;
         Wserver.wprint "<font size=-1>";
         Wserver.wprint "%s"
           (capitale
              (transl_decline2 conf "%1 of %2" (transl conf "ancestors")
                 (person_title_text conf base p)));
         Wserver.wprint " <em>%s</em>\n" (transl conf "up to");
         afficher_personne_titre conf base a;
         Wserver.wprint ":\n<em>%s\n" (transl conf "click");
         Wserver.wprint "<a href=\"%sm=A;t=D;%s;%s;l=%d\">" (commd conf)
           (acces conf base p) (acces_n conf base "1" a) maxlen;
         Wserver.wprint "%s</a>" (transl conf "here");
         Wserver.wprint ".</em></font>\n";
      return ()
  | _ -> () ]
;

value compute_simple_relationship conf base tstab p1 p2 =
  let tab = Consang.make_relationship_table base tstab in
  let (relationship, ancestors) =
    Consang.relationship_and_links base tab True p1.cle_index p2.cle_index
  in
  if ancestors = [] then None
  else
    let total =
      List.fold_left
        (fun n i ->
           let u = tab.Consang.info.(i) in
           List.fold_left
             (fun n (_, n1) ->
                let n1 = Num.of_int n1 in
                List.fold_left
                  (fun n (_, n2) -> Num.add n (Num.mul n1 n2)) n
                  u.Consang.lens1)
             n u.Consang.lens2)
        Num.zero ancestors
    in 
    let rl =
      List.fold_left
        (fun rl i ->
           let u = tab.Consang.info.(i) in
           let p = base.data.persons.get i in
           List.fold_left
             (fun rl (len1, n1) ->
                List.fold_left
                  (fun rl (len2, n2) -> [(len1, len2, (p, n1 * n2)) :: rl]) rl
                  u.Consang.lens2)
             rl u.Consang.lens1)
        [] ancestors
    in
    let rl =
      Sort.list
        (fun (len11, len12, _) (len21, len22, _) ->
           if len11 + len12 > len21 + len22 then True
           else if len11 + len12 < len21 + len22 then False
           else len11 >= len21)
        rl
    in
    let rl =
      List.fold_left
        (fun l (len1, len2, sol) ->
           match l with
           [ [(l1, l2, sols) :: l] when len1 == l1 && len2 == l2 ->
               [(l1, l2, [sol :: sols]) :: l]
           | _ -> [(len1, len2, [sol]) :: l] ])
        [] rl
    in
    Some (rl, total, relationship)
;

value known_spouses_list base p excl_p =
  let u = uoi base p.cle_index in
  List.fold_left
    (fun spl ifam ->
       let sp = poi base (spouse p.cle_index (coi base ifam)) in
       if sou base sp.first_name <> "?" && sou base sp.surname <> "?" &&
          sp.cle_index <> excl_p.cle_index then
         [sp :: spl]
       else spl)
    [] (Array.to_list u.family)
;

value merge_relations rl1 rl2 =
  Sort.merge
    (fun (po11, po12, (l11, l12, _)) (po21, po22, (l21, l22, _)) ->
       if l11 + l12 < l21 + l22 then True
       else if l11 + l12 > l21 + l22 then False
       else if l11 < l21 then True
       else if l11 > l21 then False
       else if po11 = None && po12 = None then True
       else if po21 = None && po22 = None then False
       else if po11 = None || po21 = None then True
       else if po21 = None || po22 = None then False
       else True)
    rl1 rl2
;

value combine_relationship conf base tstab pl1 pl2 f_sp1 f_sp2 =
  List.fold_right
    (fun p1 sl ->
       List.fold_right
         (fun p2 sl ->
            let sol = compute_simple_relationship conf base tstab p1 p2 in
            match sol with
            [ Some (rl, total, _) ->
                let s = List.map (fun r -> (f_sp1 p1, f_sp2 p2, r)) rl in
                [(s, total) :: sl]
            | None -> sl ])
         pl2 sl)
    pl1
;

value sp p = Some p;
value no_sp p = None;

value compute_relationship conf base by_marr p1 p2 =
  if p1.cle_index == p2.cle_index then None
  else
    let _ = base.data.ascends.array () in
    let _ = base.data.couples.array () in
    let tstab = Util.create_topological_sort conf base in
    let sol = compute_simple_relationship conf base tstab p1 p2 in
    let sol_by_marr =
      if by_marr then
        let spl1 = known_spouses_list base p1 p2 in
        let spl2 = known_spouses_list base p2 p1 in
        let sl = [] in
        let sl =
          match sol with
          [ Some ([(_, 0, _) :: _], _, _) -> sl
          | _ -> combine_relationship conf base tstab [p1] spl2 no_sp sp sl ]
        in
        let sl =
          match sol with
          [ Some ([(0, _, _) :: _], _, _) -> sl
          | _ -> combine_relationship conf base tstab spl1 [p2] sp no_sp sl ]
        in
        match (sol, sl) with
        [ (Some ([(x1, x2, _) :: _], _, _), _) when x1 == 0 || x2 == 0 -> sl
        | (_, [([(_, _, (x1, x2, _)) :: _], _) :: _])
          when x1 == 0 || x2 == 0 ->
            sl
        | _ -> combine_relationship conf base tstab spl1 spl2 sp sp sl ]
      else []
    in
    let (all_sol, rel) =
      match sol with
      [ Some (rl, total, rel) ->
          let s = List.map (fun r -> (None, None, r)) rl in
          ([(s, total) :: sol_by_marr], rel)
      | None -> (sol_by_marr, 0.0) ]
    in
    let (sl, total) =
      List.fold_right
        (fun (rl1, total1) (rl, total) ->
           (merge_relations rl1 rl, Num.add total1 total))
        all_sol ([], Num.zero)
    in
    if sl = [] then None else Some (sl, total, rel)
;

value print_one_path conf base found a p1 p2 pp1 pp2 l1 l2 =
  let ip = a.cle_index in
  let sp1 = match pp1 with [ Some _ -> Some p1 | _ -> None ] in
  let sp2 = match pp2 with [ Some _ -> Some p2 | _ -> None ] in
  let p1 = match pp1 with [ Some p1 -> p1 | _ -> p1 ] in
  let p2 = match pp2 with [ Some p2 -> p2 | _ -> p2 ] in
  let ip1 = p1.cle_index in
  let ip2 = p2.cle_index in
  let dist = make_dist_tab conf base ip (max l1 l2 + 1) in
  let b1 = find_first_branch base dist ip l1 ip1 Neuter in
  let b2 = find_first_branch base dist ip l2 ip2 Neuter in
  match (b1, b2) with
  [ (Some b1, Some b2) ->
      let info =
        {ip = ip; sp = a.sex; ip1 = ip1; ip2 = ip2; b1 = b1; b2 = b2; c1 = 1;
         c2 = 1; pb1 = None; pb2 = None; nb1 = None; nb2 = None; sp1 = sp1;
         sp2 = sp2}
      in
      if List.mem (b1, b2) found.val then ()
      else
        do tag "center" begin
             tag "table" "border=1" begin
               tag "tr" begin
                 tag "td" begin
                   RelationLink.print_relation_path conf base info;
                 end;
               end;
             end;
           end;
           html_p conf;
           found.val := [(b1, b2) :: found.val];
        return ()
  | _ -> () ]
;

value print_path conf base i p1 p2 (pp1, pp2, (l1, l2, list)) =
  let found = ref [] in
  do List.iter
       (fun (a, n) -> print_one_path conf base found a p1 p2 pp1 pp2 l1 l2)
       list;
     Wserver.wprint "\n";
  return ()
;

value print_main_relationship conf base long p1 p2 rel =
  let title _ = Wserver.wprint "%s" (capitale (transl conf "relationship")) in
  do header conf title;
     print_link_to_welcome conf True;
     match p_getenv conf.env "spouse" with
     [ Some "on" -> conf.senv := conf.senv @ [("spouse", "on")]
     | _ -> () ];
     match p_getenv conf.env "cgl" with
     [ Some "on" -> conf.senv := conf.senv @ [("cgl", "on")]
     | _ -> () ];
     match rel with
     [ None ->
         if p1.cle_index == p2.cle_index then
           Wserver.wprint "%s\n"
             (capitale (transl conf "it is the same person!"))
         else
           Wserver.wprint "%s\n"
             (capitale
                (cftransl conf "no known relationship link between %s and %s"
                   [gen_referenced_person_title_text raw_access conf base p1;
                    gen_referenced_person_title_text raw_access conf base p2]))
     | Some (rl, total, relationship) ->
         let a1 = aoi base p1.cle_index in
         let a2 = aoi base p2.cle_index in
         let all_by_marr =
           List.for_all
             (fun
              [ (Some _, _, _) | (_, Some _, _) -> True
              | _ -> False ])
             rl
         in
         do let _ =
              List.fold_left
                (fun i sol ->
                   do print_solution conf base long i p1 p2 sol;
                      if long then print_path conf base i p1 p2 sol else ();
                   return succ i)
                1 rl
            in
            ();
            Wserver.wprint "\n";
            html_p conf;
            Wserver.wprint "%s: <em>" (capitale (transl conf "total"));
            wprint_num conf total;
            Wserver.wprint "</em> %s\n"
              (transl_nth conf "relationship link/relationship links"
                 (if Num.eq total Num.one then 0 else 1));
            if long || browser_doesnt_have_tables conf then ()
            else print_dag_links conf base p1 p2 rl;
            if not all_by_marr &&
               age_autorise conf base p1 && age_autorise conf base p2 &&
               a1.consang != Adef.fix (-1) && a2.consang != Adef.fix (-1) then
              do html_p conf;
                 Wserver.wprint "<em>%s: "
                   (capitale (transl conf "relationship"));
                 print_decimal_num conf
                   (round_2_dec
                      (Adef.float_of_fix (Adef.fix_of_float relationship) *.
                         100.0));
                 Wserver.wprint "%%</em>";
                 html_p conf;
              return ()
            else ();
            print_propose_upto conf base p1 p2 rl;
         return () ];
     trailer conf;
  return ()
;

value print_multi_relation conf base pl lim assoc_txt =
  let (pl1, pl2) =
    if lim <= 0 then (pl, [])
    else
      loop lim [] pl where rec loop n rev_pl1 pl2 =
        match (n, pl2) with
        [ (_, []) | (_, [_]) -> (pl, [])
        | (0, _) ->
            match rev_pl1 with
            [ [p :: _] -> (List.rev rev_pl1, [p :: pl2])
            | _ -> (pl, []) ]
        | (n, [p :: pl]) -> loop (n - 1) [p :: rev_pl1] pl ]
  in
  let path =
    loop [] pl1 where rec loop path =
      fun
      [ [p1 :: ([p2 :: _] as pl)] ->
          let ip1 = p1.cle_index in
          let ip2 = p2.cle_index in
          match get_shortest_path_relation base ip1 ip2 [] with
          [ Some (path1, _) ->
              let path =
                match path with
                [ [] -> path1
                | _ ->
                    match List.rev path1 with
                    [ [_ :: path1] -> List.rev path1 @ path
                    | [] -> path ] ]
              in
              loop path pl
          | None -> path ]
      | [_] | [] -> path ]
  in
  let title _ = Wserver.wprint "%s" (capitale (transl conf "relationship")) in
  let print_elem conf base p =
    do Wserver.wprint "%s" (Util.referenced_person_title_text conf base p);
       Wserver.wprint "%s" (Date.short_dates_text conf base p);
       try
         let t = Hashtbl.find assoc_txt p.cle_index in
         Wserver.wprint " <b>(%s)</b>" t
       with
       [ Not_found -> () ];
    return ()
  in
  do header_no_page_title conf title;
     print_relation_path_dag conf base print_elem path;
     match pl2 with
     [ [] -> ()
     | _ ->
         do Wserver.wprint "<p>\n<a href=\"%sm=RLM" (commd conf);
            let _ = List.fold_left
              (fun n p ->
                 do Wserver.wprint ";i%d=%d" n (Adef.int_of_iper p.cle_index);
                    try
                      let t = Hashtbl.find assoc_txt p.cle_index in
                      Wserver.wprint ";t%d=%s" n t
                    with
                    [ Not_found -> () ];
                 return n + 1)
              1 pl2
            in ();
            if lim > 0 then Wserver.wprint ";lim=%d" lim else ();
            Wserver.wprint "\">&gt;&gt;</a>\n";
         return () ];
     trailer conf;
  return ()
;

value print_base_loop conf base p =
  let title _ = Wserver.wprint "%s" (capitale (transl conf "error")) in
  do rheader conf title;
     Wserver.wprint
       (fcapitale
          (ftransl conf "loop in data base: %s is his/her own ancestor"))
       (reference conf base p (person_text conf base p));
     Wserver.wprint ".\n";
     trailer conf;
  return ()
;

value print conf base p =
  fun
  [ Some p1 ->
      match p_getenv conf.env "et" with
      [ Some "S" -> print_shortest_path conf base p1 p
      | x ->
          let by_marr = x = Some "M" in
          let long =
            match p_getenv conf.env "long" with
            [ Some "on" -> True
            | _ -> False ]
          in
          match
            try Left (compute_relationship conf base by_marr p1 p) with
            [ Consang.TopologicalSortError ip -> Right ip ]
          with
          [ Left rel -> print_main_relationship conf base long p1 p rel
          | Right p -> print_base_loop conf base p ] ]
  | None -> print_menu conf base p ]
;

value print_multi conf base =
  let assoc_txt = Hashtbl.create 53 in
  let pl =
    loop [] 1 where rec loop pl i =
      let k = string_of_int i in
      match find_person_in_env conf base k with
      [ Some p ->
          do match p_getenv conf.env ("t" ^ k) with
             [ Some x -> Hashtbl.add assoc_txt p.cle_index x
             | None -> () ];
          return loop [p :: pl] (i + 1)
      | None -> List.rev pl ]
  in
  let lim =
    match p_getint conf.env "lim" with
    [ Some x -> x
    | None -> 0 ]
  in
  print_multi_relation conf base pl lim assoc_txt
;
