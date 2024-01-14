%{
    open Ast
%}
%token Assigne Afficher
%token Plus Egal Fois
%token Parenthese_Gauche Parenthese_Droite
%token Si Alors Sinon
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
  | conditionnelle EOF { $1 }
  | expression Ponctuation_fin_phrase EOF { Paragraphe([Expression $1]) }
  | paragraphe EOF { Paragraphe(List.rev $1) }


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

conditionnelle:
  | Si expression Alors paragraphe { Condition($2, $4, None) }
  | Si expression Alors paragraphe Sinon paragraphe { Condition($2, $4, Some $6) }

paragraphe:
  | declaration { [$1] }
  | declaration paragraphe { $1::$2 }
  | conditionnelle { [$1] }



