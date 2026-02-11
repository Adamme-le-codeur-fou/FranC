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
%token Reste_division_euclidienne Par
%token Iterer Sur Allant_de A Compris Non_compris Termine_sequence Agir
%token Incrementer De Decrementer
%token EOF Tabulation
%token Definir_recette Ingredients_recette Type_retour_Recette Fin_recette Renvoyer Resultat_de_recette Avec_les_ingredients Avec_ingredient
%token Pour_chaque Executer
%token Type_entier Type_reel Type_chaine_caractere Type_tableau
%token Deux_points Tiret Virgule NEGATIF Vrai Faux
%token Racine Puissance_token Valeur_absolue Aleatoire_entre
%token <string> Mot Mot_majuscule Chaine_caractere
%token <string list * string list> Chaine_formatee
%token <char> Ponctuation_fin_phrase
%token <string> Entier Reel


%nonassoc Et
%nonassoc Ou_Si
%nonassoc Et_Si
%nonassoc Assigne
%nonassoc Egal Different Inferieur Inferieur_ou_egal Superieur Superieur_ou_egal
%left Plus Moins
%left Reste_division_euclidienne Par
%left Fois Division
%right Puissance_token
%nonassoc NEGATIF Avec_ingredient
%left Parenthese_Gauche
%left Si Alors Tant_que Agir
%right Sinon

%start main
%type <Ast.ast> main

%%


// ========== Main ==========
main:
  | EOF            { Paragraphe([]) }
  | paragraphe EOF { Paragraphe($1) }

instruction:
  | declaration    { Localise(Parsing.symbol_start_pos (), $1) }
  | conditionnelle { Localise(Parsing.symbol_start_pos (), $1) }
  | boucle         { Localise(Parsing.symbol_start_pos (), $1) }
  | recette        { Localise(Parsing.symbol_start_pos (), $1) }

paragraphe:
  | instruction paragraphe { $1 :: $2 }
  | instruction            { [$1] }



// ========== Types ==========
types:
  | Type_entier           { TypeEntier }
  | Type_reel             { TypeReel }
  | Type_tableau types    { TypeTableau($2) }
  | Type_chaine_caractere { TypeChaineCaractere }



// ========== Expressions ==========
expression:
  | recette_appel      { $1 }
  | base_expression    { $1 }
  | operateur_unaire   { $1 }
  | operateur_binaire  { $1 }
  | tableau_expression { $1 }
  | Parenthese_Gauche expression Parenthese_Droite { $2 }

tableau_expression:
  | Taille_de Mot                       { TailleTableau($2) }
  | Element expression De Mot           { AccesTableau($4, $2) }
  | Tableau_contenant liste_expressions { Tableau($2) }

recette_appel:
  | Resultat_de_recette Mot Avec_ingredient expression             { Appel_recette($2, [$4]) }
  | Resultat_de_recette Mot Avec_les_ingredients liste_expressions { Appel_recette($2, $4) }

base_expression:
  | Mot    { Mot($1) }
  | Reel   { Reel($1) }
  | Vrai   { Vrai }
  | Faux   { Faux }
  | Entier { Entier($1) }
  | Chaine_caractere { Chaine_caractere($1) }
  | Chaine_formatee  { let (t, v) = $1 in ChaineFormatee(t, v) }

operateur_unaire:
  | Tiret expression %prec NEGATIF           { Negatif($2) }
  | Racine expression %prec NEGATIF          { RacineCarre($2) }
  | Valeur_absolue expression %prec NEGATIF  { ValeurAbsolue($2) }
  | Aleatoire_entre expression Et expression { Aleatoire($2, $4) }

operateur_binaire:
  | expression Plus expression              { Plus($1, $3) }
  | expression Fois expression              { Fois($1, $3) }
  | expression Egal expression              { Egal($1, $3) }
  | expression Moins expression             { Moins($1, $3) }
  | expression Et_Si expression             { Et($1, $3) }
  | expression Ou_Si expression             { Ou($1, $3) }
  | expression Division expression          { Division($1, $3) }
  | expression Different expression         { Different($1, $3) }
  | expression Inferieur expression         { Inferieur($1, $3) }
  | expression Superieur expression         { Superieur($1, $3) }
  | expression Puissance_token expression   { Puissance($1, $3) }
  | expression Inferieur_ou_egal expression { Inferieur_ou_egal($1, $3) }
  | expression Superieur_ou_egal expression { Superieur_ou_egal($1, $3) }
  | Reste_division_euclidienne expression Par expression { Modulo($2, $4) }

