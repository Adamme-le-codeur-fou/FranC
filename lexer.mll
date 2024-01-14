{
    open Parser
}

let chiffre = ['0'-'9']
let nombre = chiffre+
let alphabet_min =  ['a'-'z']
let alphabet_maj = ['A'-'Z']
let lettre_speciales_min = ['\x82''\x8A''\x87''\x85''\x97'] (* é, è, ç, à, ù' *) 
let lettre_speciales_maj = ['\x90''\xD4''\x80''\xB7''\xEB'] (* É, È, Ç, À, Ù *) 
let ponctuation = ['.''?''!'','';'':'] | "..." | ['['']'] | "<<" | ">>" | "-"
let mot = alphabet_min+

rule decoupe =
    parse
    | [' ''\n''\t']+ { decoupe lexbuf }
    | "plus" { Plus }
    | "fois" | "multiplié par" { Fois }
    | "prend la valeur" | "devient" { Assigne }
    | "vaut" | "égal" { Egal }
    | '(' { Parenthese_Gauche }
    | ')' { Parenthese_Droite }
    | nombre as d { Nombre d }
    | mot as mot { Mot mot }
    | (alphabet_maj | lettre_speciales_maj) mot? as mot_maj { Mot_majuscule mot_maj } 
    | ponctuation as ponct { Ponctuation_fin_phrase ponct } 
    | eof { EOF }
    | _ as c { Printf.printf "unknown character '%c'\n" c; exit 1}
