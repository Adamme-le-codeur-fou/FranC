open Ast
open Fonctions
open Ecrire


(* TODO : calculer automatiquement les includes à ecrire *)
let ecrire_includes () = ecrire "#include <stdio.h>\n#include <wchar.h>\n#include <locale.h>\n"


let rec afficher_fonctions_pre_main afficher_ast ast =
  match ast with
  | Recette(nom, arguments, type_function, corps) -> afficher_function afficher_ast nom arguments type_function corps
  | Paragraphe l -> List.iter (afficher_fonctions_pre_main afficher_ast) l
  | _ -> ()


let ecrire_debut afficher_ast ast nom_programme =
  ecrire_includes ();
  afficher_fonctions_pre_main afficher_ast ast;
  ecrire "\nint main(){\nsetlocale(LC_ALL, \"\");\nwprintf(L\"Programme : %s\\n\");\n" nom_programme