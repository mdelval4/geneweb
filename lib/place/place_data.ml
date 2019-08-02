open Place_types

let countries =
  [|Afghanistan,[|"Afghanistan"|]
   ;Albania,[|"Albanie";"Albania"|]
   ;Algeria,[|"Algérie";"Algeria";"Algérie française"|]
   ;Andorra,[|"Andorre";"Andorra"|]
   ;Angola,[|"Angola"|]
   ;Antigua_and_Barbuda,[|"Antigua-et-Barbuda";"Antigue-et-Barbude";"Antigua and Barbuda"|]
   ;Argentina,[|"Argentine";"Argentina"|]
   ;Armenia,[|"Arménie";"Armenia"|]
   ;Australia,[|"Australie";"Australia"|]
   ;Austria,[|"Autriche";"Austria"|]
   ;Azerbaijan,[|"Azerbaïdjan";"Azerbaijan"|]
   ;The_Bahamas,[|"Bahamas";"The Bahamas"|]
   ;Bahrain,[|"Bahreïn";"Bahrain"|]
   ;Bangladesh,[|"Bangladesh"|]
   ;Barbados,[|"Barbade";"Barbados"|]
   ;Belarus,[|"Biélorussie";"Belarus"|]
   ;Belgium,[|"Belgique";"Belgium"|]
   ;Belize,[|"Belize"|]
   ;Benin,[|"Bénin";"Benin"|]
   ;Bhutan,[|"Bhoutan";"Bhutan"|]
   ;Bolivia,[|"Bolivie";"Bolivia"|]
   ;Bosnia_and_Herzegovina,[|"Bosnie-Herzégovine";"Bosnia and Herzegovina"|]
   ;Botswana,[|"Botswana"|]
   ;Brazil,[|"Brésil";"Brazil"|]
   ;Brunei,[|"Brunei"|]
   ;Bulgaria,[|"Bulgarie";"Bulgaria"|]
   ;Burkina_Faso,[|"Burkina Faso"|]
   ;Burundi,[|"Burundi"|]
   ;Cabo_Verde,[|"Cap-Vert";"Cabo Verde"|]
   ;Cambodia,[|"Cambodge";"Cambodia"|]
   ;Cameroon,[|"Cameroun";"Cameroon"|]
   ;Canada,[|"Canada"|]
   ;Central_African_Republic,[|"République centrafricaine";"Central African Republic"|]
   ;Chad,[|"Tchad";"Chad"|]
   ;Chile,[|"Chili";"Chile"|]
   ;China,[|"Chine";"China"|]
   ;Colombia,[|"Colombie";"Colombia"|]
   ;Comoros,[|"Comores";"Comoros"|]
   ;Democratic_Republic_of_the_Congo,[|"Congo-Kinshasa";"République démocratique du Congo";"Zaïre";"Democratic Republic of the Congo"|]
   ;Republic_of_the_Congo,[|"Congo";"Congo-Brazzaville";"Republic of the Congo"|]
   ;Costa_Rica,[|"Costa Rica"|]
   ;Cote_d_Ivoire,[|"Côte d’Ivoire";"Ivory Coast"|]
   ;Croatia,[|"Croatie";"Croatia"|]
   ;Cuba,[|"Cuba"|]
   ;Cyprus,[|"Chypre";"Cyprus"|]
   ;Czech_Republic,[|"Tchéquie";"République tchèque";"Czech Republic"|]
   ;Denmark,[|"Danemark";"Denmark"|]
   ;Djibouti,[|"Djibouti"|]
   ;Dominica,[|"Dominique";"Dominica"|]
   ;Dominican_Republic,[|"République dominicaine";"Dominican Republic"|]
   ;East_Timor,[|"Timor oriental";"East Timor";"Timor-Leste"|]
   ;Ecuador,[|"Équateur";"Ecuador"|]
   ;Egypt,[|"Égypte";"Egypt"|]
   ;El_Salvador,[|"Salvador";"El Salvador"|]
   ;Equatorial_Guinea,[|"Guinée équatoriale";"Equatorial Guinea"|]
   ;Eritrea,[|"Érythrée";"Eritrea"|]
   ;Estonia,[|"Estonie";"Estonia"|]
   ;Eswatini,[|"Eswatini"|]
   ;Ethiopia,[|"Éthiopie";"Ethiopia"|]
   ;Fiji,[|"Fidji"|]
   ;Finland,[|"Finlande";"Finland"|]
   ;France,[|"France"|]
   ;Gabon,[|"Gabon"|]
   ;The_Gambia,[|"Gambie";"The Gambia"|]
   ;Georgia,[|"Géorgie";"Georgia"|]
   ;Germany,[|"Allemagne";"Germany"|]
   ;Ghana,[|"Ghana"|]
   ;Greece,[|"Grèce";"Greece"|]
   ;Grenada,[|"Grenade";"Grenada"|]
   ;Guatemala,[|"Guatemala"|]
   ;Guinea,[|"Guinée";"Guinea"|]
   ;Guinea_Bissau,[|"Guinée-Bissau";"Guinea-Bissau"|]
   ;Guyana,[|"Guyana"|]
   ;Haiti,[|"Haïti";"Haiti"|]
   ;Honduras,[|"Honduras"|]
   ;Hungary,[|"Hongrie";"Hungary"|]
   ;Iceland,[|"Islande";"Iceland"|]
   ;India,[|"Inde";"India"|]
   ;Indonesia,[|"Indonésie";"Indonesia"|]
   ;Iran,[|"Iran"|]
   ;Iraq,[|"Irak";"Iraq"|]
   ;Ireland,[|"Irlande"|]
   ;Israel,[|"Israël";"Israel"|]
   ;Italy,[|"Italy";"Italie"|]
   ;Jamaica,[|"Jamaïque";"Jamaica"|]
   ;Japan,[|"Japon";"Japan"|]
   ;Jordan,[|"Jordanie";"Jordan"|]
   ;Kazakhstan,[|"Kazakhstan"|]
   ;Kenya,[|"Kenya"|]
   ;Kiribati,[|"Kiribati"|]
   ;North_Korea,[|"Corée du Nord"|]
   ;South_Korea,[|"Corée du Sud"|]
   ;Kosovo,[|"Kosovo"|]
   ;Kuwait,[|"Koweït";"Kuwait"|]
   ;Kyrgyzstan,[|"Kirghizistan";"Kyrgyzstan"|]
   ;Laos,[|"Laos"|]
   ;Latvia,[|"Lettonie";"Latvia"|]
   ;Lebanon,[|"Liban";"Lebanon"|]
   ;Lesotho,[|"Lesotho"|]
   ;Liberia,[|"Libéria";"Liberia"|]
   ;Libya,[|"Libye";"Libya"|]
   ;Liechtenstein,[|"Liechtenstein"|]
   ;Lithuania,[|"Lituanie";"Lithuania"|]
   ;Luxembourg,[|"Luxembourg"|]
   ;Madagascar,[|"Madagascar"|]
   ;Malawi,[|"Malawi"|]
   ;Malaysia,[|"Malaisie";"Malaysia"|]
   ;Maldives,[|"Maldives"|]
   ;Mali,[|"Mali"|]
   ;Malta,[|"Malte"|]
   ;Marshall_Islands,[|"Îles Marshall";"Marshall Islands"|]
   ;Mauritania,[|"Mauritanie"|]
   ;Mauritius,[|"Maurice";"Mauritius"|]
   ;Mexico,[|"Mexique";"Mexico"|]
   ;Moldova,[|"Moldavie";"Moldova"|]
   ;Monaco,[|"Monaco"|]
   ;Mongolia,[|"Mongolie";"Mongolia"|]
   ;Montenegro,[|"Monténégro";"Montenegro"|]
   ;Morocco,[|"Maroc";"Morocco"|]
   ;Mozambique,[|"Mozambique"|]
   ;Myanmar,[|"Myanmar";"Birmanie";"Burma"|]
   ;Namibia,[|"Namibie"|]
   ;Nauru,[|"Nauru"|]
   ;Nepal,[|"Népal";"Nepal"|]
   ;Netherlands,[|"Pays-Bas";"Netherlands"|]
   ;New_Zealand,[|"Nouvelle-Zélande";"New Zealand"|]
   ;Nicaragua,[|"Nicaragua"|]
   ;Niger,[|"Niger"|]
   ;Nigeria,[|"Nigéria";"Nigeria"|]
   ;North_Macedonia,[|"Macédoine du nord";"North Macedonia"|]
   ;Norway,[|"Norvège"|]
   ;Oman,[|"Oman"|]
   ;Pakistan,[|"Pakistan"|]
   ;Palau,[|"Palaos";"Palau"|]
   ;Panama,[|"Panama"|]
   ;Papua_New_Guinea,[|"Papouasie-Nouvelle-Guinée";"Papua New Guinea"|]
   ;Paraguay,[|"Paraguay"|]
   ;Peru,[|"Pérou";"Peru"|]
   ;Philippines,[|"Philippines"|]
   ;Poland,[|"Pologne";"Poland"|]
   ;Portugal,[|"Portugal"|]
   ;Qatar,[|"Qatar"|]
   ;Romania,[|"Roumanie";"Romania"|]
   ;Russia,[|"Russie";"Russia"|]
   ;Rwanda,[|"Rwanda"|]
   ;Saint_Kitts_and_Nevis,[|"Saint-Christophe-et-Niévès";"Saint-Christophe-et-Nevis";"Saint Kitts and Nevis"|]
   ;Saint_Lucia,[|"Sainte-Lucie";"Saint Lucia"|]
   ;Saint_Vincent_and_the_Grenadines,[|"Saint-Vincent-et-les-Grenadines"|]
   ;Samoa,[|"Samoa"|]
   ;San_Marino,[|"Saint-Marin";"San Marino"|]
   ;Sao_Tome_and_Principe,[|"Sao Tomé-et-Principe";"Sao Tome and Principe"|]
   ;Saudi_Arabia,[|"Arabie saoudite";"Saudi Arabia"|]
   ;Senegal,[|"Sénégal";"Senegal"|]
   ;Serbia,[|"Serbie";"Serbia"|]
   ;Seychelles,[|"Seychelles"|]
   ;Sierra_Leone,[|"Sierra Leone"|]
   ;Singapore,[|"Singapour"|]
   ;Slovakia,[|"Slovaquie";"Slovakia"|]
   ;Slovenia,[|"Slovénie";"Slovenia"|]
   ;Solomon_Islands,[|"Îles Salomon";"Solomon Islands"|]
   ;Somalia,[|"Somalie";"Somalia"|]
   ;South_Africa,[|"Afrique du Sud";"South Africa"|]
   ;Spain,[|"Espagne";"Spain"|]
   ;Sri_Lanka,[|"Sri Lanka"|]
   ;Sudan,[|"Soudan";"Sudan"|]
   ;South_Sudan,[|"Soudan du Sud";"South_Sudan"|]
   ;Suriname,[|"Suriname"|]
   ;Sweden,[|"Suède";"Sweden"|]
   ;Switzerland,[|"Suisse";"Switzerland"|]
   ;Syria,[|"Syrie";"Syria"|]
   ;Taiwan,[|"Taïwan";"Taiwan"|]
   ;Tajikistan,[|"Tadjikistan";"Tajikistan"|]
   ;Tanzania,[|"Tanzanie";"Tanzania"|]
   ;Thailand,[|"Thaïlande";"Thailand"|]
   ;Togo,[|"Togo"|]
   ;Tonga,[|"Tonga"|]
   ;Trinidad_and_Tobago,[|"Trinité et Tobago";"Trinidad and Tobago"|]
   ;Tunisia,[|"Tunisie";"Tunisia"|]
   ;Turkey,[|"Turquie";"Turkey"|]
   ;Turkmenistan,[|"Turkménistan";"Turkmenistan"|]
   ;Tuvalu,[|"Tuvalu"|]
   ;Uganda,[|"Ouganda";"Uganda"|]
   ;Ukraine,[|"Ukraine"|]
   ;United_Arab_Emirates,[|"Émirats arabes unis";"United Arab Emirates"|]
   ;United_Kingdom,[|"UK";"Royaume-Uni";"United Kingdom"|]
   ;United_States,[|"US";"USA";"États-Unis";"United States"|]
   ;Uruguay,[|"Uruguay"|]
   ;Uzbekistan,[|"Ouzbékistan";"Uzbekistan"|]
   ;Vanuatu,[|"Vanuatu"|]
   ;Vatican_City,[|"Vatican";"Vatican City"|]
   ;Venezuela,[|"Venezuela"|]
   ;Vietnam,[|"Vietnam"|]
   ;Yemen,[|"Yémen"|]
   ;Zambia,[|"Zambie";"Zambia";"Rhodésie du Nord";"Northern Rhodesia"|]
   ;Zimbabwe,[|"Zimbabwe";"Rhodésie du Sud";"Southern Rhodesia"|]
  |]

