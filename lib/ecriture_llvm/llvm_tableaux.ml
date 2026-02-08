open Ast
open Llvm_contexte
open Llvm_types

let ecrire_helpers_tableaux ctx =
  ecrire ctx "define %%Tableau* @nouveau_tableau(i32 %%cap, i32 %%elem_size) {\n";
  ecrire ctx "entry:\n";
  ecrire ctx "  %%ptr = call i8* @malloc(i32 20)\n";
  ecrire ctx "  %%t = bitcast i8* %%ptr to %%Tableau*\n";
  ecrire ctx "  %%data_size = mul i32 %%cap, %%elem_size\n";
  ecrire ctx "  %%data = call i8* @malloc(i32 %%data_size)\n";
  ecrire ctx "  %%f0 = getelementptr %%Tableau, %%Tableau* %%t, i32 0, i32 0\n";
  ecrire ctx "  store i8* %%data, i8** %%f0\n";
  ecrire ctx "  %%f1 = getelementptr %%Tableau, %%Tableau* %%t, i32 0, i32 1\n";
  ecrire ctx "  store i32 0, i32* %%f1\n";
  ecrire ctx "  %%f2 = getelementptr %%Tableau, %%Tableau* %%t, i32 0, i32 2\n";
  ecrire ctx "  store i32 %%cap, i32* %%f2\n";
  ecrire ctx "  %%f3 = getelementptr %%Tableau, %%Tableau* %%t, i32 0, i32 3\n";
  ecrire ctx "  store i32 %%elem_size, i32* %%f3\n";
  ecrire ctx "  ret %%Tableau* %%t\n";
  ecrire ctx "}\n\n";
  ecrire ctx "define void @ajouter_element(%%Tableau* %%t, i8* %%val) {\n";
  ecrire ctx "entry:\n";
  ecrire ctx "  %%sz_ptr = getelementptr %%Tableau, %%Tableau* %%t, i32 0, i32 1\n";
  ecrire ctx "  %%sz = load i32, i32* %%sz_ptr\n";
  ecrire ctx "  %%cap_ptr = getelementptr %%Tableau, %%Tableau* %%t, i32 0, i32 2\n";
  ecrire ctx "  %%cap = load i32, i32* %%cap_ptr\n";
  ecrire ctx "  %%need_grow = icmp sge i32 %%sz, %%cap\n";
  ecrire ctx "  br i1 %%need_grow, label %%grow, label %%copy\n";
  ecrire ctx "grow:\n";
  ecrire ctx "  %%new_cap = mul i32 %%cap, 2\n";
  ecrire ctx "  store i32 %%new_cap, i32* %%cap_ptr\n";
  ecrire ctx "  %%es_ptr = getelementptr %%Tableau, %%Tableau* %%t, i32 0, i32 3\n";
  ecrire ctx "  %%es = load i32, i32* %%es_ptr\n";
  ecrire ctx "  %%new_size = mul i32 %%new_cap, %%es\n";
  ecrire ctx "  %%d_ptr = getelementptr %%Tableau, %%Tableau* %%t, i32 0, i32 0\n";
  ecrire ctx "  %%old_d = load i8*, i8** %%d_ptr\n";
  ecrire ctx "  %%new_d = call i8* @realloc(i8* %%old_d, i32 %%new_size)\n";
  ecrire ctx "  store i8* %%new_d, i8** %%d_ptr\n";
  ecrire ctx "  br label %%copy\n";
  ecrire ctx "copy:\n";
  ecrire ctx "  %%elem_sz_ptr = getelementptr %%Tableau, %%Tableau* %%t, i32 0, i32 3\n";
  ecrire ctx "  %%elem_sz = load i32, i32* %%elem_sz_ptr\n";
  ecrire ctx "  %%data_ptr = getelementptr %%Tableau, %%Tableau* %%t, i32 0, i32 0\n";
  ecrire ctx "  %%data = load i8*, i8** %%data_ptr\n";
  ecrire ctx "  %%cur_sz = load i32, i32* %%sz_ptr\n";
  ecrire ctx "  %%offset = mul i32 %%cur_sz, %%elem_sz\n";
  ecrire ctx "  %%dest = getelementptr i8, i8* %%data, i32 %%offset\n";
  ecrire ctx "  call void @llvm.memcpy.p0i8.p0i8.i32(i8* %%dest, i8* %%val, i32 %%elem_sz, i1 false)\n";
  ecrire ctx "  %%new_sz = add i32 %%cur_sz, 1\n";
  ecrire ctx "  store i32 %%new_sz, i32* %%sz_ptr\n";
  ecrire ctx "  ret void\n";
  ecrire ctx "}\n\n";
  ecrire ctx "define void @liberer_tableau(%%Tableau* %%t) {\n";
  ecrire ctx "entry:\n";
  ecrire ctx "  %%d_ptr = getelementptr %%Tableau, %%Tableau* %%t, i32 0, i32 0\n";
  ecrire ctx "  %%d = load i8*, i8** %%d_ptr\n";
  ecrire ctx "  call void @free(i8* %%d)\n";
  ecrire ctx "  %%t_i8 = bitcast %%Tableau* %%t to i8*\n";
  ecrire ctx "  call void @free(i8* %%t_i8)\n";
  ecrire ctx "  ret void\n";
  ecrire ctx "}\n\n"

