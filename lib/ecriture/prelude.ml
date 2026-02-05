open Ast
open Fonctions
open Ecrire

let ecrire_includes () = ecrire "#include <stdio.h>\n#include <wchar.h>\n#include <locale.h>\n"

let rec ecrire_fonctions_pre_main ecrire_ast ast =
  match ast with
  | Recette(nom, arguments, type_function, corps) -> ecrire_function ecrire_ast nom arguments type_function corps
  | Paragraphe l -> List.iter (ecrire_fonctions_pre_main ecrire_ast) l
  | _ -> ()

let ecrire_debut ecrire_ast ast nom_programme =
  ecrire_includes ();
  ecrire_fonctions_pre_main ecrire_ast ast;
  ecrire "\nint main(){\nsetlocale(LC_ALL, \"\");\nwprintf(L\"Programme : %s\\n\");\n" nom_programme