let algeria_region =
  [|DZ_Adrar,[|"Adrar"|]
   ;DZ_Chlef,[|"Chlef"|]
   ;DZ_Laghouat,[|"Laghouat"|]
   ;DZ_Oum_El_Bouaghi,[|"Oum El Bouaghi"|]
   ;DZ_Batna,[|"Batna"|]
   ;DZ_Beaia,[|"Béjaïa"|]
   ;DZ_Biskra,[|"Biskra"|]
   ;DZ_Bechar,[|"Béchar"|]
   ;DZ_Blida,[|"Blida"|]
   ;DZ_Bouira,[|"Bouira"|]
   ;DZ_Tamanrasset,[|"Tamanrasset"|]
   ;DZ_Tebessa,[|"Tébessa"|]
   ;DZ_Tlemcen,[|"Tlemcen"|]
   ;DZ_Tiaret,[|"Tiaret"|]
   ;DZ_Tizi_Ouzou,[|"Tizi Ouzou"|]
   ;DZ_Alger,[|"Alger"|]
   ;DZ_Djelfa,[|"Djelfa"|]
   ;DZ_Jijel,[|"Jijel"|]
   ;DZ_Setif,[|"Sétif"|]
   ;DZ_Saida,[|"Saïda"|]
   ;DZ_Skikda,[|"Skikda"|]
   ;DZ_Sidi_Bel_Abbes,[|"Sidi Bel Abbès"|]
   ;DZ_Annaba,[|"Annaba"|]
   ;DZ_Guelma,[|"Guelma"|]
   ;DZ_Constantine,[|"Constantine"|]
   ;DZ_Medea,[|"Médéa"|]
   ;DZ_Mostaganem,[|"Mostaganem"|]
   ;DZ_M_Sila,[|"M'Sila"|]
   ;DZ_Mascara,[|"Mascara"|]
   ;DZ_Ouargla,[|"Ouargla"|]
   ;DZ_Oran,[|"Oran"|]
   ;DZ_El_Bayadh,[|"El Bayadh"|]
   ;DZ_Illizi,[|"Illizi"|]
   ;DZ_Bordj_Bou_Arreridj,[|"Bordj Bou Arreridj"|]
   ;DZ_Boumerdes,[|"Boumerdès"|]
   ;DZ_El_Tarf,[|"El Tarf"|]
   ;DZ_Tindouf,[|"Tindouf"|]
   ;DZ_Tissemsilt,[|"Tissemsilt"|]
   ;DZ_El_Oued,[|"El Oued"|]
   ;DZ_Khenchela,[|"Khenchela"|]
   ;DZ_Souk_Ahras,[|"Souk Ahras"|]
   ;DZ_Tipaza,[|"Tipaza"|]
   ;DZ_Mila,[|"Mila"|]
   ;DZ_Ain_Defla,[|"Aïn Defla"|]
   ;DZ_Naaa,[|"Naâma"|]
   ;DZ_Ai_Teouchent,[|"Aïn Témouchent"|]
   ;DZ_Ghardai,[|"Ghardaïa"|]
   ;DZ_Relizane,[|"Relizane"|]
  |]

