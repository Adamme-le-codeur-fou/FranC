{
    open Parser
}

let chiffre = ['0'-'9']
let nombre = chiffre+
let alphabet_min =  ['a'-'z']
let alphabet_maj = ['A'-'Z']
let lettre_speciales_min = ['\x82''\x8A''\x87''\x85''\x97'] (* é, è, ç, à, ù' *) 
let lettre_speciales_maj = ['\x90''\xD4''\x80''\xB7''\xEB'] (* É, È, Ç, À, Ù *) 
let ponctuation_fin_phrase = ['.''?''!'','';']
let mot = alphabet_min+

rule decoupe =
    parse
    | [' ''\n''\t']+ { decoupe lexbuf }
    | nombre ',' nombre as d { Reel d }
    | "plus" { Plus }
    | "moins" { Moins }
    | "et" { Et }
    | "ou" { Ou }
    | "fois" | "multiplié par" { Fois }
    | "le reste de la division euclidienne de" { Reste_division_euclidienne_debut }
    | "par" { Par }
    | "prend la valeur" | "devient" { Assigne }
    | "vaut" | "égal" | "est égal à" { Egal }
    | "est différent de" { Different }
    | ['a''A']"fficher" { Afficher }
    | '(' { Parenthese_Gauche }
    | ')' { Parenthese_Droite }
    | ['s''S']"i" { Si }
    | "alors" { Alors }
    | ['s''S']"inon" { Sinon }
    | "Tant que" { Tant_que }
    | "Ce qui conclut la boucle" { Fin_boucle }
    | "Ce qui correspond à la fin de notre condition" | "Fin de la condition" { Fin_condition }
    | "En itérant sur" { Iterer }
    | "allant de" { Allant_de }
    | "à" { A }
    | "compris" { Compris }
    | "non compris" { Non_compris }
    | "on agit selon la séquence suivante :" { Agir }
    | "Ce qui termine la séquence" { Termine_sequence }
    | "On incrémente" { Incrementer }
    | "On décrémente" { Decrementer }
    | "de" { De }
    | '<' ([^'>']* as str) '>' { Chaine_caractere(str) }
    | nombre as d { Entier d }
    | mot as mot { Mot mot }
    | (alphabet_maj | lettre_speciales_maj) mot? as mot_maj { Mot_majuscule mot_maj } 
    | ponctuation_fin_phrase as c { Ponctuation_fin_phrase c }
    | "Nota bene : " | "N. B. : " { commentaire lexbuf }
    | eof { EOF }
    | _ as c { Printf.printf "Caractère inconnu '%c'\n" c; exit 1}

and commentaire =
    parse
    | "\n" { decoupe lexbuf }
    | _ { commentaire lexbuf }
