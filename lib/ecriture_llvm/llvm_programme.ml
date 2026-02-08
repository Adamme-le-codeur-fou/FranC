open Ast
open Llvm_contexte
open Llvm_types
open Llvm_expressions
open Llvm_instructions
open Llvm_blocs

let rec llvm_ecrire_ast ctx ast =
  if ctx.bloc_termine then ()
  else match ast with
  | Localise (_, inner) -> llvm_ecrire_ast ctx inner
  | Assigne (Mot mot, expression) -> ecrire_assignation ctx (mot, expression)
  | Afficher expression -> ecrire_printf ctx expression
  | Condition (cond, alors, sinon_opt) -> ecrire_condition ctx llvm_ecrire_ast cond alors sinon_opt
  | BoucleTantQue (cond, corps) -> ecrire_boucle ctx llvm_ecrire_ast cond corps
  | ForInclus (var, s, e, corps) -> ecrire_for ctx llvm_ecrire_ast var s e true corps
  | ForExclus (var, s, e, corps) -> ecrire_for ctx llvm_ecrire_ast var s e false corps
  | Increment (var, expr) -> ecrire_incrementer ctx var expr
  | Decrement (var, expr) -> ecrire_decrementer ctx var expr
  | Permuter (v1, v2) -> ecrire_permuter ctx v1 v2
  | Paragraphe liste -> List.iter (llvm_ecrire_ast ctx) liste
  | Renvoyer expr ->
    let (t, v) = ecrire_expression ctx expr in
    ecrire ctx "  ret %s %s\n" t v;
    ctx.bloc_termine <- true
  | Lire var -> ecrire_lire ctx var
  | ModificationTableau (nom, index, valeur) -> Llvm_tableaux.ecrire_modification_tableau ctx ecrire_expression nom index valeur
  | AjouterTableau (nom, valeur) -> Llvm_tableaux.ecrire_ajouter_tableau ctx ecrire_expression nom valeur
  | PourChaque (element, tableau, corps) -> Llvm_tableaux.ecrire_pour_chaque ctx llvm_ecrire_ast element tableau corps
  | Recette _ -> ()
  | Appel_recette (_, _) -> ignore (ecrire_expression ctx ast)
  | _ -> ecrire ctx "  ; TODO: instruction non supportée\n"

let ecrire_fonction ctx nom arguments type_retour corps =
  let t_ret = if type_retour = TypeNeant then "void" else type_llvm type_retour in
  let params_str = String.concat ", " (List.map (fun (n, t) ->
    Printf.sprintf "%s %%%s.param" (type_llvm t) (String.lowercase_ascii n)
  ) arguments) in
  ecrire ctx "define %s @%s(%s) {\n" t_ret nom params_str;
  ecrire ctx "entry:\n";
  let portee_sauvee = sauvegarder_portee ctx in
  ctx.portee <- [];
  List.iter (fun (n, t) ->
    let nom_min = String.lowercase_ascii n in
    let ptr = Printf.sprintf "%%%s" nom_min in
    let tl = type_llvm t in
    ecrire ctx "  %s = alloca %s\n" ptr tl;
    ecrire ctx "  store %s %%%s.param, %s* %s\n" tl nom_min tl ptr;
    ajouter_variable ctx nom_min t ptr
  ) arguments;
  enregistrer_fonction ctx nom (List.map snd arguments) type_retour;
  List.iter (llvm_ecrire_ast ctx) corps;
  (if type_retour = TypeNeant then
    ecrire ctx "  ret void\n");
  ecrire ctx "}\n\n";
  restaurer_portee ctx portee_sauvee;
  ctx.bloc_termine <- false

let rec ecrire_fonctions_pre_main ctx ast =
  match ast with
  | Recette (nom, arguments, type_retour, corps) ->
    ecrire_fonction ctx nom arguments type_retour corps
  | Localise (_, inner) -> ecrire_fonctions_pre_main ctx inner
  | Paragraphe l -> List.iter (ecrire_fonctions_pre_main ctx) l
  | _ -> ()

let generer arbre canal nom_programme =
  let ctx = creer () in
  if Prelude.utilise_tableaux arbre then
    Llvm_tableaux.ecrire_helpers_tableaux ctx;
  ecrire_fonctions_pre_main ctx arbre;
  ecrire ctx "define i32 @main() {\n";
  ecrire ctx "entry:\n";
  let (nom_str, nom_len) = enregistrer_chaine ctx ("Programme : " ^ nom_programme ^ "\n") in
  let ptr = nom_frais ctx in
  ecrire ctx "  %s = getelementptr [%d x i8], [%d x i8]* %s, i32 0, i32 0\n" ptr nom_len nom_len nom_str;
  ecrire ctx "  call i32 (i8*, ...) @printf(i8* %s)\n" ptr;
  if Prelude.utilise_aleatoire arbre then begin
    let time_val = nom_frais ctx in
    ecrire ctx "  %s = call i64 @time(i64* null)\n" time_val;
    let seed = nom_frais ctx in
    ecrire ctx "  %s = trunc i64 %s to i32\n" seed time_val;
    ecrire ctx "  call void @srand(i32 %s)\n" seed
  end;
  llvm_ecrire_ast ctx arbre;
  Llvm_tableaux.ecrire_liberation_tableaux ctx [];
  ecrire ctx "  ret i32 0\n";
  ecrire ctx "}\n";
  finaliser ctx canal
