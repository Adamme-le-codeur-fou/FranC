open Ast

exception PhraseInvalide
exception TokenInvalide
exception IncompatibiliteDeType
exception VariableNonDeclaree



(* recherche une variable dans la portée et retourne son type *)
let rec type_variable portee var_name =
  match portee with
  | [] -> raise VariableNonDeclaree
  | (name, var_type) :: q ->
    if name = var_name then var_type
    else type_variable q var_name

(* convertit un type en chaîne de caractères *)
let type_vers_chaine_caractere t =
  match t with
     | TypeEntier | TypeBooleen -> "int "
     | TypeNeant -> "void *"
     | TypeReel -> "float "
     | TypeChaineCaractere -> "wchar_t *"

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


(* vérifie la compatibilité de deux types *)
let verifier_type attendu obtenu =
  if attendu <> obtenu then raise IncompatibiliteDeType