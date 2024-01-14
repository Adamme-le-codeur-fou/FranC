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
  | Condition (ast1, ast_list1, ast_list2_opt) -> (
      List.fold_left
        (fun acc elt -> acc || contient_afficher elt)
        (contient_afficher ast1) ast_list1
      ||
      match ast_list2_opt with
      | Some ast_list2 ->
          List.fold_left
            (fun acc elt -> acc || contient_afficher elt)
            false ast_list2
      | None -> false)
  | _ -> false

let affiche a =
  let rec affiche_aux a =
    match a with
    | Phrase (l, p) ->
        print_string "Phrase(";
        print_mot_liste l;
        Printf.printf ", Ponctuation(%s)" p;
        print_string ")\n"
    | Plus (p1, p2) ->
        print_string "(";
        affiche_aux p1;
        print_string " + ";
        affiche_aux p2;
        print_string ")"
    | Fois (p1, p2) ->
        print_string "(";
        affiche_aux p1;
        print_string " * ";
        affiche_aux p2;
        print_string ")"
    | Egal (p1, p2) ->
        print_string "(";
        affiche_aux p1;
        print_string " == ";
        affiche_aux p2;
        print_string ")"
    | Nombre d -> print_string d
    | Mot m -> print_string (String.lowercase_ascii m)
    | Assigne (m, e) ->
        print_string "int ";
        affiche_aux m;
        print_string " = ";
        affiche_aux e;
        print_string ";\n"
    | Paragraphe l -> List.iter affiche_aux l
    | Afficher s ->
        print_string "printf(\"%d\\n\", ";
        affiche_aux s;
        print_string ");\n"
    | Condition (cond, alors_list, sinon_paragraphe_opt) -> (
        Printf.printf "if (";
        affiche_aux cond;
        Printf.printf ") {\n";
        List.iter affiche_aux alors_list;
        Printf.printf "}\n";
        match sinon_paragraphe_opt with
        | Some sinon_list ->
            Printf.printf "else {\n";
            List.iter affiche_aux sinon_list;
            Printf.printf "}\n"
        | None -> ())
    | Expression expr -> affiche_aux expr
    | _ -> raise TokenInvalide
  in

  if contient_afficher a then print_endline "#include <stdio.h>\n";
  print_string "\nint main(){\n";
  affiche_aux a;
  print_string "\nreturn 0;\n}"