liste_expressions:
  | expression Virgule liste_expressions { $1 :: $3 }
  | expression Et expression             { [ $1; $3 ] }

mot_majuscule: Mot_majuscule { Mot($1) }



// ========== Declarations ==========
declaration:
  | Lire Mot Ponctuation_fin_phrase
        { Lire($2) }
  | Executer Mot Ponctuation_fin_phrase
        { Appel_recette($2, []) }
  | Decrementer Mot Ponctuation_fin_phrase
        { Decrement($2, None) }
  | Incrementer Mot Ponctuation_fin_phrase
        { Increment($2, None) }
  | Renvoyer expression Ponctuation_fin_phrase
        { Renvoyer($2) }
  | Afficher expression Ponctuation_fin_phrase
        { Afficher($2) }
  | Permuter Mot Avec Mot Ponctuation_fin_phrase
        { Permuter($2, $4) }
  | Ajouter expression A Mot Ponctuation_fin_phrase
        { AjouterTableau($4, $2) }
  | Incrementer Mot De expression Ponctuation_fin_phrase
        { Increment($2, Some $4) }
  | Decrementer Mot De expression Ponctuation_fin_phrase
        { Decrement($2, Some $4) }
  | mot_majuscule Assigne expression Ponctuation_fin_phrase
        { Assigne($1, $3) }
  | Executer Mot Avec_ingredient expression Ponctuation_fin_phrase
        { Appel_recette($2, [$4]) }
  | Modifier Element expression De Mot Avec expression Ponctuation_fin_phrase
        { ModificationTableau($5, $3, $7) }
  | Executer Mot Avec_les_ingredients liste_expressions Ponctuation_fin_phrase
        { Appel_recette($2, $4) }



// ========== Conditionnelles ==========
conditionnelle:
  | Si expression Alors paragraphe Fin_condition Ponctuation_fin_phrase                  { Condition($2, $4, None) }
  | Si expression Alors paragraphe Sinon paragraphe Fin_condition Ponctuation_fin_phrase { Condition($2, $4, Some $6) }



// ========== Boucles ==========
boucle :
  | boucle_tant_que    { $1 }
  | boucle_pour        { $1 }
  | boucle_pour_chaque { $1 }

boucle_tant_que : Tant_que expression Alors paragraphe Fin_boucle Ponctuation_fin_phrase { BoucleTantQue($2, $4) }

boucle_pour:
  | Iterer Mot Allant_de expression A expression Agir paragraphe Termine_sequence Ponctuation_fin_phrase
        { ForExclus($2, $4, $6, $8) }
  | Iterer Mot Allant_de expression A expression Compris Agir paragraphe Termine_sequence Ponctuation_fin_phrase
        { ForInclus($2, $4, $6, $9) }
  | Iterer Mot Allant_de expression A expression Non_compris Agir paragraphe Termine_sequence Ponctuation_fin_phrase
        { ForExclus($2, $4, $6, $9) }

boucle_pour_chaque:
  | Pour_chaque Mot De Mot Agir paragraphe Termine_sequence Ponctuation_fin_phrase { PourChaque($2, $4, $6) }



// ========== Recettes ==========
recette:
  | Definir_recette Mot Deux_points paragraphe Fin_recette Ponctuation_fin_phrase
      { Recette($2, [], TypeNeant, $4) }
  | Definir_recette Mot Type_retour_Recette types Deux_points paragraphe Fin_recette Ponctuation_fin_phrase
      { Recette($2, [], $4, $6) }
  | Definir_recette Mot Ingredients_recette liste_ingredients Deux_points paragraphe Fin_recette Ponctuation_fin_phrase
      { Recette($2, $4, TypeNeant, $6) }
  | Definir_recette Mot Ingredients_recette liste_ingredients Type_retour_Recette types Deux_points paragraphe Fin_recette Ponctuation_fin_phrase
      { Recette($2, $4, $6, $8) }

liste_ingredients:
  | Tiret types Mot liste_ingredients { ( $3, $2 ) :: $4 }
  | Tiret types Mot                   { [ ( $3, $2 ) ] }