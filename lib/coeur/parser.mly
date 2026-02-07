%{
    open Ast
%}

%token Assigne Afficher Permuter Avec
%token Tableau_contenant Element Taille_de Ajouter Modifier Lire
%token Egal Different Inferieur Inferieur_ou_egal Superieur Superieur_ou_egal
%token Plus Fois Moins Division
%token Et_Si Ou_Si Et
%token Parenthese_Gauche Parenthese_Droite
%token Si Alors Sinon Fin_condition
%token Tant_que Fin_boucle 
%token Reste_division_euclidienne_debut Par
%token Iterer Sur Allant_de A Compris Non_compris Termine_sequence Agir
%token Incrementer De Decrementer
%token EOF Tabulation
%token Definir_recette Ingredients_recette Type_retour_Recette Fin_recette Renvoyer Resultat_de_recette Avec_les_ingredients
%token Type_entier Type_reel Type_chaine_caractere
%token Deux_points Tiret Virgule NEGATIF
%token <string> Mot Mot_majuscule Chaine_caractere
%token <string list * string list> Chaine_formatee
%token <char> Ponctuation_fin_phrase
%token <string> Entier Reel


%nonassoc Et
%nonassoc Ou_Si
%nonassoc Et_Si
%nonassoc Assigne
%nonassoc Egal Different Inferieur Inferieur_ou_egal Superieur Superieur_ou_egal
%nonassoc Plus Moins
%nonassoc Reste_division_euclidienne_debut Par
%nonassoc Fois Division
%nonassoc NEGATIF
%left Parenthese_Gauche
%left Si Alors Tant_que Agir
%right Sinon

%start main
%type <Ast.ast> main

%%

main: EOF {Paragraphe([])} | paragraphe EOF { Paragraphe($1) }


/* phrase: mot_majuscule mots Ponctuation_fin_phrase EOF { Phrase($1::$2, $3) } */


/* mots: mot { [$1] } | mot mots { $1::$2 } */

mot_majuscule: Mot_majuscule { Mot($1) }

/* mot: Mot { Mot($1) } */

types:
    | Type_entier { TypeEntier }
    | Type_reel { TypeReel }
    | Type_chaine_caractere { TypeChaineCaractere }

expression:
    | Parenthese_Gauche expression Parenthese_Droite { $2 }
    | Reste_division_euclidienne_debut expression Par expression { Modulo($2, $4) }
    | expression Plus expression { Plus($1, $3) }
    | expression Moins expression { Moins($1, $3) }
    | expression Fois expression { Fois($1, $3) }
    | expression Division expression { Division($1, $3) }
    | expression Egal expression { Egal($1, $3) }
    | expression Different expression { Different($1, $3) }
    | expression Inferieur expression { Inferieur($1, $3) }
    | expression Inferieur_ou_egal expression { Inferieur_ou_egal($1, $3) }
    | expression Superieur expression { Superieur($1, $3) }
    | expression Superieur_ou_egal expression { Superieur_ou_egal($1, $3) }
    | Entier { Entier($1) }
    | Reel { Reel($1) }
    | Mot { Mot($1) }
    | Chaine_caractere { Chaine_caractere($1) }
    | Chaine_formatee { let (t, v) = $1 in ChaineFormatee(t, v) }
    | expression Et_Si expression { Et($1, $3) }
    | expression Ou_Si expression { Ou($1, $3) }
    | Resultat_de_recette Mot Avec_les_ingredients liste_expressions { Appel_recette($2, $4) }
    | Tableau_contenant liste_expressions { Tableau($2) }
    | Element expression De Mot { AccesTableau($4, $2) }
    | Taille_de Mot { TailleTableau($2) }
    | Tiret expression %prec NEGATIF { Negatif($2) }

declaration:
    | mot_majuscule Assigne expression Ponctuation_fin_phrase { Assigne($1, $3) }
    | Afficher expression Ponctuation_fin_phrase { Afficher($2) }
    | Permuter Mot Avec Mot Ponctuation_fin_phrase { Permuter($2, $4) }
    | Incrementer Mot Ponctuation_fin_phrase { Increment($2, None) }
    | Incrementer Mot De expression Ponctuation_fin_phrase { Increment($2, Some $4) }
    | Decrementer Mot Ponctuation_fin_phrase { Decrement($2, None) }
    | Decrementer Mot De expression Ponctuation_fin_phrase { Decrement($2, Some $4) }
    | Renvoyer expression Ponctuation_fin_phrase { Renvoyer($2) }
    | Modifier Element expression De Mot Avec expression Ponctuation_fin_phrase { ModificationTableau($5, $3, $7) }
    | Ajouter expression A Mot Ponctuation_fin_phrase { AjouterTableau($4, $2) }
    | Lire Mot Ponctuation_fin_phrase { Lire($2) }

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

liste_expressions:
    | expression Virgule liste_expressions { $1 :: $3 }
    | expression Et expression { [ $1; $3 ] }

liste_ingredients:
    | Tiret types Mot liste_ingredients { ( $3, $2 ) :: $4 }
    | Tiret types Mot { [ ( $3, $2 ) ] }

recette:
  | Definir_recette Mot Ingredients_recette liste_ingredients Type_retour_Recette types Deux_points paragraphe Fin_recette Ponctuation_fin_phrase
      { Recette($2, $4, $6, $8) }

instruction:
  | declaration { Localise(Parsing.symbol_start_pos (), $1) }
  | conditionnelle { Localise(Parsing.symbol_start_pos (), $1) }
  | boucle_tant_que { Localise(Parsing.symbol_start_pos (), $1) }
  | boucle_pour { Localise(Parsing.symbol_start_pos (), $1) }
  | recette { Localise(Parsing.symbol_start_pos (), $1) }

paragraphe:
    | instruction paragraphe { $1 :: $2 }
    | instruction { [$1] }