let ecrire_creation_tableau ctx ecrire_expr var_min type_elem elements =
  let t_elem = type_llvm type_elem in
  let nb = List.length elements in
  let sz = sizeof_llvm t_elem in
  let tab_ptr = nom_frais ctx in
  ecrire ctx "  %s = call %%Tableau* @nouveau_tableau(i32 %d, i32 %d)\n" tab_ptr nb sz;
  List.iter (fun elem ->
    let (_, v) = ecrire_expr ctx elem in
    let tmp = nom_frais ctx in
    ecrire ctx "  %s = alloca %s\n" tmp t_elem;
    ecrire ctx "  store %s %s, %s* %s\n" t_elem v t_elem tmp;
    let tmp_i8 = nom_frais ctx in
    ecrire ctx "  %s = bitcast %s* %s to i8*\n" tmp_i8 t_elem tmp;
    ecrire ctx "  call void @ajouter_element(%%Tableau* %s, i8* %s)\n" tab_ptr tmp_i8
  ) elements;
  let ptr = Printf.sprintf "%%%s" var_min in
  if variable_existe ctx var_min then begin
    let (_, old_ptr) = trouver_variable ctx var_min in
    ecrire ctx "  store %%Tableau* %s, %%Tableau** %s\n" tab_ptr old_ptr
  end else begin
    ecrire ctx "  %s = alloca %%Tableau*\n" ptr;
    ecrire ctx "  store %%Tableau* %s, %%Tableau** %s\n" tab_ptr ptr;
    ajouter_variable ctx var_min (TypeTableau type_elem) ptr
  end

let ecrire_modification_tableau ctx ecrire_expr nom index valeur =
  let nom_min = String.lowercase_ascii nom in
  let (typ, ptr) = trouver_variable ctx nom_min in
  let type_elem = (match typ with TypeTableau inner -> inner | _ -> TypeEntier) in
  let t_elem = type_llvm type_elem in
  let (_, idx_val) = ecrire_expr ctx index in
  let (_, val_v) = ecrire_expr ctx valeur in
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
  ecrire ctx "  store %s %s, %s* %s\n" t_elem val_v t_elem elem_ptr

let ecrire_ajouter_tableau ctx ecrire_expr nom valeur =
  let nom_min = String.lowercase_ascii nom in
  let (typ, ptr) = trouver_variable ctx nom_min in
  let type_elem = (match typ with TypeTableau inner -> inner | _ -> TypeEntier) in
  let t_elem = type_llvm type_elem in
  let (_, val_v) = ecrire_expr ctx valeur in
  let tab = nom_frais ctx in
  ecrire ctx "  %s = load %%Tableau*, %%Tableau** %s\n" tab ptr;
  let tmp = nom_frais ctx in
  ecrire ctx "  %s = alloca %s\n" tmp t_elem;
  ecrire ctx "  store %s %s, %s* %s\n" t_elem val_v t_elem tmp;
  let tmp_i8 = nom_frais ctx in
  ecrire ctx "  %s = bitcast %s* %s to i8*\n" tmp_i8 t_elem tmp;
  ecrire ctx "  call void @ajouter_element(%%Tableau* %s, i8* %s)\n" tab tmp_i8

