open Ecrire
open Declarations
open Types


(* Fonction pour afficher une boucle 'tant que' *)
let ecrire_function ecrire_ast nom arguments type_function corps =
  ecrire "\n%s" (type_vers_string type_function);
  ecrire "%s(" nom;
  ecrire_variable_avec_type arguments;
  ecrire ") {\n";
  let portee_finale = List.fold_left ecrire_ast arguments corps in
  ecrire_liberation_tableaux arguments portee_finale;
  ecrire "}\n"
