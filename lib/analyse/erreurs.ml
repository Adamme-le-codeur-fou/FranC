exception Erreur_lexer of string
exception Erreur_type of string

let erreur_non_declare nom =
  Erreur_type (Printf.sprintf "la variable '%s' n'est pas déclarée dans cette portée" nom)

let formater_position (pos : Lexing.position) =
  let ligne = pos.pos_lnum in
  let colonne = pos.pos_cnum - pos.pos_bol + 1 in
  Printf.sprintf "ligne %d, colonne %d" ligne colonne

let formater_erreur position message =
  Printf.sprintf "Erreur %s : %s" position message
