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
  | Compris
  | Non_compris
  | Termine_sequence
  | Agir
  | Incrementer
  | De
  | Decrementer
  | Commence
  | Dedans
  | Attend
  | Proceder
  | Termine_fonction
  | Virgule
  | EOF
  | Tabulation
  | Mot of string
  | Mot_majuscule of string
  | Ponctuation_fin_phrase of string
  | Entier of string
  | Reel of string

val main : (Lexing.lexbuf -> token) -> Lexing.lexbuf -> Ast.ast
