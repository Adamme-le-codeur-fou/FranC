{
    open Parser
}

let chiffre = ['0'-'9']
let nombre = chiffre+
let alphabet_min =  ['a'-'z']
let alphabet_maj = ['A'-'Z']
let lettre_speciales_min = ['\x82''\x8A''\x87''\x85''\x97'] (* é, è, ç, à, ù' *) 
let lettre_speciales_maj = ['\x90''\xD4''\x80''\xB7''\xEB'] (* É, È, Ç, À, Ù *) 
let ponctuation = ['.''?''!'','';'] | "..." | ['['']'] | "<<" | ">>" | "-"
let mot = alphabet_min+

rule decoupe =
    parse
    | [' ''\n''\t']+ { decoupe lexbuf }
    | "plus" { Plus }
    | "fois" | "multiplié par" { Fois }
    | "le reste de la division euclidienne de" { Reste_division_euclidienne_debut }
    | "par" { Par }
    | "prend la valeur" | "devient" { Assigne }
    | "vaut" | "égal" { Egal }
    | "est différent de" { Different }
    | ['a''A']"fficher" { Afficher }
    | '(' { Parenthese_Gauche }
    | ')' { Parenthese_Droite }
    | ['s''S']"i" { Si }
    | "alors" { Alors }
    | "sinon" { Sinon }
    | "Tant que" { Tant_que }
    | "Ce qui conclut la boucle" { Fin_boucle }
    | "Ce qui correspond à la fin de notre condition" { Fin_condition }
    | "En itérant sur" { Iterer }
    | "allant de" { Allant_de }
    | "à" { A }
    | "compris" { Compris }
    | "non compris" { Non_compris }
    | "on agit selon la séquence suivante :" { Agir }
    | "Ce qui termine la séquence" { Termine_sequence }
    | "On incrémente" { Incrementer }
    | "de" { De }
    | nombre as d { Nombre d }
    | mot as mot { Mot mot }
    | (alphabet_maj | lettre_speciales_maj) mot? as mot_maj { Mot_majuscule mot_maj } 
    | ponctuation as ponct { Ponctuation_fin_phrase ponct } 
    | eof { EOF }
    | _ as c { Printf.printf "unknown character '%c'\n" c; exit 1}
