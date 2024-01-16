exception PhraseInvalide
exception TokenInvalide
exception IncompatibiliteDeType

type type_expression = TypeEntier | TypeReel | TypeBooleen | TypeNeant

type ast =
  | Mot of string
  | Entier of string
  | Reel of string
  | Phrase of ast list * string
  | Plus of ast * ast
  | Egal of ast * ast
  | Fois of ast * ast
  | Modulo of ast * ast
  | Assigne of ast * ast
  | Afficher of ast
  | Paragraphe of ast list
  | Condition of ast * ast list * ast list option
  | Expression of ast
  | BoucleTantQue of ast * ast list
  | Different of ast * ast
  | ForInclus of string * ast * ast * ast list
  | ForExclus of string * ast * ast * ast list
  | Increment of string * ast option

let rec type_de_expression expr =
  match expr with
  | Entier _ -> TypeEntier
  | Reel _ -> TypeReel
  | Plus (expr_gauche, expr_droite) | Fois (expr_gauche, expr_droite) ->
      if
        type_de_expression expr_gauche = TypeReel
        || type_de_expression expr_droite = TypeReel
      then TypeReel
      else TypeEntier
  | Egal _ | Different _ -> TypeBooleen
  | Modulo _ -> TypeEntier
  | _ -> TypeNeant

let ramplacer_caractere ancien_caractere nouveau_caractere chaine_caractere =
  String.map
    (fun caractere_courrant ->
      if caractere_courrant = ancien_caractere then nouveau_caractere
      else caractere_courrant)
    chaine_caractere

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
  | Mot _ | Entier _ | Reel _ -> false
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
  | ForInclus (_, ast1, ast2, ast_list) | ForExclus (_, ast1, ast2, ast_list) ->
      contient_afficher ast1 || contient_afficher ast2
      || List.fold_left
           (fun acc elt -> acc || contient_afficher elt)
           false ast_list
  | _ -> false

type portee = (string * string) list

let variable_est_declaree portee var_name =
  List.exists (fun (name, _) -> name = var_name) portee

(* Fonction pour afficher une expression *)
let rec afficher_expression portee expr =
  match expr with
  | Entier n -> Printf.printf "%s" n
  | Reel r -> Printf.printf "%s" (ramplacer_caractere ',' '.' r)
  | Mot m ->
      let m_minuscule = String.lowercase_ascii m in
      Printf.printf "%s"
        (if variable_est_declaree portee m_minuscule then m_minuscule
         else raise TokenInvalide)
  | Plus (e1, e2) ->
      Printf.printf "(";
      afficher_expression portee e1;
      Printf.printf " + ";
      afficher_expression portee e2;
      Printf.printf ")"
  | Fois (p1, p2) ->
      Printf.printf "(";
      afficher_expression portee p1;
      Printf.printf " * ";
      afficher_expression portee p2;
      Printf.printf ")"
  | Egal (p1, p2) ->
      Printf.printf "(";
      afficher_expression portee p1;
      Printf.printf " == ";
      afficher_expression portee p2;
      Printf.printf ")"
  | Different (p1, p2) ->
      Printf.printf "(";
      afficher_expression portee p1;
      Printf.printf " != ";
      afficher_expression portee p2;
      Printf.printf ")"
  | Modulo (p1, p2) ->
      Printf.printf "(";
      afficher_expression portee p1;
      Printf.printf " %% ";
      afficher_expression portee p2;
      Printf.printf ")"
  | _ -> raise PhraseInvalide

(* Fonction pour afficher une assignation *)
let afficher_assignation portee (var, expr) =
  let var_minuscule = String.lowercase_ascii var in
  let portee_maj =
    if variable_est_declaree portee var_minuscule then portee
    else (var_minuscule, "int") :: portee
  in
  (if not (variable_est_declaree portee var_minuscule) then
     match type_de_expression expr with
     | TypeEntier | TypeBooleen -> Printf.printf "int "
     | TypeNeant -> Printf.printf "void "
     | TypeReel -> Printf.printf "float "
     | _ -> Printf.printf "int ");
  Printf.printf "%s = " var_minuscule;
  afficher_expression portee_maj expr;
  Printf.printf ";\n";
  portee_maj

