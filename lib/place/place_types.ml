let normalize =
  (* petit hack en attendant une vraie gestion des lieux transforme
     "[foo-bar] - boobar (baz)" en "foo-bar, boobar (baz)" *)
  let r = Str.regexp "^\\[\\([^]]+\\)\\] *- *\\(.*\\)" in
  fun s -> Str.global_replace r "\\1, \\2" s

let key s = Hashtbl.hash (Place_name.strip_lower s)

type country =
  | Afghanistan
  | Albania
  | Algeria
  | Andorra
  | Angola
  | Antigua_and_Barbuda
  | Argentina
  | Armenia
  | Australia
  | Austria
  | Azerbaijan
  | Bahrain
  | Bangladesh
  | Barbados
  | Belarus
  | Belgium
  | Belize
  | Benin
  | Bhutan
  | Bolivia
  | Bosnia_and_Herzegovina
  | Botswana
  | Brazil
  | Brunei
  | Bulgaria
  | Burkina_Faso
  | Burundi
  | Cabo_Verde
  | Cambodia
  | Cameroon
  | Canada
  | Central_African_Republic
  | Chad
  | Chile
  | China
  | Colombia
  | Comoros
  | Costa_Rica
  | Croatia
  | Cuba
  | Cyprus
  | Czech_Republic
  | Cote_d_Ivoire
  | Democratic_Republic_of_the_Congo
  | Denmark
  | Djibouti
  | Dominica
  | Dominican_Republic
  | East_Timor
  | Ecuador
  | Egypt
  | El_Salvador
  | Equatorial_Guinea
  | Eritrea
  | Estonia
  | Eswatini
  | Ethiopia
  | Federated_States_of_Micronesia
  | Fiji
  | Finland
  | France
  | Gabon
  | Georgia
  | Germany
  | Ghana
  | Greece
  | Grenada
  | Guatemala
  | Guinea
  | Guinea_Bissau
  | Guyana
  | Haiti
  | Honduras
  | Hungary
  | Iceland
  | India
  | Indonesia
  | Iran
  | Iraq
  | Ireland
  | Israel
  | Italy
  | Jamaica
  | Japan
  | Jordan
  | Kazakhstan
  | Kenya
  | Kiribati
  | Kosovo
  | Kuwait
  | Kyrgyzstan
  | Laos
  | Latvia
  | Lebanon
  | Lesotho
  | Liberia
  | Libya
  | Liechtenstein
  | Lithuania
  | Luxembourg
  | Madagascar
  | Malawi
  | Malaysia
  | Maldives
  | Mali
  | Malta
  | Marshall_Islands
  | Mauritania
  | Mauritius
  | Mexico
  | Moldova
  | Monaco
  | Mongolia
  | Montenegro
  | Morocco
  | Mozambique
  | Myanmar
  | Namibia
  | Nauru
  | Nepal
  | Netherlands
  | New_Zealand
  | Nicaragua
  | Niger
  | Nigeria
  | North_Korea
  | North_Macedonia
  | Norway
  | Oman
  | Pakistan
  | Palau
  | Panama
  | Papua_New_Guinea
  | Paraguay
  | Peru
  | Philippines
  | Poland
  | Portugal
  | Qatar
  | Republic_of_the_Congo
  | Romania
  | Russia
  | Rwanda
  | Saint_Kitts_and_Nevis
  | Saint_Lucia
  | Saint_Vincent_and_the_Grenadines
  | Samoa
  | San_Marino
  | Sao_Tome_and_Principe
  | Saudi_Arabia
  | Senegal
  | Serbia
  | Seychelles
  | Sierra_Leone
  | Singapore
  | Slovakia
  | Slovenia
  | Solomon_Islands
  | Somalia
  | South_Africa
  | South_Korea
  | South_Sudan
  | Spain
  | Sri_Lanka
  | Sudan
  | Suriname
  | Sweden
  | Switzerland
  | Syria
  | Taiwan
  | Tajikistan
  | Tanzania
  | Thailand
  | The_Bahamas
  | The_Gambia
  | Togo
  | Tonga
  | Trinidad_and_Tobago
  | Tunisia
  | Turkey
  | Turkmenistan
  | Tuvalu
  | Uganda
  | Ukraine
  | United_Arab_Emirates
  | United_Kingdom
  | United_States
  | Uruguay
  | Uzbekistan
  | Vanuatu
  | Vatican_City
  | Venezuela
  | Vietnam
  | Yemen
  | Zambia
  | Zimbabwe
[@@deriving show { with_path = false }]

