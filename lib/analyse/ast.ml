exception PhraseInvalide

type type_expression = TypeEntier | TypeReel | TypeBooleen | TypeChaineCaractere | TypeNeant | TypeTableauEntier | TypeTableauReel

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
  | Division           of ast * ast
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
  | Appel_recette      of string * ast list
  | Renvoyer           of ast
  | Tableau            of ast list
  | AccesTableau       of string * ast
  | ModificationTableau of string * ast * ast
  | TailleTableau      of string
  | AjouterTableau     of string * ast
  | Lire               of string