(* Fonction pour afficher un appel à printf avec la valeur correcte *)
let afficher_printf portee e =
  match e with
  | Entier n -> Printf.printf "printf(\"%%d\\n\", %s);" n
  | Reel r ->
      Printf.printf "printf(\"%%f\\n\", %s);" (ramplacer_caractere ',' '.' r)
  | _ ->
      Printf.printf "printf(\"%%d\\n\", ";
      afficher_expression portee e;
      Printf.printf ");"

let rec afficher_ast portee ast =
  match ast with
  | ForInclus (var, start_expr, end_expr, paragraphe) ->
      afficher_for portee var start_expr end_expr true paragraphe
  | ForExclus (var, start_expr, end_expr, paragraphe) ->
      afficher_for portee var start_expr end_expr false paragraphe
  | Paragraphe l -> List.fold_left afficher_ast portee l
  | Assigne (Mot m, e) -> afficher_assignation portee (m, e)
  | Afficher e ->
      afficher_printf portee e;
      portee
  | Condition (cond, alors_list, sinon_opt) ->
      afficher_condition portee cond alors_list sinon_opt
  | BoucleTantQue (cond, paragraphe) -> afficher_boucle portee cond paragraphe
  | Increment (var, None) ->
      Printf.printf "%s++;\n" (String.lowercase_ascii var);
      portee
  | Increment (var, Some expr) ->
      Printf.printf "%s += " (String.lowercase_ascii var);
      afficher_expression portee expr;
      Printf.printf ";\n";
      portee
  | _ ->
      afficher_expression portee ast;
      portee

(* Fonction pour afficher une condition *)
and afficher_condition portee cond alors_list sinon_opt =
  Printf.printf "if (";
  afficher_expression portee cond;
  Printf.printf ") {\n";
  let portee_apres_alors = List.fold_left afficher_ast portee alors_list in
  Printf.printf "}\n";
  match sinon_opt with
  | Some sinon_list ->
      Printf.printf "else {\n";
      let portee_apres_sinon =
        List.fold_left afficher_ast portee_apres_alors sinon_list
      in
      Printf.printf "}\n";
      portee_apres_sinon
  | None -> portee_apres_alors

(* Fonction pour afficher une boucle 'tant que' *)
and afficher_boucle portee cond paragraphe =
  Printf.printf "while (";
  afficher_expression portee cond;
  Printf.printf ") {\n";
  let portee_apres_boucle = List.fold_left afficher_ast portee paragraphe in
  Printf.printf "}\n";
  portee_apres_boucle

(* Fonction pour afficher une boucle 'for' *)
and afficher_for portee var start_expr end_expr inclusive paragraphe =
  Printf.printf "for (int %s = " (String.lowercase_ascii var);
  afficher_expression portee start_expr;
  Printf.printf "; %s " (String.lowercase_ascii var);
  Printf.printf (if inclusive then "<= " else "< ");
  afficher_expression portee end_expr;
  Printf.printf "; %s++) {\n" (String.lowercase_ascii var);
  let portee_apres_for = (String.lowercase_ascii var, "int") :: portee in
  let _ = List.fold_left afficher_ast portee_apres_for paragraphe in
  Printf.printf "}\n";
  portee_apres_for

let verifier_type attendu obtenu =
  if attendu <> obtenu then raise IncompatibiliteDeType

(* Fonction principale pour afficher le code C *)
let affiche a =
  if contient_afficher a then print_endline "#include <stdio.h>\n";
  print_string "\nint main(){\n";
  let _ = afficher_ast [] a in
  print_string "\nreturn 0;\n}"
