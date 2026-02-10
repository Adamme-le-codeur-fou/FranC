exception Erreur_lexer of string
exception Erreur_type of string


let variable_non_declaree nom =
  Erreur_type
    (Printf.sprintf "La variable '%s' n'a pas été déclarée. Vérifiez qu'elle a bien été initialisée (exemple : %s devient ...)."
      nom (String.capitalize_ascii nom))

let fonction_non_declaree nom =
  Erreur_type
    (Printf.sprintf "La fonction '%s' n'a pas été déclarée. Vérifiez que vous avez bien défini la fonction avant de l'appeler."
      nom)

let pas_un_tableau nom_variable =
  Erreur_type
    (Printf.sprintf "La variable '%s' n'est pas un tableau. Vérifiez que vous avez bien déclaré la variable comme un tableau."
      nom_variable)

let assignation_incompatible nom_variable type_variable type_expression =
  Erreur_type
    (Printf.sprintf "Assignation incompatible : la variable '%s' est de type [%s] et ne peut pas recevoir une valeur de type [%s]."
      nom_variable type_variable type_expression)

let variable_lue_incompatible type_variable =
  Erreur_type
    (Printf.sprintf "Lecture impossible : les valeurs de type [%s] ne peuvent pas être lues."
      type_variable)
  
let expression_non_supportee =
  Erreur_type
    "Expression non supportée dans ce contexte. Vérifiez que vous utilisez les bonnes expressions au bon endroit."

let formater_position (pos : Lexing.position) =
  let ligne = pos.pos_lnum in
  let colonne = pos.pos_cnum - pos.pos_bol + 1 in
  Printf.sprintf "ligne %d, colonne %d" ligne colonne

let formater_erreur position message =
  Printf.sprintf "Erreur %s : %s" position message