let spain_region =
  [|ES_Andalucia,[|"Andalousie";"Andalucía"|]
   ;ES_Aragon,[|"Aragon";"Aragón";"Aragó"|]
   ;ES_Asturias,[|"Asturies";"Asturias";"Asturies"|]
   ;ES_Islas_Baleares,[|"Îles Baléares";"Islas Baleares";"Illes Balears"|]
   ;ES_Canarias,[|"Îles Canaries";"Canarias"|]
   ;ES_Cantabrie,[|"Cantabrie";"Cantabria"|]
   ;ES_Castilla_y_Leon,[|"Castille-et-León";"Castilla y León"|]
   ;ES_Castilla_La_Mancha,[|"Castille-La Manche";"Castilla La Mancha"|]
   ;ES_Cataluna,[|"Catalogne";"Cataluña";"Catalunya"|]
   ;ES_Extremadura,[|"Estrémadure";"Extremadura";"Estremaura"|]
   ;ES_Galicia,[|"Galice";"Galicia"|]
   ;ES_Comunidad_de_Madrid,[|"Communauté de Madrid";"Comunidad de Madrid"|]
   ;ES_Region_de_Murcia,[|"Région de Murcie";"Región de Murcia"|]
   ;ES_Navarra,[|"Navarre";"Navarra";"Nafarroa"|]
   ;ES_Pais_Vasco,[|"Pays basque";"País Vasco";"Euskadi"|]
   ;ES_La_Rioja,[|"La Rioja"|]
   ;ES_Comunidad_Valenciana,[|"Communauté valencienne";"Comunidad Valenciana";"Comunitat Valenciana"|]
   ;ES_Ceuta,[|"Ceuta"|]
   ;ES_Melilla,[|"Melilla"|]
  |]