type region =

  | FR_Auvergne_Rhone_Alpes
  | FR_Bourgogne_Franche_Comte
  | FR_Bretagne
  | FR_Centre_Val_de_Loire
  | FR_Corse
  | FR_Grand_Est
  | FR_Hauts_de_France
  | FR_Ile_de_France
  | FR_Normandie
  | FR_Nouvelle_Aquitaine
  | FR_Occitanie
  | FR_Pays_de_la_Loire
  | FR_Provence_Alpes_Cote_d_Azur
  | FR_Guadeloupe
  | FR_Martinique
  | FR_Guyane
  | FR_La_reunion
  | FR_Mayotte

  | DE_Baden_Wurttemberg
  | DE_Niedersachsen
  | DE_Bayern
  | DE_Berlin
  | DE_Brandenburg
  | DE_Bremen
  | DE_Hamburg
  | DE_Hessen
  | DE_Mecklenburg_Vorpommern
  | DE_Nordrhein_Westfalen
  | DE_Rheinland_Pfalz
  | DE_Saarland
  | DE_Sachsen_Anhalt
  | DE_Sachsen
  | DE_Schleswig_Holstein
  | DE_Thuringen

  | AU_South_Australia
  | AU_Western_Australia
  | AU_New_South_Wales
  | AU_Queensland
  | AU_Tasmania
  | AU_Victoria

  | AT_Niederosterreich
  | AT_Burgenland
  | AT_Karnten
  | AT_Oberosterreich
  | AT_Salzburg
  | AT_Steiermark
  | AT_Tirol
  | AT_Wien
  | AT_Vorarlberg

  | BE_Bruxelles_Capitale
  | BE_Flandre
  | BE_Wallonie

  | US_Alabama
  | US_Alaska
  | US_Arizona
  | US_Arkansas
  | US_California
  | US_North_Carolina
  | US_South_Carolina
  | US_Colorado
  | US_Connecticut
  | US_North_Dakota
  | US_South_Dakota
  | US_Delaware
  | US_Florida
  | US_Georgia
  | US_Hawaii
  | US_Idaho
  | US_Illinois
  | US_Indiana
  | US_Iowa
  | US_Kansas
  | US_Kentucky
  | US_Louisiana
  | US_Maine
  | US_Maryland
  | US_Massachusetts
  | US_Michigan
  | US_Minnesota
  | US_Mississippi
  | US_Missouri
  | US_Montana
  | US_Nebraska
  | US_Nevada
  | US_New_Hampshire
  | US_New_Jersey
  | US_New_Mexico
  | US_New_York
  | US_Ohio
  | US_Oklahoma
  | US_Oregon
  | US_Pennsylvania
  | US_Rhode_Island
  | US_Tennessee
  | US_Texas
  | US_Utah
  | US_Vermont
  | US_Virginia
  | US_West_Virginia
  | US_Washington
  | US_Wisconsin
  | US_Wyoming

  | ZA_Eastern_Cape
  | ZA_Free_State
  | ZA_Gauteng
  | ZA_KwaZulu_Natal
  | ZA_Limpopo
  | ZA_Mpumalanga
  | ZA_North_West
  | ZA_Northern_Cape
  | ZA_Western_Cape

  | CA_Alberta
  | CA_British_Columbia
  | CA_Prince_Edward_Island
  | CA_Manitoba
  | CA_New_Brunswick
  | CA_Nova_Scotia
  | CA_Ontario
  | CA_Quebec
  | CA_Saskatchewan
  | CA_Newfoundland_and_Labrador
  | CA_Nunavut
  | CA_Northwest_Territories
  | CA_Yukon

  | DZ_Adrar
  | DZ_Chlef
  | DZ_Laghouat
  | DZ_Oum_El_Bouaghi
  | DZ_Batna
  | DZ_Beaia
  | DZ_Biskra
  | DZ_Bechar
  | DZ_Blida
  | DZ_Bouira
  | DZ_Tamanrasset
  | DZ_Tebessa
  | DZ_Tlemcen
  | DZ_Tiaret
  | DZ_Tizi_Ouzou
  | DZ_Alger
  | DZ_Djelfa
  | DZ_Jijel
  | DZ_Setif
  | DZ_Saida
  | DZ_Skikda
  | DZ_Sidi_Bel_Abbes
  | DZ_Annaba
  | DZ_Guelma
  | DZ_Constantine
  | DZ_Medea
  | DZ_Mostaganem
  | DZ_M_Sila
  | DZ_Mascara
  | DZ_Ouargla
  | DZ_Oran
  | DZ_El_Bayadh
  | DZ_Illizi
  | DZ_Bordj_Bou_Arreridj
  | DZ_Boumerdes
  | DZ_El_Tarf
  | DZ_Tindouf
  | DZ_Tissemsilt
  | DZ_El_Oued
  | DZ_Khenchela
  | DZ_Souk_Ahras
  | DZ_Tipaza
  | DZ_Mila
  | DZ_Ain_Defla
  | DZ_Naaa
  | DZ_Ai_Teouchent
  | DZ_Ghardai
  | DZ_Relizane

  | ES_Andalucia
  | ES_Aragon
  | ES_Asturias
  | ES_Islas_Baleares
  | ES_Canarias
  | ES_Cantabrie
  | ES_Castilla_y_Leon
  | ES_Castilla_La_Mancha
  | ES_Cataluna
  | ES_Extremadura
  | ES_Galicia
  | ES_Comunidad_de_Madrid
  | ES_Region_de_Murcia
  | ES_Navarra
  | ES_Pais_Vasco
  | ES_La_Rioja
  | ES_Comunidad_Valenciana
  | ES_Ceuta
  | ES_Melilla

  | IT_Abruzzo
  | IT_Basilicata
  | IT_Calabria
  | IT_CampaniaCampanie
  | IT_Emilia_Romagna
  | IT_Friuli_Venezia_Giulia
  | IT_Lazio
  | IT_Liguria
  | IT_Lombardia
  | IT_Marche
  | IT_Molise
  | IT_Umbria
  | IT_Piemonte
  | IT_Puglia
  | IT_Sardegna
  | IT_Sicilia
  | IT_Toscana
  | IT_Trentino_Alto_Adige
  | IT_Veneto

