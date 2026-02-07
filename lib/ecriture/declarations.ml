open String_outils
open Ast
open Ecrire
open Expressions
open Portee
open Types


let nom_fonction_nouveau_tableau type_tab =
  match type_tab with
  | TypeTableauReel -> "nouveau_tableau_reel"
  | _ -> "nouveau_tableau_entier"

let nom_fonction_ajouter_element type_tab =
  match type_tab with
  | TypeTableauReel -> "ajouter_element_reel"
  | _ -> "ajouter_element_entier"

(* Fonction pour afficher une assignation *)
let ecrire_assignation portee (var, expr) =
  let var_minuscule = String.lowercase_ascii var in
  let type_expr = type_de_expression portee expr in
  let portee_maj =
    if variable_est_declaree portee var_minuscule then begin
      let type_existant = type_variable portee var_minuscule in
      if type_existant <> type_expr then
        raise (Erreurs.Erreur_type
          (Printf.sprintf "la variable '%s' est de type %s et ne peut pas recevoir une valeur de type %s"
            var_minuscule (nom_type type_existant) (nom_type type_expr)));
      portee
    end
    else (var_minuscule, type_expr) :: portee
  in
  (match expr with
  | Tableau elements ->
    let nb = List.length elements in
    if not (variable_est_declaree portee var_minuscule) then
      ecrire "%s" (type_de_variable_vers_string portee_maj var_minuscule);
    ecrire "%s = %s(%d);\n" var_minuscule (nom_fonction_nouveau_tableau type_expr) nb;
    List.iter (fun elem ->
      ecrire "%s(" (nom_fonction_ajouter_element type_expr);
      ecrire "%s, " var_minuscule;
      ecrire_expression portee_maj elem;
      ecrire ");\n"
    ) elements
  | _ ->
    if not (variable_est_declaree portee var_minuscule) then
      ecrire "%s" (type_de_variable_vers_string portee_maj var_minuscule);
    ecrire "%s = " var_minuscule;
    ecrire_expression portee_maj expr;
    ecrire ";\n");
  portee_maj


let format_printf_pour_type t =
  match t with
  | TypeReel -> "%f"
  | TypeChaineCaractere -> "%ls"
  | _ -> "%d"

let ecrire_printf portee e =
  (match e with
  | Entier n -> ecrire "wprintf(L\"%%d\\n\", %s);\n" n
  | Reel r -> ecrire "wprintf(L\"%%f\\n\", %s);\n" (remplacer_caractere ',' '.' r)
  | Chaine_caractere s -> ecrire "wprintf(L\"%s\\n\");\n" (normaliser_chaine s)
  | ChaineFormatee (textes, vars) ->
    ecrire "wprintf(L\"";
    List.iteri (fun i texte ->
      ecrire "%s" (normaliser_chaine texte);
      if i < List.length vars then begin
        let var = List.nth vars i in
        let var_min = String.lowercase_ascii var in
        let t = type_variable portee var_min in
        ecrire "%s" (format_printf_pour_type t)
      end
    ) textes;
    ecrire "\\n\"";
    List.iter (fun var ->
      let var_min = String.lowercase_ascii var in
      ecrire ", %s" var_min
    ) vars;
    ecrire ");\n"
  | _ ->
    let format = format_printf_pour_type (type_de_expression portee e) in
    ecrire "wprintf(L\"%s\\n\", " format;
    ecrire_expression portee e;
    ecrire ");\n");
  portee

let rec ecrire_variable_avec_type arguments_list =
    match arguments_list with
    | [] -> ()
    | (argument_nom, argument_type)::q ->
        ecrire "%s %s%s" (type_vers_string argument_type) argument_nom (if q = [] then "" else ", ");
        ecrire_variable_avec_type q

let ecrire_xcrementer portee var expression signe =
  let var_min = String.lowercase_ascii var in
  let _ = type_variable portee var_min in
  (match expression with
  | None -> ecrire "%s%s;\n" var_min (signe^signe)
  | Some expr ->
    ecrire "%s %s= " var_min signe;
    ecrire_expression portee expr;
    ecrire ";\n");
  portee

let ecrire_incrementer portee var expression = ecrire_xcrementer portee var expression "+"

let ecrire_decrementer portee var expression = ecrire_xcrementer portee var expression "-"

let ecrire_permuter portee variable1 variable2 =
    let v1_minuscule = String.lowercase_ascii variable1 in
    let v2_minuscule = String.lowercase_ascii variable2 in
    let variable_temporaire = "variable_temporaire" in
    ecrire "{%s %s = %s;\n" (type_de_variable_vers_string portee v1_minuscule) variable_temporaire v1_minuscule;
    ecrire "%s = %s;\n" v1_minuscule v2_minuscule;
    ecrire "%s = %s;}\n" v2_minuscule variable_temporaire;
    portee

let ecrire_modification_tableau portee nom index valeur =
  let nom_minuscule = String.lowercase_ascii nom in
  let _ = type_variable portee nom_minuscule in
  ecrire "%s->donnees[" nom_minuscule;
  ecrire_expression portee index;
  ecrire "] = ";
  ecrire_expression portee valeur;
  ecrire ";\n";
  portee

let ecrire_ajouter_tableau portee nom valeur =
  let nom_minuscule = String.lowercase_ascii nom in
  let type_tab = type_variable portee nom_minuscule in
  ecrire "%s(%s, " (nom_fonction_ajouter_element type_tab) nom_minuscule;
  ecrire_expression portee valeur;
  ecrire ");\n";
  portee

let ecrire_renvoyer portee expression =
  ecrire "return ";
  let _ = ecrire_expression portee expression in
  ecrire ";\n";
  portee

let ecrire_lire portee var =
  let var_min = String.lowercase_ascii var in
  let type_var = type_variable portee var_min in
  (match type_var with
  | TypeEntier -> ecrire "wscanf(L\"%%d\", &%s);\n" var_min
  | TypeReel -> ecrire "wscanf(L\"%%f\", &%s);\n" var_min
  | _ -> raise (Erreurs.Erreur_type
      (Printf.sprintf "impossible de lire une valeur de type %s (seuls les types entier et réel sont supportés)" (nom_type type_var))));
  portee

let ecrire_liberation_tableaux portee_base portee =
  List.iter (fun (nom, t) ->
    if not (variable_est_declaree portee_base nom) then
      match t with
      | TypeTableauEntier -> ecrire "liberer_tableau_entier(%s);\n" nom
      | TypeTableauReel -> ecrire "liberer_tableau_reel(%s);\n" nom
      | _ -> ()
  ) portee