let [@warning "-42"] france_region =
  [|FR_Auvergne_Rhone_Alpes,[|"Auvergne-Rhône-Alpes";"Auvergne";"Rhône-Alpes"|]
   ;FR_Bourgogne_Franche_Comte,[|"Bourgogne-Franche-Comté";"Bourgogne";"Franche-Comté"|]
   ;FR_Bretagne,[|"Bretagne"|]
   ;FR_Centre_Val_de_Loire,[|"Centre-Val de Loire";"Centre"|]
   ;FR_Corse,[|"Corse"|]
   ;FR_Grand_Est,[|"Grand Est";"Alsace";"Champagne-Ardenne";"Lorraine"|]
   ;FR_Hauts_de_France,[|"Hauts-de-France";"Nord-Pas-de-Calais";"Picardie"|]
   ;FR_Ile_de_France,[|"Île-de-France"|]
   ;FR_Normandie,[|"Normandie";"Haute-Normandie";"Basse-Normandie"|]
   ;FR_Nouvelle_Aquitaine,[|"Nouvelle-Aquitaine";"Aquitaine";"Limousin";"Poitou-Charentes"|]
   ;FR_Occitanie,[|"Occitanie";"Languedoc-Roussillon";"Midi-Pyrénées"|]
   ;FR_Pays_de_la_Loire,[|"Pays de la Loire"|]
   ;FR_Provence_Alpes_Cote_d_Azur,[|"Provence-Alpes-Côte d'Azur"|]
   ;FR_Guadeloupe,[|"Guadeloupe"|]
   ;FR_Martinique,[|"Martinique"|]
   ;FR_Guyane,[|"Guyane"|]
   ;FR_La_reunion,[|"La réunion"|]
   ;FR_Mayotte,[|"Mayotte"|]
  |]

