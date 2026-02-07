open Ast

exception VariableNonDeclaree of string

let type_vers_string t =
  match t with
     | TypeEntier | TypeBooleen -> "int "
     | TypeNeant -> "void *"
     | TypeReel -> "float "
     | TypeChaineCaractere -> "wchar_t *"
     | TypeTableauEntier -> "TableauEntier *"
     | TypeTableauReel -> "TableauReel *"

let nom_type t =
  match t with
     | TypeEntier -> "entier"
     | TypeBooleen -> "booléen"
     | TypeNeant -> "néant"
     | TypeReel -> "réel"
     | TypeChaineCaractere -> "chaîne de caractères"
     | TypeTableauEntier -> "tableau d'entiers"
     | TypeTableauReel -> "tableau de réels"

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
  | Chaine_caractere _ -> TypeChaineCaractere
  | Plus (expr_gauche, expr_droite) | Fois (expr_gauche, expr_droite) | Moins (expr_gauche, expr_droite) | Division (expr_gauche, expr_droite) ->
    if type_de_expression portee expr_gauche = TypeReel || type_de_expression portee expr_droite = TypeReel
      then TypeReel else TypeEntier
  | Egal _ | Different _ | Et _ | Ou _ | Inferieur _ | Inferieur_ou_egal _ | Superieur _ | Superieur_ou_egal _ -> TypeBooleen
  | Modulo _ -> TypeEntier
  | Mot m -> type_variable portee (String.lowercase_ascii m)
  | Tableau elements ->
    if List.exists (fun e -> type_de_expression portee e = TypeReel) elements
    then TypeTableauReel else TypeTableauEntier
  | AccesTableau (nom, _) ->
    let t = type_variable portee (String.lowercase_ascii nom) in
    (match t with TypeTableauReel -> TypeReel | _ -> TypeEntier)
  | TailleTableau _ -> TypeEntier
  | Appel_recette (nom, _) -> type_variable portee nom
  | Negatif e -> type_de_expression portee e
  | Vrai | Faux -> TypeBooleen
  | _ -> TypeNeant

