%{
    open Ast
%}
%token Assigne Afficher
%token Plus Egal Fois
%token Parenthese_Gauche Parenthese_Droite
%token EOF Tabulation
%token <string> Mot Mot_majuscule Ponctuation_fin_phrase Nombre

%nonassoc Assigne
%nonassoc Egal
%nonassoc Plus
%nonassoc Fois
%left Parenthese_Gauche

%start main
%type <Ast.ast> main

%%

main:
    | declarations EOF { Paragraphe($1) }


/* phrase: maj_mot mots Ponctuation_fin_phrase EOF { Phrase($1::$2, $3) } */


/* mots: mot { [$1] } | mot mots { $1::$2 } */

maj_mot: Mot_majuscule { Mot($1) }

/* mot: Mot { Mot($1) } */

expression:
    | Parenthese_Gauche expression Parenthese_Droite { $2 }
    | expression Plus expression { Plus($1, $3) }
    | expression Fois expression { Fois($1, $3) }
    | expression Egal expression { Egal($1, $3) }
    | Nombre { Nombre($1) }
    | Mot { Mot($1) }

declaration:
    | maj_mot Assigne expression Ponctuation_fin_phrase { Assigne($1, $3) }
    | Afficher expression Ponctuation_fin_phrase { Afficher($2) }

declarations:
    declaration { [$1] } | declaration declarations { $1::$2 }

/* paragraphe: declarations { Paragraphe($2) } */

