open Ast
open String_outils
open Llvm_contexte
open Llvm_types

let vers_i1 ctx valeur =
  let b = nom_frais ctx in
  ecrire ctx "  %s = icmp ne i32 %s, 0\n" b valeur;
  b

let rec ecrire_expression ctx expr =
  match expr with
  | Entier n -> ("i32", n)
  | Reel r -> ("double", remplacer_caractere ',' '.' r)
  | Vrai -> ("i32", "1")
  | Faux -> ("i32", "0")
  | Mot m ->
    let nom_min = String.lowercase_ascii m in
    let (typ, ptr) = trouver_variable ctx nom_min in
    let t = type_llvm typ in
    let v = nom_frais ctx in
    ecrire ctx "  %s = load %s, %s* %s\n" v t t ptr;
    (t, v)
  | Plus (e1, e2) -> ecrire_binaire ctx e1 e2 "add" "fadd"
  | Moins (e1, e2) -> ecrire_binaire ctx e1 e2 "sub" "fsub"
  | Fois (e1, e2) -> ecrire_binaire ctx e1 e2 "mul" "fmul"
  | Division (e1, e2) -> ecrire_binaire ctx e1 e2 "sdiv" "fdiv"
  | Modulo (e1, e2) ->
    let (_, v1) = ecrire_expression ctx e1 in
    let (_, v2) = ecrire_expression ctx e2 in
    let r = nom_frais ctx in
    ecrire ctx "  %s = srem i32 %s, %s\n" r v1 v2;
    ("i32", r)
  | Egal (e1, e2) -> ecrire_comparaison ctx e1 e2 "eq" "oeq"
  | Different (e1, e2) -> ecrire_comparaison ctx e1 e2 "ne" "one"
  | Inferieur (e1, e2) -> ecrire_comparaison ctx e1 e2 "slt" "olt"
  | Inferieur_ou_egal (e1, e2) -> ecrire_comparaison ctx e1 e2 "sle" "ole"
  | Superieur (e1, e2) -> ecrire_comparaison ctx e1 e2 "sgt" "ogt"
  | Superieur_ou_egal (e1, e2) -> ecrire_comparaison ctx e1 e2 "sge" "oge"
  | Et (e1, e2) ->
    let (_, v1) = ecrire_expression ctx e1 in
    let (_, v2) = ecrire_expression ctx e2 in
    let b1 = vers_i1 ctx v1 in
    let b2 = vers_i1 ctx v2 in
    let b_and = nom_frais ctx in
    ecrire ctx "  %s = and i1 %s, %s\n" b_and b1 b2;
    let r = nom_frais ctx in
    ecrire ctx "  %s = zext i1 %s to i32\n" r b_and;
    ("i32", r)
  | Ou (e1, e2) ->
    let (_, v1) = ecrire_expression ctx e1 in
    let (_, v2) = ecrire_expression ctx e2 in
    let b1 = vers_i1 ctx v1 in
    let b2 = vers_i1 ctx v2 in
    let b_or = nom_frais ctx in
    ecrire ctx "  %s = or i1 %s, %s\n" b_or b1 b2;
    let r = nom_frais ctx in
    ecrire ctx "  %s = zext i1 %s to i32\n" r b_or;
    ("i32", r)
  | Negatif e ->
    let (t, v) = ecrire_expression ctx e in
    let r = nom_frais ctx in
    if t = "double" then
      ecrire ctx "  %s = fneg double %s\n" r v
    else
      ecrire ctx "  %s = sub i32 0, %s\n" r v;
    (t, r)
  | Chaine_caractere s ->
    let (nom, len) = enregistrer_chaine ctx s in
    let ptr = nom_frais ctx in
    ecrire ctx "  %s = getelementptr [%d x i8], [%d x i8]* %s, i32 0, i32 0\n" ptr len len nom;
    ("i8*", ptr)
  | RacineCarre e ->
    let (t, v) = ecrire_expression ctx e in
    let v_double = if t = "double" then v else
      let conv = nom_frais ctx in
      ecrire ctx "  %s = sitofp i32 %s to double\n" conv v; conv
    in
    let r = nom_frais ctx in
    ecrire ctx "  %s = call double @sqrt(double %s)\n" r v_double;
    ("double", r)
  | Puissance (e1, e2) ->
    let (t1, v1) = ecrire_expression ctx e1 in
    let (t2, v2) = ecrire_expression ctx e2 in
    let v1_double = if t1 = "double" then v1 else
      let conv = nom_frais ctx in
      ecrire ctx "  %s = sitofp i32 %s to double\n" conv v1; conv
    in
    let v2_double = if t2 = "double" then v2 else
      let conv = nom_frais ctx in
      ecrire ctx "  %s = sitofp i32 %s to double\n" conv v2; conv
    in
    let r = nom_frais ctx in
    ecrire ctx "  %s = call double @pow(double %s, double %s)\n" r v1_double v2_double;
    ("double", r)
  | ValeurAbsolue e ->
    let (t, v) = ecrire_expression ctx e in
    let r = nom_frais ctx in
    if t = "double" then begin
      ecrire ctx "  %s = call double @fabs(double %s)\n" r v;
      ("double", r)
    end else begin
      ecrire ctx "  %s = call i32 @abs(i32 %s)\n" r v;
      ("i32", r)
    end
  | Aleatoire (e1, e2) ->
    let (_, v1) = ecrire_expression ctx e1 in
    let (_, v2) = ecrire_expression ctx e2 in
    let rand_val = nom_frais ctx in
    ecrire ctx "  %s = call i32 @rand()\n" rand_val;
    let range = nom_frais ctx in
    ecrire ctx "  %s = sub i32 %s, %s\n" range v2 v1;
    let range_plus1 = nom_frais ctx in
    ecrire ctx "  %s = add i32 %s, 1\n" range_plus1 range;
    let modulo = nom_frais ctx in
    ecrire ctx "  %s = srem i32 %s, %s\n" modulo rand_val range_plus1;
    let r = nom_frais ctx in
    ecrire ctx "  %s = add i32 %s, %s\n" r modulo v1;
    ("i32", r)
  | AccesTableau (nom, index) ->
    let nom_min = String.lowercase_ascii nom in
    let (typ, ptr) = trouver_variable ctx nom_min in
    let type_elem = (match typ with TypeTableau inner -> inner | _ -> TypeEntier) in
    let t_elem = type_llvm type_elem in
    let (_, idx_val) = ecrire_expression ctx index in
    let tab = nom_frais ctx in
    ecrire ctx "  %s = load %%Tableau*, %%Tableau** %s\n" tab ptr;
    let data_ptr = nom_frais ctx in
    ecrire ctx "  %s = getelementptr %%Tableau, %%Tableau* %s, i32 0, i32 0\n" data_ptr tab;
    let data = nom_frais ctx in
    ecrire ctx "  %s = load i8*, i8** %s\n" data data_ptr;
    let typed_data = nom_frais ctx in
    ecrire ctx "  %s = bitcast i8* %s to %s*\n" typed_data data t_elem;
    let elem_ptr = nom_frais ctx in
    ecrire ctx "  %s = getelementptr %s, %s* %s, i32 %s\n" elem_ptr t_elem t_elem typed_data idx_val;
    let elem = nom_frais ctx in
    ecrire ctx "  %s = load %s, %s* %s\n" elem t_elem t_elem elem_ptr;
    (t_elem, elem)
  | TailleTableau nom ->
    let nom_min = String.lowercase_ascii nom in
    let (_, ptr) = trouver_variable ctx nom_min in
    let tab = nom_frais ctx in
    ecrire ctx "  %s = load %%Tableau*, %%Tableau** %s\n" tab ptr;
    let sz_ptr = nom_frais ctx in
    ecrire ctx "  %s = getelementptr %%Tableau, %%Tableau* %s, i32 0, i32 1\n" sz_ptr tab;
    let sz = nom_frais ctx in
    ecrire ctx "  %s = load i32, i32* %s\n" sz sz_ptr;
    ("i32", sz)
  | Appel_recette (nom, args) ->
    let args_vals = List.map (ecrire_expression ctx) args in
    let (_, type_retour) = trouver_fonction ctx nom in
    let t_ret = type_llvm type_retour in
    let args_str = String.concat ", " (List.map (fun (t, v) -> t ^ " " ^ v) args_vals) in
    if type_retour = TypeNeant then begin
      ecrire ctx "  call void @%s(%s)\n" nom args_str;
      ("void", "")
    end else begin
      let r = nom_frais ctx in
      ecrire ctx "  %s = call %s @%s(%s)\n" r t_ret nom args_str;
      (t_ret, r)
    end
  | _ ->
    ecrire ctx "  ; TODO: expression non supportée\n";
    ("i32", "0")

