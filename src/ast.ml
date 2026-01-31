open Types

exception PhraseInvalide
exception TokenInvalide
exception IncompatibiliteDeType
exception VariableNonDeclaree

type ast =
  | Mot of string
  | Entier of string
  | Reel of string
  | Chaine_caractere of string
  | Phrase of ast list * string
  | Plus of ast * ast
  | Moins of ast * ast
  | Et of ast * ast
  | Ou of ast * ast
  | Egal of ast * ast
  | Inferieur of ast * ast
  | Inferieur_ou_egal of ast * ast
  | Superieur of ast * ast
  | Superieur_ou_egal of ast * ast
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
  | Permuter of string * string
  | Recette of string * (string * type_expression) list * type_expression * ast list
  | Appel_recette of string * string list
  | Renvoyer of ast


let canal_sortie = ref stdout
let ecrire chaine_format =
  Printf.fprintf !canal_sortie chaine_format

  (* détermine le type d'une expression *)
let rec type_de_expression portee expr =
  match expr with
  | Entier _ -> TypeEntier
  | Reel _ -> TypeReel
  | Plus (expr_gauche, expr_droite) | Fois (expr_gauche, expr_droite) | Moins (expr_gauche, expr_droite) ->
    if
      type_de_expression portee expr_gauche = TypeReel
      || type_de_expression portee expr_droite = TypeReel
    then TypeReel
    else TypeEntier
  | Egal _ | Different _ | Et _ | Ou _ | Inferieur _ | Inferieur_ou_egal _ | Superieur _ | Superieur_ou_egal _ -> TypeBooleen
  | Modulo _ -> TypeEntier
  | Mot m ->
    let m_minuscule = String.lowercase_ascii m in List.assoc m_minuscule portee
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
    ecrire "mot(%s)%s" m (if q = [] then "" else ", ");
    print_mot_liste q
  | _ -> raise PhraseInvalide


type portee = (string * type_expression) list

let variable_est_declaree portee var_name =
  List.exists (fun (name, _) -> name = var_name) portee

let rec afficher_arguments arguments_list =
    match arguments_list with
    | [] -> ()
    | argument_nom::q ->
        ecrire "%s%s" argument_nom (if q = [] then "" else ", ");
        afficher_arguments q

(* Fonction pour afficher une expression *)
let rec afficher_expression portee expr =
  match expr with
  | Entier n -> ecrire "%s" n
  | Reel r -> ecrire "%s" (remplacer_caractere ',' '.' r)
  | Mot m ->
    let m_minuscule = String.lowercase_ascii m in
    ecrire "%s"
      (if variable_est_declaree portee m_minuscule then m_minuscule
       else raise TokenInvalide)
  | Plus (e1, e2) ->
    ecrire "(";
    afficher_expression portee e1;
    ecrire " + ";
    afficher_expression portee e2;
    ecrire ")"
  | Moins (e1, e2) ->
    ecrire "(";
    afficher_expression portee e1;
    ecrire " - ";
    afficher_expression portee e2;
    ecrire ")"
  | Fois (p1, p2) ->
    ecrire "(";
    afficher_expression portee p1;
    ecrire " * ";
    afficher_expression portee p2;
    ecrire ")"
  | Egal (p1, p2) ->
    ecrire "(";
    afficher_expression portee p1;
    ecrire " == ";
    afficher_expression portee p2;
    ecrire ")"
  | Different (p1, p2) ->
    ecrire "(";
    afficher_expression portee p1;
    ecrire " != ";
    afficher_expression portee p2;
    ecrire ")"
  | Inferieur (p1, p2) ->
    ecrire "(";
    afficher_expression portee p1;
    ecrire " < ";
    afficher_expression portee p2;
    ecrire ")"
  | Inferieur_ou_egal (p1, p2) ->
    ecrire "(";
    afficher_expression portee p1;
    ecrire " <= ";
    afficher_expression portee p2;
    ecrire ")"
  | Superieur (p1, p2) ->
    ecrire "(";
    afficher_expression portee p1;
    ecrire " > ";
    afficher_expression portee p2;
    ecrire ")"
  | Superieur_ou_egal (p1, p2) ->
    ecrire "(";
    afficher_expression portee p1;
    ecrire " >= ";
    afficher_expression portee p2;
    ecrire ")"
  | Modulo (p1, p2) ->
    ecrire "(";
    afficher_expression portee p1;
    ecrire " %% ";
    afficher_expression portee p2;
    ecrire ")"
  | Et (p1, p2) ->
    ecrire "(";
    afficher_expression portee p1;
    ecrire " && ";
    afficher_expression portee p2;
    ecrire ")"
  | Ou (p1, p2) ->
    ecrire "(";
    afficher_expression portee p1;
    ecrire " || ";
    afficher_expression portee p2;
    ecrire ")"
  | Appel_recette (fonction_nom, arguments) ->
    ecrire "%s(" fonction_nom;
    afficher_arguments arguments;
    ecrire ")"
  | _ -> raise PhraseInvalide



(* Fonction pour afficher une assignation *)
let afficher_assignation portee (var, expr) =
  let var_minuscule = String.lowercase_ascii var in
  let portee_maj =
    if variable_est_declaree portee var_minuscule then portee
    else (var_minuscule, TypeEntier) :: portee
  in
  (if not (variable_est_declaree portee var_minuscule) then
    ecrire  "%s" (type_vers_chaine_caractere (type_de_expression portee expr)));
  ecrire "%s = " var_minuscule;
  afficher_expression portee_maj expr;
  ecrire ";\n";
  portee_maj

let normaliser_chaine s =
  String.fold_left
    (fun acc caractere_courrant ->
       match caractere_courrant with
       | '%' -> acc ^ "%%"
       | '\\' -> acc ^ "\\\\"
       | _ -> acc ^ String.make 1 caractere_courrant)
    "" s

let temporaire_id = ref 0
let temporaire_suivant () = 
  let id = !temporaire_id in
  temporaire_id := !temporaire_id + 1;
  Printf.sprintf "_variable_temporaire_%d" id

(* Fonction pour afficher un appel à printf avec la valeur correcte *)
let afficher_printf portee e =
  match e with
  | Entier n -> ecrire "wprintf(L\"%%d\\n\", %s);\n" n
  | Reel r -> ecrire "wprintf(L\"%%f\\n\", %s);\n" (remplacer_caractere ',' '.' r)
  | Chaine_caractere s -> ecrire "wprintf(L\"%s\\n\");\n" (normaliser_chaine s)
  | _ ->
    ecrire "wprintf(L\"%%d\\n\", ";
    afficher_expression portee e;
    ecrire ");\n"

let rec afficher_variable_avec_type arguments_list =
    match arguments_list with
    | [] -> ()
    | (argument_nom, argument_type)::q ->
        ecrire "%s %s%s" (type_vers_chaine_caractere argument_type) argument_nom (if q = [] then "" else ", ");
        afficher_variable_avec_type q


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
    ecrire "%s++;\n" (String.lowercase_ascii var);
    portee
  | Increment (var, Some expr) ->
    ecrire "%s += " (String.lowercase_ascii var);
    afficher_expression portee expr;
    ecrire ";\n";
    portee
  | Decrement (var, None) ->
    ecrire "%s--;\n" (String.lowercase_ascii var);
    portee
  | Decrement (var, Some expr) ->
    ecrire "%s -= " (String.lowercase_ascii var);
    afficher_expression portee expr;
    ecrire ";\n";
    portee
  | Permuter (var1, var2) ->
    let v1 = String.lowercase_ascii var1 in
    let v2 = String.lowercase_ascii var2 in
    let variable_temporaire = temporaire_suivant () in
    ecrire "%s %s = %s;\n" (type_vers_chaine_caractere (type_variable portee v1)) variable_temporaire v1;
    ecrire "%s = %s;\n" v1 v2;
    ecrire "%s = %s;\n" v2 variable_temporaire;
    portee
  | Renvoyer a -> 
    ecrire "return ";
    let _ = afficher_ast portee a in
    ecrire ";\n";
    portee
  | Recette(_) -> portee
  | _ ->
    afficher_expression portee ast;
    portee

(* Fonction pour afficher une condition *)
and afficher_condition portee cond alors_list sinon_opt =
  ecrire "if (";
  afficher_expression portee cond;
  ecrire ") {\n";
  let portee_apres_alors = List.fold_left afficher_ast portee alors_list in
  ecrire "}\n";
  match sinon_opt with
  | Some sinon_list ->
    ecrire "else {\n";
    let portee_apres_sinon =
      List.fold_left afficher_ast portee_apres_alors sinon_list
    in
    ecrire "}\n";
    portee_apres_sinon
  | None -> portee_apres_alors

(* Fonction pour afficher une boucle 'tant que' *)
and afficher_boucle portee cond paragraphe =
  ecrire "while (";
  afficher_expression portee cond;
  ecrire ") {\n";
  let portee_apres_boucle = List.fold_left afficher_ast portee paragraphe in
  ecrire "}\n";
  portee_apres_boucle

(* Fonction pour afficher une boucle 'for' *)
and afficher_for portee var start_expr end_expr inclusive paragraphe =
  ecrire "for (int %s = " (String.lowercase_ascii var);
  afficher_expression portee start_expr;
  ecrire "; %s " (String.lowercase_ascii var);
  ecrire (if inclusive then "<= " else "< ");
  afficher_expression portee end_expr;
  ecrire "; %s++) {\n" (String.lowercase_ascii var);
  let portee_apres_for = (String.lowercase_ascii var, TypeEntier) :: portee in
  let _ = List.fold_left afficher_ast portee_apres_for paragraphe in
  ecrire "}\n";
  portee_apres_for

let afficher_function nom arguments type_function corps =
  ecrire "\n%s" (type_vers_chaine_caractere type_function);
  ecrire "%s(" nom;
  afficher_variable_avec_type arguments;
  ecrire ") {\n";
  let _ = List.fold_left afficher_ast arguments corps in
  ecrire "}\n"

let rec afficher_fonctions_pre_main ast =
  match ast with
  | Recette(nom, arguments, type_function, corps) -> afficher_function nom arguments type_function corps
  | Paragraphe l -> List.iter afficher_fonctions_pre_main l
  | _ -> ()


(* Fonction principale pour afficher le code C *)
let affiche a channel =
  canal_sortie := channel;
  ecrire "#include <stdio.h>\n#include <wchar.h>\n#include <locale.h>\n";
  afficher_fonctions_pre_main a;
  ecrire "\nint main(){\nsetlocale(LC_ALL, \"\");\n";
  let _ = afficher_ast [] a in
  ecrire "return 0;\n}"