[@@deriving show { with_path = false }]

type subregion =

  | FR_Ain
  | FR_Aisne
  | FR_Allier
  | FR_Alpes_de_Haute_Provence
  | FR_Hautes_alpes
  | FR_Alpes_maritimes
  | FR_Ardeche
  | FR_Ardennes
  | FR_Ariege
  | FR_Aube
  | FR_Aude
  | FR_Aveyron
  | FR_Bouches_du_Rhone
  | FR_Calvados
  | FR_Cantal
  | FR_Charente
  | FR_Charente_maritime
  | FR_Cher
  | FR_Correze
  | FR_Corse
  (* | FR_Corse_du_sud
   * | FR_Haute_Corse *)
  | FR_Cote_d_Or
  | FR_Cotes_d_Armor
  | FR_Creuse
  | FR_Dordogne
  | FR_Doubs
  | FR_Drome
  | FR_Eure
  | FR_Eure_et_loir
  | FR_Finistere
  | FR_Gard
  | FR_Haute_garonne
  | FR_Gers
  | FR_Gironde
  | FR_Herault
  | FR_Ille_et_vilaine
  | FR_Indre
  | FR_Indre_et_loire
  | FR_Isere
  | FR_Jura
  | FR_Landes
  | FR_Loir_et_cher
  | FR_Loire
  | FR_Haute_loire
  | FR_Loire_atlantique
  | FR_Loiret
  | FR_Lot
  | FR_Lot_et_garonne
  | FR_Lozere
  | FR_Maine_et_loire
  | FR_Manche
  | FR_Marne
  | FR_Haute_marne
  | FR_Mayenne
  | FR_Meurthe_et_moselle
  | FR_Meuse
  | FR_Morbihan
  | FR_Moselle
  | FR_Nievre
  | FR_Nord
  | FR_Oise
  | FR_Orne
  | FR_Pas_de_calais
  | FR_Puy_de_dome
  | FR_Pyrenees_atlantiques
  | FR_Hautes_Pyrenees
  | FR_Pyrenees_orientales
  | FR_Bas_rhin
  | FR_Haut_rhin
  | FR_Rhone
  | FR_Haute_saone
  | FR_Saone_et_loire
  | FR_Sarthe
  | FR_Savoie
  | FR_Haute_savoie
  | FR_Paris
  | FR_Seine_maritime
  | FR_Seine_et_marne
  | FR_Yvelines
  | FR_Deux_sevres
  | FR_Somme
  | FR_Tarn
  | FR_Tarn_et_garonne
  | FR_Var
  | FR_Vaucluse
  | FR_Vendee
  | FR_Vienne
  | FR_Haute_vienne
  | FR_Vosges
  | FR_Yonne
  | FR_Territoire_de_belfort
  | FR_Essonne
  | FR_Hauts_de_seine
  | FR_Seine_Saint_Denis
  | FR_Val_de_marne
  | FR_Val_d_oise
  | FR_Guadeloupe
  | FR_Martinique
  | FR_Guyane
  | FR_La_reunion
  | FR_Mayotte

  | BE_Anvers
  | BE_Brabant_flamand
  | BE_Brabant_wallon
  | BE_Bruxelles_Capitale
  | BE_Flandre_Occidentale
  | BE_Flandre_Orientale
  | BE_Hainaut
  | BE_Liege
  | BE_Limbourg
  | BE_Luxembourg
  | BE_Namur
[@@deriving show { with_path = false }]
