open Ast
open Llvm_contexte
open Llvm_types
open Llvm_expressions

let ecrire_assignation ctx (var, expr) =
  let var_min = String.lowercase_ascii var in
  match expr with
  | Tableau elements ->
    let type_elem = match elements with
      | Entier _ :: _ -> TypeEntier
      | Reel _ :: _ -> TypeReel
      | Vrai :: _ | Faux :: _ -> TypeBooleen
      | Chaine_caractere _ :: _ -> TypeChaineCaractere
      | _ -> TypeEntier
    in
    Llvm_tableaux.ecrire_creation_tableau ctx ecrire_expression var_min type_elem elements
  | _ ->
    let (typ_llvm, valeur) = ecrire_expression ctx expr in
    if variable_existe ctx var_min then begin
      let (_, ptr) = trouver_variable ctx var_min in
      ecrire ctx "  store %s %s, %s* %s\n" typ_llvm valeur typ_llvm ptr
    end else begin
      let ptr = Printf.sprintf "%%%s" var_min in
      ecrire ctx "  %s = alloca %s\n" ptr typ_llvm;
      ecrire ctx "  store %s %s, %s* %s\n" typ_llvm valeur typ_llvm ptr;
      ajouter_variable ctx var_min (llvm_vers_type typ_llvm) ptr
    end

let ecrire_printf ctx expr =
  match expr with
  | Chaine_caractere s ->
    let (nom, len) = enregistrer_chaine ctx (s ^ "\n") in
    let ptr = nom_frais ctx in
    ecrire ctx "  %s = getelementptr [%d x i8], [%d x i8]* %s, i32 0, i32 0\n" ptr len len nom;
    ecrire ctx "  call i32 (i8*, ...) @printf(i8* %s)\n" ptr
  | ChaineFormatee (textes, vars) ->
    let format_str = Buffer.create 64 in
    List.iteri (fun i texte ->
      Buffer.add_string format_str texte;
      if i < List.length vars then begin
        let var_min = String.lowercase_ascii (List.nth vars i) in
        let (typ, _) = trouver_variable ctx var_min in
        Buffer.add_string format_str (if typ = TypeReel then "%f" else "%d")
      end
    ) textes;
    Buffer.add_string format_str "\n";
    let (nom, len) = enregistrer_chaine ctx (Buffer.contents format_str) in
    let fmt_ptr = nom_frais ctx in
    ecrire ctx "  %s = getelementptr [%d x i8], [%d x i8]* %s, i32 0, i32 0\n" fmt_ptr len len nom;
    let vals = List.map (fun var ->
      let var_min = String.lowercase_ascii var in
      let (typ, ptr) = trouver_variable ctx var_min in
      let t = type_llvm typ in
      let v = nom_frais ctx in
      ecrire ctx "  %s = load %s, %s* %s\n" v t t ptr;
      (t, v)
    ) vars in
    let args_str = String.concat "" (List.map (fun (t, v) ->
      Printf.sprintf ", %s %s" t v
    ) vals) in
    ecrire ctx "  call i32 (i8*, ...) @printf(i8* %s%s)\n" fmt_ptr args_str
  | _ ->
    let (typ, valeur) = ecrire_expression ctx expr in
    let (fmt_nom, fmt_len) = if typ = "double" then ("@.fmt_f", 4) else ("@.fmt_d", 4) in
    let ptr = nom_frais ctx in
    ecrire ctx "  %s = getelementptr [%d x i8], [%d x i8]* %s, i32 0, i32 0\n" ptr fmt_len fmt_len fmt_nom;
    if typ = "double" then
      ecrire ctx "  call i32 (i8*, ...) @printf(i8* %s, double %s)\n" ptr valeur
    else
      ecrire ctx "  call i32 (i8*, ...) @printf(i8* %s, i32 %s)\n" ptr valeur

let ecrire_lire ctx var =
  let var_min = String.lowercase_ascii var in
  let (typ, ptr) = trouver_variable ctx var_min in
  let fmt = match typ with
    | TypeEntier -> "%d"
    | TypeReel -> "%lf"
    | _ -> raise (Erreurs.Erreur_type "Lire ne supporte que les types entier et réel")
  in
  let (nom, len) = enregistrer_chaine ctx fmt in
  let fmt_ptr = nom_frais ctx in
  ecrire ctx "  %s = getelementptr [%d x i8], [%d x i8]* %s, i32 0, i32 0\n" fmt_ptr len len nom;
  ecrire ctx "  call i32 (i8*, ...) @scanf(i8* %s, %s* %s)\n" fmt_ptr (type_llvm typ) ptr

let ecrire_xcrementer ctx var expression signe =
  let var_min = String.lowercase_ascii var in
  let (typ, ptr) = trouver_variable ctx var_min in
  let t = type_llvm typ in
  let current = nom_frais ctx in
  ecrire ctx "  %s = load %s, %s* %s\n" current t t ptr;
  let amount = match expression with
    | None -> "1"
    | Some expr -> let (_, v) = ecrire_expression ctx expr in v
  in
  let result = nom_frais ctx in
  let op = if signe = "+" then "add" else "sub" in
  ecrire ctx "  %s = %s %s %s, %s\n" result op t current amount;
  ecrire ctx "  store %s %s, %s* %s\n" t result t ptr

let ecrire_incrementer ctx var expr = ecrire_xcrementer ctx var expr "+"
let ecrire_decrementer ctx var expr = ecrire_xcrementer ctx var expr "-"

let ecrire_permuter ctx v1 v2 =
  let v1_min = String.lowercase_ascii v1 in
  let v2_min = String.lowercase_ascii v2 in
  let (t1, ptr1) = trouver_variable ctx v1_min in
  let (_, ptr2) = trouver_variable ctx v2_min in
  let t = type_llvm t1 in
  let val1 = nom_frais ctx in
  let val2 = nom_frais ctx in
  ecrire ctx "  %s = load %s, %s* %s\n" val1 t t ptr1;
  ecrire ctx "  %s = load %s, %s* %s\n" val2 t t ptr2;
  ecrire ctx "  store %s %s, %s* %s\n" t val2 t ptr1;
  ecrire ctx "  store %s %s, %s* %s\n" t val1 t ptr2
