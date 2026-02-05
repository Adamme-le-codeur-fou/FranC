open Ast
open Ecrire
open Expressions

let ecrire_boucle ecrire_ast portee cond paragraphe =
  ecrire "while (";
  ecrire_expression portee cond;
  ecrire ") {\n";
  let portee_apres_boucle = List.fold_left ecrire_ast portee paragraphe in
  ecrire "}\n";
  portee_apres_boucle


let ecrire_for ecrire_ast portee var start_expr end_expr inclusive paragraphe =
  ecrire "for (int %s = " (String.lowercase_ascii var);
  ecrire_expression portee start_expr;
  ecrire "; %s " (String.lowercase_ascii var);
  ecrire (if inclusive then "<= " else "< ");
  ecrire_expression portee end_expr;
  ecrire "; %s++) {\n" (String.lowercase_ascii var);
  let portee_apres_for = (String.lowercase_ascii var, TypeEntier) :: portee in
  let _ = List.fold_left ecrire_ast portee_apres_for paragraphe in
  ecrire "}\n";
  portee_apres_for


let ecrire_condition ecrire_ast portee cond alors_list sinon_opt =
  ecrire "if (";
  ecrire_expression portee cond;
  ecrire ") {\n";
  let portee_apres_alors = List.fold_left ecrire_ast portee alors_list in
  ecrire "}\n";
  match sinon_opt with
  | Some sinon_list ->
    ecrire "else {\n";
    let portee_apres_sinon =
      List.fold_left ecrire_ast portee_apres_alors sinon_list
    in
    ecrire "}\n";
    portee_apres_sinon
  | None -> portee_apres_alors