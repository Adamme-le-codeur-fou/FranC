{
    open Parser
    open Erreurs
}

let debut_chaine = '<'
let fin_chaine = '>'
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
let feminin = 'e'?

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
    | "fois" | "multiplié"feminin" par" { Fois }
    | "divisé"feminin" par" | "divise par" { Division }
    | "le reste de la division euclidienne de" | "modulo" { Reste_division_euclidienne }
    | "par" { Par }
    | "prend la valeur" | "devient" { Assigne }
    | "vaut" | "égal"feminin | "est égal"feminin" à" { Egal }
    | "est différent"feminin" de" | "n'est pas égal"feminin" à" { Different }
    | "est inférieur"feminin" à" | "plus petit"feminin" que" { Inferieur }
    | "est inférieur"feminin" ou égal"feminin" à" | "plus petit"feminin" ou égal"feminin" à" { Inferieur_ou_egal }
    | "est supérieur"feminin" à" | "plus grand"feminin" que" { Superieur }
    | "est supérieur"feminin" ou égal"feminin" à" | "plus grand"feminin" ou égal"feminin" à" { Superieur_ou_egal }
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
    | "compris"feminin { Compris }
    | "non compris"feminin { Non_compris }
    | "on agit selon la séquence suivante :" { Agir }
    | "Ce qui termine la séquence" { Termine_sequence }
    | ['o''O']"n incrémente" | ['i''I']"ncrémenter" { Incrementer }
    | ['o''O']"n décrémente" | ['d''D']"ncrémenter" { Decrementer }
    | "de" { De }
    | "un tableau contenant" { Tableau_contenant }
    | ['l''L']"'élément" | ['l''L']"'element" { Element }
    | "la taille de" { Taille_de }
    | "Ajouter" { Ajouter }
    | "Modifier" { Modifier }
    | "Lire" { Lire }
    | "vrai" { Vrai }
    | "faux" { Faux }
    | ['l''L']"a racine de" | ['l''L']"a racine carrée de" | ['l''L']"a racine carree de" { Racine }
    | "puissance" { Puissance_token }
    | ['l''L']"a valeur absolue de" { Valeur_absolue }
    | ['u''U']"n nombre aléatoire entre" | ['u''U']"n nombre aleatoire entre" { Aleatoire_entre }
    | ['p''P']"our chaque" { Pour_chaque }
    | ['e''E']"xécuter" | ['e''E']"xecuter" { Executer }
    | "avec l'ingrédient" | "avec l'ingredient" { Avec_ingredient }
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
    | debut_chaine { analyser_chaine [] [] "" lexbuf }
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

and analyser_chaine variables textes texte_courant = 
    parse
    | '[' ('[' as crochet) | ']' (']' as crochet) { analyser_chaine variables textes (texte_courant ^ String.make 1 crochet) lexbuf }
    | '[' ([^'['']'] [^']']* as variable) ']'     { analyser_chaine (variable::variables) (texte_courant::textes) "" lexbuf }
    | fin_chaine {
      if List.is_empty variables
        then Chaine_caractere(texte_courant)
        else Chaine_formatee(List.rev (texte_courant::textes), List.rev variables)
      }
    | eof {
      let pos = Lexing.lexeme_start_p lexbuf in
        raise (Erreur_lexer (formater_erreur (formater_position pos) "Fin de chaîne inattendue. Pensez à fermer votre chaîne."))
      }
    | _ as caractere { analyser_chaine variables textes (texte_courant ^ String.make 1 caractere) lexbuf }