let south_africa_region =
  [|ZA_Eastern_Cape,[|"Cap-Oriental";"Eastern Cape"|]
   ;ZA_Free_State,[|"État-Libre";"Free State"|]
   ;ZA_Gauteng,[|"Gauteng"|]
   ;ZA_KwaZulu_Natal,[|"KwaZulu-Natal";"KZN";"Natal";"KwaZulu"|]
   ;ZA_Limpopo,[|"Limpopo"|]
   ;ZA_Mpumalanga,[|"Mpumalanga"|]
   ;ZA_North_West,[|"Nord-Ouest";"North West"|]
   ;ZA_Northern_Cape,[|"Cap-Nord";"Northern Cape"|]
   ;ZA_Western_Cape,[|"Cap-Occidental";"Western Cape"|]
  |]

let united_states_region =
  [|US_Alabama,[|"Alabama";"Alabama"|]
   ;US_Alaska,[|"Alaska";"Alaska"|]
   ;US_Arizona,[|"Arizona";"Arizona"|]
   ;US_Arkansas,[|"Arkansas";"Arkansas"|]
   ;US_California,[|"Californie";"California"|]
   ;US_North_Carolina,[|"Caroline du Nord";"North Carolina"|]
   ;US_South_Carolina,[|"Caroline du Sud";"South Carolina"|]
   ;US_Colorado,[|"Colorado";"Colorado"|]
   ;US_Connecticut,[|"Connecticut";"Connecticut"|]
   ;US_North_Dakota,[|"Dakota du Nord";"North Dakota"|]
   ;US_South_Dakota,[|"Dakota du Sud";"South Dakota"|]
   ;US_Delaware,[|"Delaware";"Delaware"|]
   ;US_Florida,[|"Floride";"Florida"|]
   ;US_Georgia,[|"Géorgie";"Georgia"|]
   ;US_Hawaii,[|"Hawaï";"Hawaii"|]
   ;US_Idaho,[|"Idaho";"Idaho"|]
   ;US_Illinois,[|"Illinois";"Illinois"|]
   ;US_Indiana,[|"Indiana";"Indiana"|]
   ;US_Iowa,[|"Iowa";"Iowa"|]
   ;US_Kansas,[|"Kansas";"Kansas"|]
   ;US_Kentucky,[|"Kentucky";"Kentucky"|]
   ;US_Louisiana,[|"Louisiane";"Louisiana"|]
   ;US_Maine,[|"Maine";"Maine"|]
   ;US_Maryland,[|"Maryland";"Maryland"|]
   ;US_Massachusetts,[|"Massachusetts";"Massachusetts"|]
   ;US_Michigan,[|"Michigan";"Michigan"|]
   ;US_Minnesota,[|"Minnesota";"Minnesota"|]
   ;US_Mississippi,[|"Mississippi";"Mississippi"|]
   ;US_Missouri,[|"Missouri";"Missouri"|]
   ;US_Montana,[|"Montana";"Montana"|]
   ;US_Nebraska,[|"Nebraska";"Nebraska"|]
   ;US_Nevada,[|"Nevada";"Nevada"|]
   ;US_New_Hampshire,[|"New Hampshire";"New Hampshire"|]
   ;US_New_Jersey,[|"New Jersey";"New Jersey"|]
   ;US_New_Mexico,[|"Nouveau-Mexique";"New Mexico"|]
   ;US_New_York,[|"New York";"New York"|]
   ;US_Ohio,[|"Ohio";"Ohio"|]
   ;US_Oklahoma,[|"Oklahoma";"Oklahoma"|]
   ;US_Oregon,[|"Oregon";"Oregon"|]
   ;US_Pennsylvania,[|"Pennsylvanie";"Pennsylvania"|]
   ;US_Rhode_Island,[|"Rhode Island";"Rhode Island"|]
   ;US_Tennessee,[|"Tennessee";"Tennessee"|]
   ;US_Texas,[|"Texas";"Texas"|]
   ;US_Utah,[|"Utah";"Utah"|]
   ;US_Vermont,[|"Vermont";"Vermont"|]
   ;US_Virginia,[|"Virginie";"Virginia"|]
   ;US_West_Virginia,[|"Virginie-Occidentale";"West Virginia"|]
   ;US_Washington,[|"Washington";"Washington"|]
   ;US_Wisconsin,[|"Wisconsin";"Wisconsin"|]
   ;US_Wyoming,[|"Wyoming";"Wyoming"|]
  |]

