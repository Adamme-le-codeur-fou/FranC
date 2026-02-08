open Llvm_contexte
open Llvm_expressions

let br_si_non_termine ctx label =
  if not ctx.bloc_termine then
    ecrire ctx "  br label %%%s\n" label

let nouveau_label ctx label =
  ecrire ctx "%s:\n" label;
  ctx.bloc_termine <- false

let ecrire_condition ctx ecrire_ast cond alors sinon_opt =
  let (_, cond_val) = ecrire_expression ctx cond in
  let cond_i1 = vers_i1 ctx cond_val in
  let label_alors = label_frais ctx "alors" in
  let label_fin = label_frais ctx "fin_cond" in
  (match sinon_opt with
  | None ->
    ecrire ctx "  br i1 %s, label %%%s, label %%%s\n" cond_i1 label_alors label_fin;
    nouveau_label ctx label_alors;
    let portee_sauvee = sauvegarder_portee ctx in
    List.iter (ecrire_ast ctx) alors;
    restaurer_portee ctx portee_sauvee;
    br_si_non_termine ctx label_fin;
    nouveau_label ctx label_fin
  | Some sinon ->
    let label_sinon = label_frais ctx "sinon" in
    ecrire ctx "  br i1 %s, label %%%s, label %%%s\n" cond_i1 label_alors label_sinon;
    nouveau_label ctx label_alors;
    let portee_sauvee = sauvegarder_portee ctx in
    List.iter (ecrire_ast ctx) alors;
    restaurer_portee ctx portee_sauvee;
    let alors_termine = ctx.bloc_termine in
    br_si_non_termine ctx label_fin;
    nouveau_label ctx label_sinon;
    let portee_sauvee2 = sauvegarder_portee ctx in
    List.iter (ecrire_ast ctx) sinon;
    restaurer_portee ctx portee_sauvee2;
    let sinon_termine = ctx.bloc_termine in
    br_si_non_termine ctx label_fin;
    if alors_termine && sinon_termine then begin
      ecrire ctx "%s:\n" label_fin;
      ecrire ctx "  unreachable\n";
      ctx.bloc_termine <- true
    end else
      nouveau_label ctx label_fin)

let ecrire_boucle ctx ecrire_ast cond corps =
  let label_cond = label_frais ctx "cond_boucle" in
  let label_corps = label_frais ctx "corps_boucle" in
  let label_fin = label_frais ctx "fin_boucle" in
  ecrire ctx "  br label %%%s\n" label_cond;
  nouveau_label ctx label_cond;
  let (_, cond_val) = ecrire_expression ctx cond in
  let cond_i1 = vers_i1 ctx cond_val in
  ecrire ctx "  br i1 %s, label %%%s, label %%%s\n" cond_i1 label_corps label_fin;
  nouveau_label ctx label_corps;
  let portee_sauvee = sauvegarder_portee ctx in
  List.iter (ecrire_ast ctx) corps;
  restaurer_portee ctx portee_sauvee;
  br_si_non_termine ctx label_cond;
  nouveau_label ctx label_fin

let ecrire_for ctx ecrire_ast var start_expr end_expr inclusive corps =
  let var_min = String.lowercase_ascii var in
  let ptr = Printf.sprintf "%%%s" var_min in
  let (_, start_val) = ecrire_expression ctx start_expr in
  let (_, end_val) = ecrire_expression ctx end_expr in
  ecrire ctx "  %s = alloca i32\n" ptr;
  ecrire ctx "  store i32 %s, i32* %s\n" start_val ptr;
  let label_cond = label_frais ctx "cond_for" in
  let label_corps = label_frais ctx "corps_for" in
  let label_fin = label_frais ctx "fin_for" in
  ecrire ctx "  br label %%%s\n" label_cond;
  nouveau_label ctx label_cond;
  let i_val = nom_frais ctx in
  ecrire ctx "  %s = load i32, i32* %s\n" i_val ptr;
  let cmp = nom_frais ctx in
  let pred = if inclusive then "sle" else "slt" in
  ecrire ctx "  %s = icmp %s i32 %s, %s\n" cmp pred i_val end_val;
  ecrire ctx "  br i1 %s, label %%%s, label %%%s\n" cmp label_corps label_fin;
  nouveau_label ctx label_corps;
  let portee_sauvee = sauvegarder_portee ctx in
  ajouter_variable ctx var_min Ast.TypeEntier ptr;
  List.iter (ecrire_ast ctx) corps;
  let i_val2 = nom_frais ctx in
  ecrire ctx "  %s = load i32, i32* %s\n" i_val2 ptr;
  let i_inc = nom_frais ctx in
  ecrire ctx "  %s = add i32 %s, 1\n" i_inc i_val2;
  ecrire ctx "  store i32 %s, i32* %s\n" i_inc ptr;
  restaurer_portee ctx portee_sauvee;
  br_si_non_termine ctx label_cond;
  nouveau_label ctx label_fin