let ecrire_liberation_tableaux ctx portee_base =
  List.iter (fun (nom, typ, ptr) ->
    if not (List.exists (fun (n, _, _) -> n = nom) portee_base) then
      match typ with
      | TypeTableau _ ->
        let tab = nom_frais ctx in
        ecrire ctx "  %s = load %%Tableau*, %%Tableau** %s\n" tab ptr;
        ecrire ctx "  call void @liberer_tableau(%%Tableau* %s)\n" tab
      | _ -> ()
  ) ctx.portee

let ecrire_pour_chaque ctx ecrire_ast element_var array_name corps =
  let array_min = String.lowercase_ascii array_name in
  let element_min = String.lowercase_ascii element_var in
  let (typ, arr_ptr) = trouver_variable ctx array_min in
  let type_elem = (match typ with TypeTableau inner -> inner | _ -> TypeEntier) in
  let t_elem = type_llvm type_elem in
  let idx_var = Printf.sprintf "%%_idx_%s" array_min in
  ecrire ctx "  %s = alloca i32\n" idx_var;
  ecrire ctx "  store i32 0, i32* %s\n" idx_var;
  let label_cond = label_frais ctx "cond_foreach" in
  let label_corps = label_frais ctx "corps_foreach" in
  let label_fin = label_frais ctx "fin_foreach" in
  ecrire ctx "  br label %%%s\n" label_cond;
  ecrire ctx "%s:\n" label_cond;
  ctx.bloc_termine <- false;
  let i_val = nom_frais ctx in
  ecrire ctx "  %s = load i32, i32* %s\n" i_val idx_var;
  let tab = nom_frais ctx in
  ecrire ctx "  %s = load %%Tableau*, %%Tableau** %s\n" tab arr_ptr;
  let sz_ptr = nom_frais ctx in
  ecrire ctx "  %s = getelementptr %%Tableau, %%Tableau* %s, i32 0, i32 1\n" sz_ptr tab;
  let sz = nom_frais ctx in
  ecrire ctx "  %s = load i32, i32* %s\n" sz sz_ptr;
  let cmp = nom_frais ctx in
  ecrire ctx "  %s = icmp slt i32 %s, %s\n" cmp i_val sz;
  ecrire ctx "  br i1 %s, label %%%s, label %%%s\n" cmp label_corps label_fin;
  ecrire ctx "%s:\n" label_corps;
  ctx.bloc_termine <- false;
  let tab2 = nom_frais ctx in
  ecrire ctx "  %s = load %%Tableau*, %%Tableau** %s\n" tab2 arr_ptr;
  let data_ptr = nom_frais ctx in
  ecrire ctx "  %s = getelementptr %%Tableau, %%Tableau* %s, i32 0, i32 0\n" data_ptr tab2;
  let data = nom_frais ctx in
  ecrire ctx "  %s = load i8*, i8** %s\n" data data_ptr;
  let typed_data = nom_frais ctx in
  ecrire ctx "  %s = bitcast i8* %s to %s*\n" typed_data data t_elem;
  let i_val2 = nom_frais ctx in
  ecrire ctx "  %s = load i32, i32* %s\n" i_val2 idx_var;
  let elem_ptr_val = nom_frais ctx in
  ecrire ctx "  %s = getelementptr %s, %s* %s, i32 %s\n" elem_ptr_val t_elem t_elem typed_data i_val2;
  let elem = nom_frais ctx in
  ecrire ctx "  %s = load %s, %s* %s\n" elem t_elem t_elem elem_ptr_val;
  let elem_var_ptr = Printf.sprintf "%%%s" element_min in
  ecrire ctx "  %s = alloca %s\n" elem_var_ptr t_elem;
  ecrire ctx "  store %s %s, %s* %s\n" t_elem elem t_elem elem_var_ptr;
  let portee_sauvee = sauvegarder_portee ctx in
  ajouter_variable ctx element_min type_elem elem_var_ptr;
  List.iter (ecrire_ast ctx) corps;
  restaurer_portee ctx portee_sauvee;
  let i_val3 = nom_frais ctx in
  ecrire ctx "  %s = load i32, i32* %s\n" i_val3 idx_var;
  let i_inc = nom_frais ctx in
  ecrire ctx "  %s = add i32 %s, 1\n" i_inc i_val3;
  ecrire ctx "  store i32 %s, i32* %s\n" i_inc idx_var;
  if not ctx.bloc_termine then
    ecrire ctx "  br label %%%s\n" label_cond;
  ecrire ctx "%s:\n" label_fin;
  ctx.bloc_termine <- false