let canada_region =
  [|CA_Alberta,[|"Alberta";"Alberta"|]
   ;CA_British_Columbia,[|"Colombie-Britannique";"British Columbia"|]
   ;CA_Prince_Edward_Island,[|"Île-du-Prince-Édouard";"Prince Edward Island"|]
   ;CA_Manitoba,[|"Manitoba";"Manitoba"|]
   ;CA_New_Brunswick,[|"Nouveau-Brunswick";"New Brunswick"|]
   ;CA_Nova_Scotia,[|"Nouvelle-Écosse";"Nova Scotia"|]
   ;CA_Ontario,[|"Ontario";"Ontario"|]
   ;CA_Quebec,[|"Québec";"Québec"|]
   ;CA_Saskatchewan,[|"Saskatchewan";"Saskatchewan"|]
   ;CA_Newfoundland_and_Labrador,[|"Terre-Neuve-et-Labrador";"Newfoundland and Labrador"|]
   ;CA_Nunavut,[|"Nunavut";"Nunavut"|]
   ;CA_Northwest_Territories,[|"Territoires du Nord-Ouest";"Northwest Territories"|]
   ;CA_Yukon,[|"Yukon";"Yukon"|]
  |]

let [@warning "-42"] belgium_region : (region * _) array =
  [|BE_Bruxelles_Capitale,[|"Bruxelles-Capitale";"Région bruxelloise";"Région de Bruxelles-Capitale";"Brussels Hoofdstedelijk Gewest"|]
   ;BE_Flandre,[|"Flandre";"Région flamande";"Vlaams Gewest";"Flämische Region"|]
   ;BE_Wallonie,[|"Wallonie";"Région wallonne";"Waals Gewest";"Wallonische Region"|]
  |]

let belgium_subregion =
  [|BE_Anvers,[|"Anvers";"Antwerpen"|]
   ;BE_Bruxelles_Capitale,[|"Bruxelles-Capitale";"Région bruxelloise";"Région de Bruxelles-Capitale";"Brussels Hoofdstedelijk Gewest"|]
   ;BE_Limbourg,[|"Limbourg;Limburg"|]
   ;BE_Flandre_Orientale,[|"Flandre-Orientale";"Oost-Vlaanderen"|]
   ;BE_Flandre_Occidentale,[|"Brabant flamand";"Vlaams-Brabant"|]
   ;BE_Brabant_wallon,[|"Flandre-Occidentale";"West-Vlaanderen"|]
   ;BE_Hainaut,[|"Brabant wallon";"Waals-Brabant"|]
   ;BE_Liege,[|"Hainaut";"Henegouwen"|]
   ;BE_Luxembourg,[|"Liège";"Luik"|]
   ;BE_Namur,[|"Luxembourg";"Luxemburg"|]
   ;BE_Namur,[|"Namur";"Namen"|]
  |]

let austria_region =
  [|AT_Niederosterreich,[|"Basse-Autriche";"Niederösterreich"|]
   ;AT_Burgenland,[|"Burgenland";"Burgenland"|]
   ;AT_Karnten,[|"Carinthie";"Kärnten"|]
   ;AT_Oberosterreich,[|"Haute-Autriche";"Oberösterreich"|]
   ;AT_Salzburg,[|"Salzbourg";"Salzburg"|]
   ;AT_Steiermark,[|"Styrie";"Steiermark"|]
   ;AT_Tirol,[|"Tyrol";"Tirol"|]
   ;AT_Wien,[|"Vienne";"Wien"|]
   ;AT_Vorarlberg,[|"Vorarlberg"|]
  |]

let australia_region =
  [|AU_South_Australia,[|"Australie-Méridionale";"South Australia";"SA"|]
   ;AU_Western_Australia,[|"Australie-Occidentale";"Western Australia";"WA"|]
   ;AU_New_South_Wales,[|"Nouvelle-Galles du Sud";"New South Wales";"NSW"|]
   ;AU_Queensland,[|"Queensland";"Queensland";"QLD"|]
   ;AU_Tasmania,[|"Tasmanie";"Tasmania";"TAS"|]
   ;AU_Victoria,[|"Victoria";"Victoria";"VIC"|]
  |]

