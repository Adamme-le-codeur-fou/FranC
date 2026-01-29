exception PhraseInvalide
exception TokenInvalide
exception IncompatibiliteDeType
exception VariableNonDeclaree

type type_expression = TypeEntier | TypeReel | TypeBooleen | TypeChaineCaractere | TypeNeant

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


(* vérifie la compatibilité de deux types *)
let verifier_type attendu obtenu =
  if attendu <> obtenu then raise IncompatibiliteDeType