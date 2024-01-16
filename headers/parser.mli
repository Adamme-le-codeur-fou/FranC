type token =
  | Assigne
  | Afficher
  | Plus
  | Egal
  | Fois
  | Different
  | Parenthese_Gauche
  | Parenthese_Droite
  | Si
  | Alors
  | Sinon
  | Fin_condition
  | Tant_que
  | Fin_boucle
  | Reste_division_euclidienne_debut
  | Par
  | Iterer
  | Sur
  | Allant_de
  | A
  | Compri
  | Non_compri
  | Termine_sequence
  | Agir
  | EOF
  | Tabulation
  | Mot of string
  | Mot_majuscule of string
  | Ponctuation_fin_phrase of string
  | Entier of string
  | Reel of string

val main : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Ast.ast
