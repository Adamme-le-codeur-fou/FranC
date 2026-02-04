open Ast
open Ecrire
open Expressions
open Portee
open Types


(* Fonction pour afficher une assignation *)
let afficher_assignation portee (var, expr) =
  let var_minuscule = String.lowercase_ascii var in
  let portee_maj =
    if variable_est_declaree portee var_minuscule then portee
    else (var_minuscule, TypeEntier) :: portee
  in
  (if not (variable_est_declaree portee var_minuscule) then
    ecrire  "%s" (type_vers_chaine_caractere (type_de_expression portee expr)));
  ecrire "%s = " var_minuscule;
  afficher_expression portee_maj expr;
  ecrire ";\n";
  portee_maj


(* Fonction pour afficher un appel à printf avec la valeur correcte *)
let afficher_printf portee e =
  match e with
  | Entier n -> ecrire "wprintf(L\"%%d\\n\", %s);\n" n
  | Reel r -> ecrire "wprintf(L\"%%f\\n\", %s);\n" (remplacer_caractere ',' '.' r)
  | Chaine_caractere s -> ecrire "wprintf(L\"%s\\n\");\n" (normaliser_chaine s)
  | _ ->
    ecrire "wprintf(L\"%%d\\n\", ";
    afficher_expression portee e;
    ecrire ");\n"

let rec afficher_variable_avec_type arguments_list =
    match arguments_list with
    | [] -> ()
    | (argument_nom, argument_type)::q ->
        ecrire "%s %s%s" (type_vers_chaine_caractere argument_type) argument_nom (if q = [] then "" else ", ");
        afficher_variable_avec_type q
