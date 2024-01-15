exception PhraseInvalide
exception TokenInvalide
exception TypeMismatch

type ast =
  | Mot of string
  | Nombre of string
  | Phrase of ast list * string
  | Plus of ast * ast
  | Egal of ast * ast
  | Fois of ast * ast
  | Modulo of ast * ast
  | Assigne of ast * ast
  | Afficher of ast
  | Paragraphe of ast list
  | Condition of ast * ast list * ast list option
  | Expression of ast
  | BoucleTantQue of ast * ast list
  | Different of ast * ast

val affiche : ast -> unit
