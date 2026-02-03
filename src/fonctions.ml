open Ecrire
open Declarations
open Types


(* Fonction pour afficher une boucle 'tant que' *)
let afficher_function afficher_ast nom arguments type_function corps =
  ecrire "\n%s" (type_vers_chaine_caractere type_function);
  ecrire "%s(" nom;
  afficher_variable_avec_type arguments;
  ecrire ") {\n";
  let _ = List.fold_left afficher_ast arguments corps in
  ecrire "}\n"