and ecrire_binaire ctx e1 e2 op_int op_float =
  let (t1, v1) = ecrire_expression ctx e1 in
  let (t2, v2) = ecrire_expression ctx e2 in
  let (t, v1, v2) = promouvoir ctx t1 v1 t2 v2 in
  let r = nom_frais ctx in
  let op = if t = "double" then op_float else op_int in
  ecrire ctx "  %s = %s %s %s, %s\n" r op t v1 v2;
  (t, r)

and ecrire_comparaison ctx e1 e2 pred_int pred_float =
  let (t1, v1) = ecrire_expression ctx e1 in
  let (t2, v2) = ecrire_expression ctx e2 in
  let (t, v1, v2) = promouvoir ctx t1 v1 t2 v2 in
  let cmp = nom_frais ctx in
  if t = "double" then
    ecrire ctx "  %s = fcmp %s double %s, %s\n" cmp pred_float v1 v2
  else
    ecrire ctx "  %s = icmp %s i32 %s, %s\n" cmp pred_int v1 v2;
  let r = nom_frais ctx in
  ecrire ctx "  %s = zext i1 %s to i32\n" r cmp;
  ("i32", r)

and promouvoir ctx t1 v1 t2 v2 =
  if t1 = t2 then (t1, v1, v2)
  else if t1 = "double" then
    let v2' = nom_frais ctx in
    ecrire ctx "  %s = sitofp i32 %s to double\n" v2' v2;
    ("double", v1, v2')
  else
    let v1' = nom_frais ctx in
    ecrire ctx "  %s = sitofp i32 %s to double\n" v1' v1;
    ("double", v1', v2)
