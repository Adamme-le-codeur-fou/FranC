open Ecrire
open Ast
open Portee

exception PhraseInvalide
exception TokenInvalide

(* Fonction pour afficher une expression *)
let rec ecrire_expression portee expr =
  match expr with
  | Entier n -> ecrire "%s" n
  | Reel r -> ecrire "%s" (remplacer_caractere ',' '.' r)
  | Mot m ->
        let m_minuscule = String.lowercase_ascii m in
          ecrire "%s" (if variable_est_declaree portee m_minuscule then m_minuscule else raise TokenInvalide)
  | Appel_recette (fonction_nom, arguments) ->
        ecrire "%s(" fonction_nom;
        ecrire_arguments arguments;
        ecrire ")"
  | Plus              (e1, e2) -> ecrire_operateur_binaire portee e1 e2 "+"
  | Moins             (e1, e2) -> ecrire_operateur_binaire portee e1 e2 "-"
  | Fois              (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "*"
  | Egal              (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "=="
  | Different         (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "!="
  | Inferieur         (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "<"
  | Inferieur_ou_egal (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "<="
  | Superieur         (p1, p2) -> ecrire_operateur_binaire portee p1 p2 ">"
  | Superieur_ou_egal (p1, p2) -> ecrire_operateur_binaire portee p1 p2 ">="
  | Modulo            (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "%%"
  | Et                (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "&&"
  | Ou                (p1, p2) -> ecrire_operateur_binaire portee p1 p2 "||"
  | _ -> raise PhraseInvalide

and ecrire_operateur_binaire portee expr_a exbr_b operateur =
  ecrire "(";
  ecrire_expression portee expr_a;
  ecrire " %s " operateur;
  ecrire_expression portee exbr_b;
  ecrire ")"