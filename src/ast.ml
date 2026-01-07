exception PhraseInvalide
exception TokenInvalide
exception IncompatibiliteDeType

type type_expression = TypeEntier | TypeReel | TypeBooleen | TypeNeant

type ast =
  | Mot of string
  | Entier of string
  | Reel of string
  | Chaine_caractere of string
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
  | Decrement of string * ast option

  
let oc = ref stdout

let rec type_de_expression portee expr =
  match expr with
  | Entier _ -> TypeEntier
  | Reel _ -> TypeReel
  | Plus (expr_gauche, expr_droite) | Fois (expr_gauche, expr_droite) ->
    if
      type_de_expression portee expr_gauche = TypeReel
      || type_de_expression portee expr_droite = TypeReel
    then TypeReel
    else TypeEntier
  | Egal _ | Different _ -> TypeBooleen
  | Modulo _ -> TypeEntier
  | Mot m -> begin
    let m_minuscule = String.lowercase_ascii m in
      match List.assoc m_minuscule portee with
      | "int" -> TypeEntier
      | "float" -> TypeReel
      | "bool" -> TypeBooleen
      | _ -> TypeNeant
      end
  | _ -> TypeNeant

let remplacer_caractere ancien_caractere nouveau_caractere chaine_caractere =
  String.map
    (fun caractere_courrant ->
       if caractere_courrant = ancien_caractere then nouveau_caractere
       else caractere_courrant)
    chaine_caractere

let rec print_mot_liste l =
  match l with
  | [] -> ()
  | Mot m :: q ->
    Printf.fprintf !oc "mot(%s)%s" m (if q = [] then "" else ", ");
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
  | Entier n -> Printf.fprintf !oc "%s" n
  | Reel r -> Printf.fprintf !oc "%s" (remplacer_caractere ',' '.' r)
  | Mot m ->
    let m_minuscule = String.lowercase_ascii m in
    Printf.fprintf !oc "%s"
      (if variable_est_declaree portee m_minuscule then m_minuscule
       else raise TokenInvalide)
  | Plus (e1, e2) ->
    Printf.fprintf !oc "(";
    afficher_expression portee e1;
    Printf.fprintf !oc " + ";
    afficher_expression portee e2;
    Printf.fprintf !oc ")"
  | Fois (p1, p2) ->
    Printf.fprintf !oc "(";
    afficher_expression portee p1;
    Printf.fprintf !oc " * ";
    afficher_expression portee p2;
    Printf.fprintf !oc ")"
  | Egal (p1, p2) ->
    Printf.fprintf !oc "(";
    afficher_expression portee p1;
    Printf.fprintf !oc " == ";
    afficher_expression portee p2;
    Printf.fprintf !oc ")"
  | Different (p1, p2) ->
    Printf.fprintf !oc "(";
    afficher_expression portee p1;
    Printf.fprintf !oc " != ";
    afficher_expression portee p2;
    Printf.fprintf !oc ")"
  | Modulo (p1, p2) ->
    Printf.fprintf !oc "(";
    afficher_expression portee p1;
    Printf.fprintf !oc " %% ";
    afficher_expression portee p2;
    Printf.fprintf !oc ")"
  | _ -> raise PhraseInvalide

(* Fonction pour afficher une assignation *)
let afficher_assignation portee (var, expr) =
  let var_minuscule = String.lowercase_ascii var in
  let portee_maj =
    if variable_est_declaree portee var_minuscule then portee
    else (var_minuscule, "int") :: portee
  in
  (if not (variable_est_declaree portee var_minuscule) then
     match type_de_expression portee expr with
     | TypeEntier | TypeBooleen -> Printf.fprintf !oc "int "
     | TypeNeant -> Printf.fprintf !oc "void *"
     | TypeReel -> Printf.fprintf !oc "float ");
  Printf.fprintf !oc "%s = " var_minuscule;
  afficher_expression portee_maj expr;
  Printf.fprintf !oc ";\n";
  portee_maj

