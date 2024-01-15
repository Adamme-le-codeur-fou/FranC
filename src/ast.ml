exception PhraseInvalide
exception TokenInvalide

type ast =
  | Mot of string
  | Nombre of string
  | Phrase of ast list * string
  | Plus of ast * ast
  | Egal of ast * ast
  | Fois of ast * ast
  | Assigne of ast * ast
  | Afficher of ast
  | Paragraphe of ast list
  | Condition of ast * ast list * ast list option
  | Expression of ast
  | BoucleTantQue of ast * ast list
  | Different of ast * ast

let rec print_mot_liste l =
  match l with
  | [] -> ()
  | Mot m :: q ->
      Printf.printf "mot(%s)%s" m (if q = [] then "" else ", ");
      print_mot_liste q
  | _ -> raise PhraseInvalide

let rec contient_afficher a =
  match a with
  | Afficher _ -> true
  | Mot _ | Nombre _ -> false
  | Plus (ast1, ast2)
  | Egal (ast1, ast2)
  | Fois (ast1, ast2)
  | Assigne (ast1, ast2) ->
      contient_afficher ast1 || contient_afficher ast2
  | Paragraphe ast_list ->
      List.fold_left
        (fun acc elt -> acc || contient_afficher elt)
        false ast_list
  | Condition (ast1, p1, p2_opt) -> (
      contient_afficher ast1
      || List.fold_left (fun acc elt -> acc || contient_afficher elt) false p1
      ||
      match p2_opt with
      | Some p2 ->
          List.fold_left (fun acc elt -> acc || contient_afficher elt) false p2
      | None -> false)
  | BoucleTantQue (ast1, ast_list) ->
      contient_afficher ast1
      || List.fold_left
           (fun acc elt -> acc || contient_afficher elt)
           false ast_list
  | _ -> false

type scope = (string * string) list

let variable_est_declaree scope var_name =
  List.exists (fun (name, _) -> name = var_name) scope

let rec affiche_aux scope a =
  match a with
  | Phrase (l, p) ->
      print_string "Phrase(";
      print_string ")\n";
      scope
  | Plus (p1, p2) ->
      print_string "(";
      affiche_aux scope p1;
      print_string " + ";
      affiche_aux scope p2;
      print_string ")";
      scope
  | Fois (p1, p2) ->
      print_string "(";
      affiche_aux scope p1;
      print_string " * ";
      affiche_aux scope p2;
      print_string ")";
      scope
  | Egal (p1, p2) ->
      print_string "(";
      affiche_aux scope p1;
      print_string " == ";
      affiche_aux scope p2;
      print_string ")";
      scope
  | Nombre d ->
      print_string d;
      scope
  | Mot m ->
      print_string (String.lowercase_ascii m);
      scope
  | Assigne (Mot m, e) ->
      let doit_declarer = not (variable_est_declaree scope m) in
      let new_scope = if doit_declarer then (m, "int") :: scope else scope in
      if doit_declarer then print_string "int ";
      let _ = affiche_aux new_scope (Mot m) in
      print_string " = ";
      let _ = affiche_aux new_scope e in
      print_string ";\n";
      new_scope
  | Paragraphe l ->
      List.fold_left (fun acc_scope expr -> affiche_aux acc_scope expr) scope l
  | Afficher s ->
      print_string "printf(\"%d\\n\", ";
      let _ = affiche_aux scope s in
      print_string ");\n";
      scope
  | Condition (cond, alors_list, sinon_paragraphe_opt) -> (
      Printf.printf "if (";
      let _ = affiche_aux scope cond in
      Printf.printf ") {\n";
      let new_scope = List.fold_left affiche_aux scope alors_list in
      Printf.printf "}\n";
      match sinon_paragraphe_opt with
      | Some sinon_list ->
          Printf.printf "else {\n";
          let new_scope = List.fold_left affiche_aux new_scope sinon_list in
          Printf.printf "}\n";
          new_scope
      | None -> new_scope)
  | BoucleTantQue (cond, paragraphe) ->
      Printf.printf "while (";
      affiche_aux scope cond;
      Printf.printf ") {\n";
      let new_scope = List.fold_left affiche_aux scope paragraphe in
      Printf.printf "}\n";
      new_scope
  | Different (p1, p2) ->
      print_string "(";
      affiche_aux scope p1;
      print_string " != ";
      affiche_aux scope p2;
      print_string ")";
      scope
  | _ -> scope (* pour les autres cas *)

let affiche a =
  let rec affiche_main scope a =
    match a with
    | Paragraphe l ->
        List.fold_left
          (fun acc_scope expr -> affiche_main acc_scope expr)
          scope l
    | _ -> affiche_aux scope a
  in
  if contient_afficher a then print_endline "#include <stdio.h>\n";
  print_string "\nint main(){\n";
  let _ = affiche_main [] a in
  print_string "\nreturn 0;\n}"