let [@warning "-42"] france_subregion =
  [|FR_Ain,[|"Ain";"01"|]
   ;FR_Aisne,[|"Aisne";"02"|]
   ;FR_Allier,[|"Allier";"03"|]
   ;FR_Alpes_de_Haute_Provence,[|"Alpes-de-Haute-Provence";"04"|]
   ;FR_Hautes_alpes,[|"Hautes-alpes";"05"|]
   ;FR_Alpes_maritimes,[|"Alpes-maritimes";"06"|]
   ;FR_Ardeche,[|"Ardèche";"07"|]
   ;FR_Ardennes,[|"Ardennes";"08"|]
   ;FR_Ariege,[|"Ariège";"09"|]
   ;FR_Aube,[|"Aube";"10"|]
   ;FR_Aude,[|"Aude";"11"|]
   ;FR_Aveyron,[|"Aveyron";"12"|]
   ;FR_Bouches_du_Rhone,[|"Bouches-du-Rhône";"13"|]
   ;FR_Calvados,[|"Calvados";"14"|]
   ;FR_Cantal,[|"Cantal";"15"|]
   ;FR_Charente,[|"Charente";"16"|]
   ;FR_Charente_maritime,[|"Charente-maritime";"17"|]
   ;FR_Cher,[|"Cher";"18"|]
   ;FR_Correze,[|"Corrèze";"19"|]
   ;FR_Corse,[|"Corse";"20";"2a";"Corse-du-sud";"Liamone";"2b";"Haute-Corse";"Golo"|]
   (* ;FR_Corse_du_sud,[|"2a";"Corse-du-sud";"Liamone"|]
    * ;FR_Haute_Corse,[|"2b";"Haute-Corse";"Golo"|] *)
   ;FR_Cote_d_Or,[|"Côte-d'Or";"21"|]
   ;FR_Cotes_d_Armor,[|"Côtes-d'Armor";"22"|]
   ;FR_Creuse,[|"Creuse";"23"|]
   ;FR_Dordogne,[|"Dordogne";"24"|]
   ;FR_Doubs,[|"Doubs";"25"|]
   ;FR_Drome,[|"Drôme";"26"|]
   ;FR_Eure,[|"Eure";"27"|]
   ;FR_Eure_et_loir,[|"Eure-et-loir";"28"|]
   ;FR_Finistere,[|"Finistère";"29"|]
   ;FR_Gard,[|"Gard";"30"|]
   ;FR_Haute_garonne,[|"Haute-garonne";"31"|]
   ;FR_Gers,[|"Gers";"32"|]
   ;FR_Gironde,[|"Gironde";"33"|]
   ;FR_Herault,[|"Hérault";"34"|]
   ;FR_Ille_et_vilaine,[|"Ille-et-vilaine";"35"|]
   ;FR_Indre,[|"Indre";"36"|]
   ;FR_Indre_et_loire,[|"Indre-et-loire";"37"|]
   ;FR_Isere,[|"Isère";"38"|]
   ;FR_Jura,[|"Jura";"39"|]
   ;FR_Landes,[|"Landes";"40"|]
   ;FR_Loir_et_cher,[|"Loir-et-cher";"41"|]
   ;FR_Loire,[|"Loire";"42"|]
   ;FR_Haute_loire,[|"Haute-loire";"43"|]
   ;FR_Loire_atlantique,[|"Loire-atlantique";"44"|]
   ;FR_Loiret,[|"Loiret";"45"|]
   ;FR_Lot,[|"Lot";"46"|]
   ;FR_Lot_et_garonne,[|"Lot-et-garonne";"47"|]
   ;FR_Lozere,[|"Lozère";"48"|]
   ;FR_Maine_et_loire,[|"Maine-et-loire";"49"|]
   ;FR_Manche,[|"Manche";"50"|]
   ;FR_Marne,[|"Marne";"51"|]
   ;FR_Haute_marne,[|"Haute-marne";"52"|]
   ;FR_Mayenne,[|"Mayenne";"53"|]
   ;FR_Meurthe_et_moselle,[|"Meurthe-et-moselle";"54"|]
   ;FR_Meuse,[|"Meuse";"55"|]
   ;FR_Morbihan,[|"Morbihan";"56"|]
   ;FR_Moselle,[|"Moselle";"57"|]
   ;FR_Nievre,[|"Nièvre";"58"|]
   ;FR_Nord,[|"Nord";"59"|]
   ;FR_Oise,[|"Oise";"60"|]
   ;FR_Orne,[|"Orne";"61"|]
   ;FR_Pas_de_calais,[|"Pas-de-calais";"62"|]
   ;FR_Puy_de_dome,[|"Puy-de-dôme";"63"|]
   ;FR_Pyrenees_atlantiques,[|"Pyrénées-atlantiques";"64"|]
   ;FR_Hautes_Pyrenees,[|"Hautes-Pyrénées";"65"|]
   ;FR_Pyrenees_orientales,[|"Pyrénées-orientales";"66"|]
   ;FR_Bas_rhin,[|"Bas-rhin";"67"|]
   ;FR_Haut_rhin,[|"Haut-rhin";"68"|]
   ;FR_Rhone,[|"Rhône";"69"|]
   ;FR_Haute_saone,[|"Haute-saône";"70"|]
   ;FR_Saone_et_loire,[|"Saône-et-loire";"71"|]
   ;FR_Sarthe,[|"Sarthe";"72"|]
   ;FR_Savoie,[|"Savoie";"73"|]
   ;FR_Haute_savoie,[|"Haute-savoie";"74"|]
   ;FR_Paris,[|"Paris";"75";"Paris I";"Paris II";"Paris III";"Paris IV";"Paris V";"Paris VI";"Paris VII";"Paris VIII";"Paris IX";"Paris X";"Paris XI";"Paris XII";"Paris XIII";"Paris XIV";"Paris XV";"Paris XVI";"Paris XVII";"Paris XVIII";"Paris XIX";"Paris XX"|]
   ;FR_Seine_maritime,[|"Seine-maritime";"76"|]
   ;FR_Seine_et_marne,[|"Seine-et-marne";"77"|]
   ;FR_Yvelines,[|"Yvelines";"78"|]
   ;FR_Deux_sevres,[|"Deux-sèvres";"79"|]
   ;FR_Somme,[|"Somme";"80"|]
   ;FR_Tarn,[|"Tarn";"81"|]
   ;FR_Tarn_et_garonne,[|"Tarn-et-garonne";"82"|]
   ;FR_Var,[|"Var";"83"|]
   ;FR_Vaucluse,[|"Vaucluse";"84"|]
   ;FR_Vendee,[|"Vendée";"85"|]
   ;FR_Vienne,[|"Vienne";"86"|]
   ;FR_Haute_vienne,[|"Haute-vienne";"87"|]
   ;FR_Vosges,[|"Vosges";"88"|]
   ;FR_Yonne,[|"Yonne";"89"|]
   ;FR_Territoire_de_belfort,[|"Territoire de belfort";"90"|]
   ;FR_Essonne,[|"Essonne";"91"|]
   ;FR_Hauts_de_seine,[|"Hauts-de-seine";"92"|]
   ;FR_Seine_Saint_Denis,[|"Seine-Saint-Denis";"93"|]
   ;FR_Val_de_marne,[|"Val-de-marne";"94"|]
   ;FR_Val_d_oise,[|"Val-d'oise";"95"|]
   ;FR_Guadeloupe,[|"Guadeloupe";"971"|]
   ;FR_Martinique,[|"Martinique";"972"|]
   ;FR_Guyane,[|"Guyane";"973"|]
   ;FR_La_reunion,[|"La réunion";"974"|]
   ;FR_Mayotte,[|"Mayotte";"975"|]
  |]

