open String_outils
open Ast
open Ecrire
open Portee

let rec ecrire_expression_list portee arguments_list =
    match arguments_list with
    | [] -> ()
    | argument::q ->
        ecrire_expression portee argument;
        if q <> [] then ecrire ", ";
        ecrire_expression_list portee q

and ecrire_expression portee expr =
  match expr with
  | Entier n -> ecrire "%s" n
  | Reel r -> ecrire "%s" (remplacer_caractere ',' '.' r)
  | Chaine_caractere s -> ecrire "L\"%s\"" (normaliser_chaine s)
  | Mot m ->
        let m_minuscule = String.lowercase_ascii m in
          if variable_est_declaree portee m_minuscule then ecrire "%s" m_minuscule
          else raise (Erreurs.erreur_non_declare m_minuscule)
  | Appel_recette (fonction_nom, arguments) ->
        ecrire "%s(" fonction_nom;
        ecrire_expression_list portee arguments;
        ecrire ")"
  | Plus              (e1, e2) -> ecrire_operateur_binaire portee e1 e2 "+"
  | Moins             (e1, e2) -> ecrire_operateur_binaire portee e1 e2 "-"
  | Fois              (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "*"
  | Division          (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "/"
  | Egal              (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "=="
  | Different         (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "!="
  | Inferieur         (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "<"
  | Inferieur_ou_egal (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "<="
  | Superieur         (p1, p2) -> ecrire_operateur_binaire portee p1 p2 ">"
  | Superieur_ou_egal (p1, p2) -> ecrire_operateur_binaire portee p1 p2 ">="
  | Modulo            (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "%"
  | Et                (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "&&"
  | Ou                (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "||"
  | AccesTableau (nom, index) ->
    let nom_min = String.lowercase_ascii nom in
    if not (variable_est_declaree portee nom_min) then
      raise (Erreurs.erreur_non_declare nom_min);
    let type_tab = Types.type_variable portee nom_min in
    let type_elem = Types.type_element_tableau type_tab in
    ecrire "((%s*)%s->donnees)[" (Types.type_c type_elem) nom_min;
    ecrire_expression portee index;
    ecrire "]"
  | TailleTableau nom ->
    let nom_min = String.lowercase_ascii nom in
    if not (variable_est_declaree portee nom_min) then
      raise (Erreurs.erreur_non_declare nom_min);
    ecrire "%s->taille" nom_min
  | Negatif e ->
    ecrire "(-";
    ecrire_expression portee e;
    ecrire ")"
  | Vrai -> ecrire "1"
  | Faux -> ecrire "0"
  | RacineCarre e ->
    ecrire "sqrt(";
    ecrire_expression portee e;
    ecrire ")"
  | Puissance (a, b) ->
    ecrire "pow(";
    ecrire_expression portee a;
    ecrire ", ";
    ecrire_expression portee b;
    ecrire ")"
  | ValeurAbsolue e ->
    let t = Types.type_de_expression portee e in
    ecrire "%s(" (if t = TypeReel then "fabs" else "abs");
    ecrire_expression portee e;
    ecrire ")"
  | Aleatoire (a, b) ->
    ecrire "%s" "((rand() % (";
    ecrire_expression portee b;
    ecrire " - ";
    ecrire_expression portee a;
    ecrire " + 1)) + ";
    ecrire_expression portee a;
    ecrire ")"
  | _ -> raise (Erreurs.Erreur_type "expression non supportée dans ce contexte")

and ecrire_operateur_binaire portee expr_a exbr_b operateur =
  ecrire "(";
  ecrire_expression portee expr_a;
  ecrire " %s " operateur;
  ecrire_expression portee exbr_b;
  ecrire ")"

  