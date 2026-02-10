open Ast
open Ecrire
open Expressions
open Declarations
open Types

let ecrire_boucle ecrire_ast portee cond paragraphe =
  ecrire "while (";
  ecrire_expression portee cond;
  ecrire ") {\n";
  ecrire_bloc ecrire_ast portee paragraphe;
  portee

let ecrire_for ecrire_ast portee var start_expr end_expr inclusive paragraphe =
  let var_min = String.lowercase_ascii var in
  ecrire "for (int %s = " var_min;
  ecrire_expression portee start_expr;
  ecrire "; %s " var_min;
  ecrire (if inclusive then "<= " else "< ");
  ecrire_expression portee end_expr;
  ecrire "; %s++) {\n" var_min;
  ecrire_bloc ecrire_ast ((var_min, TypeEntier) :: portee) paragraphe;
  portee

let ecrire_pour_chaque ecrire_ast portee element_var array_name corps =
  let array_min = String.lowercase_ascii array_name in
  let element_min = String.lowercase_ascii element_var in
  let type_tab = type_variable portee array_min in
  let type_element = match type_tab with
    | TypeTableau inner -> inner
    | _ -> raise (Erreurs.types_incompatibles "tableau" (nom_type type_tab))
  in
  let idx_var = Printf.sprintf "_idx_%s" array_min in
  ecrire "for (int %s = 0; %s < %s->taille; %s++) {\n" idx_var idx_var array_min idx_var;
  ecrire "%s%s = ((%s*)%s->donnees)[%s];\n" (type_vers_string type_element) element_min (type_c type_element) array_min idx_var;
  ecrire_bloc ecrire_ast ((element_min, type_element) :: portee) corps;
  portee

let ecrire_condition ecrire_ast portee cond alors_list sinon_opt =
  ecrire "if (";
  ecrire_expression portee cond;
  ecrire ") {\n";
  ecrire_bloc ecrire_ast portee alors_list;
  (match sinon_opt with
  | Some sinon_list ->
    ecrire "else {\n";
    ecrire_bloc ecrire_ast portee sinon_list
  | None -> ());
  portee
