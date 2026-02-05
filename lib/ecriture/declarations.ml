open Ast
open Ecrire
open Expressions
open Portee
open Types


(* Fonction pour afficher une assignation *)
let ecrire_assignation portee (var, expr) =
  let var_minuscule = String.lowercase_ascii var in
  let portee_maj =
    if variable_est_declaree portee var_minuscule then portee
    else (var_minuscule, TypeEntier) :: portee
  in
  if not (variable_est_declaree portee var_minuscule) then
    ecrire  "%s" (type_de_variable_vers_string portee_maj var_minuscule);
  ecrire "%s = " var_minuscule;
  ecrire_expression portee_maj expr;
  ecrire ";\n";
  portee_maj


let ecrire_printf portee e =
  (match e with
  | Entier n -> ecrire "wprintf(L\"%%d\\n\", %s);\n" n
  | Reel r -> ecrire "wprintf(L\"%%f\\n\", %s);\n" (remplacer_caractere ',' '.' r)
  | Chaine_caractere s -> ecrire "wprintf(L\"%s\\n\");\n" (normaliser_chaine s)
  | _ ->
    ecrire "wprintf(L\"%%d\\n\", ";
    ecrire_expression portee e;
    ecrire ");\n");
  portee

let rec ecrire_variable_avec_type arguments_list =
    match arguments_list with
    | [] -> ()
    | (argument_nom, argument_type)::q ->
        ecrire "%s %s%s" (type_vers_string argument_type) argument_nom (if q = [] then "" else ", ");
        ecrire_variable_avec_type q

let ecrire_xcrementer portee var expression signe =
  (match expression with
  | None -> ecrire "%s%s;\n" (String.lowercase_ascii var) (signe^signe)
  | Some expr ->
    ecrire "%s %s= " (String.lowercase_ascii var) signe;
    ecrire_expression portee expr;
    ecrire ";\n");
  portee

let ecrire_incrementer portee var expression = ecrire_xcrementer portee var expression "+"

let ecrire_decrementer portee var expression = ecrire_xcrementer portee var expression "-"

let ecrire_permuter portee variable1 variable2 =
    let v1_minuscule = String.lowercase_ascii variable1 in
    let v2_minuscule = String.lowercase_ascii variable2 in
    let variable_temporaire = temporaire_suivant () in
    ecrire "%s %s = %s;\n" (type_de_variable_vers_string portee v1_minuscule) variable_temporaire v1_minuscule;
    ecrire "%s = %s;\n" v1_minuscule v2_minuscule;
    ecrire "%s = %s;\n" v2_minuscule variable_temporaire;
    portee

let ecrire_renvoyer portee expression =
  ecrire "return ";
  let _ = ecrire_expression portee expression in
  ecrire ";\n";
  portee