{
    open Parser
    open Erreurs

    let analyser_chaine str =
      if not (String.contains str '[') then
        Chaine_caractere(str)
      else
        let len = String.length str in
        let rec aux i texte_courant textes vars =
          if i >= len then
            (List.rev (texte_courant :: textes), List.rev vars)
          else if str.[i] = '[' then
            let j = String.index_from str (i + 1) ']' in
            let var = String.sub str (i + 1) (j - i - 1) in
            aux (j + 1) "" (texte_courant :: textes) (var :: vars)
          else
            aux (i + 1) (texte_courant ^ String.make 1 str.[i]) textes vars
        in
        let (textes, vars) = aux 0 "" [] [] in
        Chaine_formatee(textes, vars)
}

let chiffre = ['0'-'9']
let nombre = chiffre+
let alphabet_min =  ['a'-'z']
let alphabet_maj = ['A'-'Z']
let alphabet = alphabet_min | alphabet_maj
let lettre_speciales_min = ['\x82''\x8A''\x87''\x85''\x97'] (* é, è, ç, à, ù' *) 
let lettre_speciales_maj = ['\x90''\xD4''\x80''\xB7''\xEB'] (* É, È, Ç, À, Ù *) 
let ponctuation_fin_phrase = ['.''?''!'','';']
let mot = alphabet_min+ ('''+ alphabet+)*
let mot_maj = alphabet_maj mot?

rule decoupe =
    parse
    | '\n' { Lexing.new_line lexbuf; decoupe lexbuf }
    | [' ''\t']+ { decoupe lexbuf }
    | ":" { Deux_points }
    | "-" { Tiret }
    | "," { Virgule }
    | nombre ',' nombre as d { Reel d }
    | "plus" { Plus }
    | "moins" { Moins }
    | "et si" { Et_Si }
    | "ou si" { Ou_Si }
    | "et" { Et }
    | "avec" { Avec }
    | "fois" | "multiplié par" { Fois }
    | "divisé par" | "divise par" { Division }
    | "le reste de la division euclidienne de" | "modulo" { Reste_division_euclidienne_debut }
    | "par" { Par }
    | "prend la valeur" | "devient" { Assigne }
    | "vaut" | "égal" | "est égal à" { Egal }
    | "est différent de" | "n'est pas égal à" { Different }
    | "est inferieur à" | "plus petit que" { Inferieur }
    | "est inférieur ou égal à" | "plus petit ou égal à" { Inferieur_ou_egal }
    | "est supérieur à" | "plus grand que" { Superieur }
    | "est supérieur ou égal à" | "plus grand ou égal à" { Superieur_ou_egal }
    | ['a''A']"fficher" { Afficher }
    | '(' { Parenthese_Gauche }
    | ')' { Parenthese_Droite }
    | ['s''S']"i" { Si }
    | "alors" { Alors }
    | ['s''S']"inon" { Sinon }
    | "Tant que" { Tant_que }
    | "Ce qui conclut la boucle" | "Ce qui termine la boucle" { Fin_boucle }
    | "Ce qui correspond à la fin de notre condition" | "Fin de la condition" { Fin_condition }
    | ['e''E']"n itérant sur" { Iterer }
    | "allant de" { Allant_de }
    | "à" { A }
    | "compris" { Compris }
    | "non compris" { Non_compris }
    | "on agit selon la séquence suivante :" { Agir }
    | "Ce qui termine la séquence" { Termine_sequence }
    | ['o''O']"n incrémente" { Incrementer }
    | ['o''O']"n décrémente" { Decrementer }
    | "de" { De }
    | "un tableau contenant" { Tableau_contenant }
    | ['l''L']"'élément" | ['l''L']"'element" { Element }
    | "la taille de" { Taille_de }
    | "Ajouter" { Ajouter }
    | "Modifier" { Modifier }
    | "Lire" { Lire }
    | "Permuter" { Permuter }
    | "On définit une recette nommée" { Definir_recette }
    | "dont les ingrédients sont :" { Ingredients_recette }
    | "et qui renvoie" { Type_retour_Recette }
    | "Fin de la recette" { Fin_recette }
    | ['r''R']"envoyer" { Renvoyer }
    | "le résultat de" | "le résultat de la recette" { Resultat_de_recette }
    | "avec les ingrédients" { Avec_les_ingredients }
    | "un entier" { Type_entier }
    | "un réel" { Type_reel }
    | "une chaîne de caractères" { Type_chaine_caractere }
    | '<' ([^'>']* as str) '>' { analyser_chaine str }
    | nombre as d { Entier d }
    | mot as mot { Mot mot }
    | mot_maj as mot_maj { Mot_majuscule mot_maj } 
    | ponctuation_fin_phrase as c { Ponctuation_fin_phrase c }
    | "Nota bene : " | "N. B. : " { commentaire lexbuf }
    | eof { EOF }
    | _ as c {
        let pos = Lexing.lexeme_start_p lexbuf in
        raise (Erreur_lexer (formater_erreur (formater_position pos)
          (Printf.sprintf "caractère inconnu '%c'" c)))
      }

and commentaire =
    parse
    | "\n" { Lexing.new_line lexbuf; decoupe lexbuf }
    | _ { commentaire lexbuf }