let germany_region =
  [|DE_Baden_Wurttemberg, [|"Bade-Wurtemberg";"Baden-Württemberg"|]
   ;DE_Niedersachsen,[|"Basse-Saxe";"Niedersachsen";"Lower Saxony"|]
   ;DE_Bayern,[|"Bavière";"Bayern";"Bavaria"|]
   ;DE_Berlin,[|"Berlin"|]
   ;DE_Brandenburg,[|"Brandebourg";"Brandenburg"|]
   ;DE_Bremen,[|"Brême";"Bremen"|]
   ;DE_Hamburg,[|"Hambourg";"Hamburg"|]
   ;DE_Hessen,[|"Hesse";"Hessen"|]
   ;DE_Mecklenburg_Vorpommern,[|"Mecklembourg-Poméranie-Occidentale";"Mecklenburg-Vorpommern"|]
   ;DE_Nordrhein_Westfalen,[|"Rhénanie-du-Nord-Westphalie";"Nordrhein-Westfalen";"North Rhine-Westphalia"|]
   ;DE_Rheinland_Pfalz,[|"Rhénanie-Palatinat";"Rheinland-Pfalz";"Rhineland-Palatinate"|]
   ;DE_Saarland,[|"Sarre";"Saarland"|]
   ;DE_Sachsen_Anhalt,[|"Saxe-Anhalt";"Sachsen-Anhalt";"Saxony-Anhalt"|]
   ;DE_Sachsen,[|"Saxe";"Sachsen";"Saxony"|]
   ;DE_Schleswig_Holstein,[|"Schleswig-Holstein"|]
   ;DE_Thuringen,[|"Thuringe";"Thüringen";"Thuringia"|]
  |]

let regions =
  [|Algeria,algeria_region
   ;Australia,australia_region
   ;Austria,austria_region
   ;Belgium,belgium_region
   ;Canada,canada_region
   ;France,france_region
   ;Germany,germany_region
   ;South_Africa,south_africa_region
   ;Spain,spain_region
   ;United_States,united_states_region
  |]

let subregions =
  [|Belgium,belgium_subregion
   ;France,france_subregion
  |]

let gen_region_variable_name country = "region_" ^ (show_country country)
let gen_subregion_variable_name country = "subregion_" ^ (show_country country)
let gen_not_found oc = Printf.fprintf oc "| _ -> raise Not_found\n"