let normaliser_chaine s =
  String.fold_left
    (fun acc caractere_courrant ->
       match caractere_courrant with
       | '%' -> acc ^ "%%"
       | '\\' -> acc ^ "\\\\"
       | _ -> acc ^ String.make 1 caractere_courrant)
    "" s


(* Fonction pour afficher un appel à printf avec la valeur correcte *)
let afficher_printf portee e =
  match e with
  | Entier n -> Printf.fprintf !oc "printf(\"%%d\\n\", %s);" n
  | Reel r -> Printf.fprintf !oc "printf(\"%%f\\n\", %s);" (remplacer_caractere ',' '.' r)
  | Chaine_caractere s -> Printf.fprintf !oc "wprintf(L\"%s\\n\");" (normaliser_chaine s)
  | _ ->
    Printf.fprintf !oc "printf(\"%%d\\n\", ";
    afficher_expression portee e;
    Printf.fprintf !oc ");"

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
    Printf.fprintf !oc "%s++;\n" (String.lowercase_ascii var);
    portee
  | Increment (var, Some expr) ->
    Printf.fprintf !oc "%s += " (String.lowercase_ascii var);
    afficher_expression portee expr;
    Printf.fprintf !oc ";\n";
    portee
  | Decrement (var, None) ->
    Printf.fprintf !oc "%s--;\n" (String.lowercase_ascii var);
    portee
  | Decrement (var, Some expr) ->
    Printf.fprintf !oc "%s -= " (String.lowercase_ascii var);
    afficher_expression portee expr;
    Printf.fprintf !oc ";\n";
    portee
  | _ ->
    afficher_expression portee ast;
    portee

(* Fonction pour afficher une condition *)
and afficher_condition portee cond alors_list sinon_opt =
  Printf.fprintf !oc "if (";
  afficher_expression portee cond;
  Printf.fprintf !oc ") {\n";
  let portee_apres_alors = List.fold_left afficher_ast portee alors_list in
  Printf.fprintf !oc "}\n";
  match sinon_opt with
  | Some sinon_list ->
    Printf.fprintf !oc "else {\n";
    let portee_apres_sinon =
      List.fold_left afficher_ast portee_apres_alors sinon_list
    in
    Printf.fprintf !oc "}\n";
    portee_apres_sinon
  | None -> portee_apres_alors

(* Fonction pour afficher une boucle 'tant que' *)
and afficher_boucle portee cond paragraphe =
  Printf.fprintf !oc "while (";
  afficher_expression portee cond;
  Printf.fprintf !oc ") {\n";
  let portee_apres_boucle = List.fold_left afficher_ast portee paragraphe in
  Printf.fprintf !oc "}\n";
  portee_apres_boucle

(* Fonction pour afficher une boucle 'for' *)
and afficher_for portee var start_expr end_expr inclusive paragraphe =
  Printf.fprintf !oc "for (int %s = " (String.lowercase_ascii var);
  afficher_expression portee start_expr;
  Printf.fprintf !oc "; %s " (String.lowercase_ascii var);
  Printf.fprintf !oc (if inclusive then "<= " else "< ");
  afficher_expression portee end_expr;
  Printf.fprintf !oc "; %s++) {\n" (String.lowercase_ascii var);
  let portee_apres_for = (String.lowercase_ascii var, "int") :: portee in
  let _ = List.fold_left afficher_ast portee_apres_for paragraphe in
  Printf.fprintf !oc "}\n";
  portee_apres_for

let verifier_type attendu obtenu =
  if attendu <> obtenu then raise IncompatibiliteDeType



(* Fonction principale pour afficher le code C *)
let affiche a channel =
  oc := channel;
  Printf.fprintf !oc "#include <stdio.h>\n#include <wchar.h>\n#include <locale.h>\n";
  Printf.fprintf !oc "\nint main(){\nsetlocale(LC_ALL, \"\");\n";
  let _ = afficher_ast [] a in
  Printf.fprintf !oc "\nreturn 0;\n}"