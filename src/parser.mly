%{
    open Ast
%}
%token Assigne Afficher
%token Plus Egal Fois Different
%token Parenthese_Gauche Parenthese_Droite
%token Si Alors Sinon Fin_condition
%token Tant_que Fin_boucle 
%token Reste_division_euclidienne_debut Par
%token Iterer Sur Allant_de A Compris Non_compris Termine_sequence Agir
%token Incrementer De
%token EOF Tabulation
%token <string> Mot Mot_majuscule Ponctuation_fin_phrase Nombre

%nonassoc Assigne
%nonassoc Egal Different
%nonassoc Plus
%nonassoc Reste_division_euclidienne_debut Par
%nonassoc Fois
%left Parenthese_Gauche
%left Si Alors Tant_que Agir
%right Sinon

%start main
%type <Ast.ast> main

%%

main: paragraphe EOF { Paragraphe($1) }


/* phrase: maj_mot mots Ponctuation_fin_phrase EOF { Phrase($1::$2, $3) } */


/* mots: mot { [$1] } | mot mots { $1::$2 } */

maj_mot: Mot_majuscule { Mot($1) }

/* mot: Mot { Mot($1) } */

expression:
    | Reste_division_euclidienne_debut expression Par expression { Modulo($2, $4) }
    | Parenthese_Gauche expression Parenthese_Droite { $2 }
    | expression Plus expression { Plus($1, $3) }
    | expression Fois expression { Fois($1, $3) }
    | expression Egal expression { Egal($1, $3) }
    | expression Different expression { Different($1, $3) }
    | Nombre { Nombre($1) }
    | Mot { Mot($1) }

declaration:
    | maj_mot Assigne expression Ponctuation_fin_phrase { Assigne($1, $3) }
    | Afficher expression Ponctuation_fin_phrase { Afficher($2) }

conditionnelle:
  | Si expression Alors paragraphe Fin_condition Ponctuation_fin_phrase { Condition($2, $4, None) }
  | Si expression Alors paragraphe Sinon paragraphe Fin_condition Ponctuation_fin_phrase { Condition($2, $4, Some $6) }

boucle_tant_que : Tant_que expression Alors paragraphe Fin_boucle Ponctuation_fin_phrase  { BoucleTantQue($2, $4) }

boucle_pour:
    | Iterer Mot Allant_de expression A expression Compris Agir paragraphe Termine_sequence Ponctuation_fin_phrase
        { ForInclus($2, $4, $6, $9) }
    | Iterer Mot Allant_de expression A expression Non_compris Agir paragraphe Termine_sequence Ponctuation_fin_phrase
        { ForExclus($2, $4, $6, $9) }
    | Iterer Mot Allant_de expression A expression Agir paragraphe Termine_sequence Ponctuation_fin_phrase
        { ForExclus($2, $4, $6, $8) }

instruction:
  | declaration { $1 }
  | conditionnelle { $1 }
  | boucle_tant_que { $1 }
  | boucle_pour { $1 }
  | Incrementer Mot Ponctuation_fin_phrase { Increment($2, None) }
  | Incrementer Mot De expression Ponctuation_fin_phrase { Increment($2, Some $4) }

paragraphe:
    | instruction paragraphe { $1 :: $2 }
    | instruction { [$1] }

