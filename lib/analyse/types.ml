open Ast

exception IncompatibiliteDeType
exception VariableNonDeclaree of string

let type_vers_string t =
  match t with
     | TypeEntier | TypeBooleen -> "int "
     | TypeNeant -> "void *"
     | TypeReel -> "float "
     | TypeChaineCaractere -> "wchar_t *"

let rec type_variable portee nom_variable =
  match portee with
  | [] -> raise (VariableNonDeclaree nom_variable)
  | (nom, variable_type) :: queue ->
    if nom = nom_variable then variable_type
    else type_variable queue nom_variable


let type_de_variable_vers_string portee var_name =
  type_vers_string (type_variable portee var_name)


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



let verifier_type attendu obtenu =
  if attendu <> obtenu then raise IncompatibiliteDeType