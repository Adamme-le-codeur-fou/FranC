exception PhraseInvalide
exception TokenInvalide

type ast = 
    | Mot of string
    | Nombre of string
    | Phrase of ast list * string
    | Plus of ast * ast
    | Egal of ast * ast
    | Fois of ast * ast
    | Assigne of ast * ast
    | Paragraphe of ast list

val affiche : ast -> unit

