open Ecrire

exception PhraseInvalide
exception TokenInvalide
exception IncompatibiliteDeType
exception VariableNonDeclaree

type type_expression = TypeEntier | TypeReel | TypeBooleen | TypeChaineCaractere | TypeNeant

type ast =
  | Mot                of string
  | Entier             of string
  | Reel               of string
  | Chaine_caractere   of string
  | Phrase             of ast list * string
  | Plus               of ast * ast
  | Moins              of ast * ast
  | Et                 of ast * ast
  | Ou                 of ast * ast
  | Egal               of ast * ast
  | Inferieur          of ast * ast
  | Inferieur_ou_egal  of ast * ast
  | Superieur          of ast * ast
  | Superieur_ou_egal  of ast * ast
  | Fois               of ast * ast
  | Modulo             of ast * ast
  | Assigne            of ast * ast
  | Afficher           of ast
  | Paragraphe         of ast list
  | Condition          of ast * ast list * ast list option
  | Expression         of ast
  | BoucleTantQue      of ast * ast list
  | Different          of ast * ast
  | ForInclus          of string * ast * ast * ast list
  | ForExclus          of string * ast * ast * ast list
  | Increment          of string * ast option
  | Decrement          of string * ast option
  | Permuter           of string * string
  | Recette            of string * (string * type_expression) list * type_expression * ast list
  | Appel_recette      of string * string list
  | Renvoyer           of ast


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



let rec afficher_arguments arguments_list =
    match arguments_list with
    | [] -> ()
    | argument_nom::q ->
        ecrire "%s%s" argument_nom (if q = [] then "" else ", ");
        afficher_arguments q


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




