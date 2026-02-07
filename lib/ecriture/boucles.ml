open Ast
open Ecrire
open Expressions
open Declarations

let ecrire_boucle ecrire_ast portee cond paragraphe =
  ecrire "while (";
  ecrire_expression portee cond;
  ecrire ") {\n";
  let portee_bloc = List.fold_left ecrire_ast portee paragraphe in
  ecrire_liberation_tableaux portee portee_bloc;
  ecrire "}\n";
  portee


let ecrire_for ecrire_ast portee var start_expr end_expr inclusive paragraphe =
  ecrire "for (int %s = " (String.lowercase_ascii var);
  ecrire_expression portee start_expr;
  ecrire "; %s " (String.lowercase_ascii var);
  ecrire (if inclusive then "<= " else "< ");
  ecrire_expression portee end_expr;
  ecrire "; %s++) {\n" (String.lowercase_ascii var);
  let portee_avec_var = (String.lowercase_ascii var, TypeEntier) :: portee in
  let portee_bloc = List.fold_left ecrire_ast portee_avec_var paragraphe in
  ecrire_liberation_tableaux portee_avec_var portee_bloc;
  ecrire "}\n";
  portee


let ecrire_condition ecrire_ast portee cond alors_list sinon_opt =
  ecrire "if (";
  ecrire_expression portee cond;
  ecrire ") {\n";
  let portee_alors = List.fold_left ecrire_ast portee alors_list in
  ecrire_liberation_tableaux portee portee_alors;
  ecrire "}\n";
  match sinon_opt with
  | Some sinon_list ->
    ecrire "else {\n";
    let portee_sinon = List.fold_left ecrire_ast portee sinon_list in
    ecrire_liberation_tableaux portee portee_sinon;
    ecrire "}\n";
    portee
  | None -> portee
