open Ast
open Fonctions
open Ecrire

let rec utilise_tableaux ast =
  match ast with
  | Tableau _ | AccesTableau _ | ModificationTableau _
  | TailleTableau _ | AjouterTableau _ -> true
  | Assigne (_, expr) -> utilise_tableaux expr
  | Afficher expr -> utilise_tableaux expr
  | Renvoyer expr -> utilise_tableaux expr
  | Paragraphe l -> List.exists utilise_tableaux l
  | Recette (_, _, _, corps) -> List.exists utilise_tableaux corps
  | Condition (cond, alors, sinon) ->
    utilise_tableaux cond || List.exists utilise_tableaux alors
    || (match sinon with Some s -> List.exists utilise_tableaux s | None -> false)
  | BoucleTantQue (cond, corps) ->
    utilise_tableaux cond || List.exists utilise_tableaux corps
  | ForInclus (_, s, e, corps) | ForExclus (_, s, e, corps) ->
    utilise_tableaux s || utilise_tableaux e || List.exists utilise_tableaux corps
  | Plus (a, b) | Moins (a, b) | Fois (a, b) | Division (a, b)
  | Egal (a, b) | Different (a, b) | Et (a, b) | Ou (a, b)
  | Inferieur (a, b) | Superieur (a, b) | Inferieur_ou_egal (a, b)
  | Superieur_ou_egal (a, b) | Modulo (a, b) ->
    utilise_tableaux a || utilise_tableaux b
  | Increment (_, Some e) | Decrement (_, Some e) -> utilise_tableaux e
  | Appel_recette (_, args) -> List.exists utilise_tableaux args
  | Localise (_, inner) -> utilise_tableaux inner
  | _ -> false

let ecrire_includes avec_tableaux =
  ecrire "#include <stdio.h>\n#include <wchar.h>\n#include <locale.h>\n";
  if avec_tableaux then ecrire "#include <stdlib.h>\n"
  else ecrire "\n"

let ecrire_helpers_tableaux () =
  ecrire "\ntypedef struct { int* donnees; int taille; int capacite; } TableauEntier;\n";
  ecrire "typedef struct { float* donnees; int taille; int capacite; } TableauReel;\n";
  ecrire "\nTableauEntier* nouveau_tableau_entier(int capacite) {\n";
  ecrire "    TableauEntier* t = malloc(sizeof(TableauEntier));\n";
  ecrire "    t->donnees = malloc(capacite * sizeof(int));\n";
  ecrire "    t->taille = 0;\n";
  ecrire "    t->capacite = capacite;\n";
  ecrire "    return t;\n}\n";
  ecrire "\nvoid ajouter_element_entier(TableauEntier* t, int valeur) {\n";
  ecrire "    if (t->taille >= t->capacite) {\n";
  ecrire "        t->capacite *= 2;\n";
  ecrire "        t->donnees = realloc(t->donnees, t->capacite * sizeof(int));\n";
  ecrire "    }\n";
  ecrire "    t->donnees[t->taille++] = valeur;\n}\n";
  ecrire "\nTableauReel* nouveau_tableau_reel(int capacite) {\n";
  ecrire "    TableauReel* t = malloc(sizeof(TableauReel));\n";
  ecrire "    t->donnees = malloc(capacite * sizeof(float));\n";
  ecrire "    t->taille = 0;\n";
  ecrire "    t->capacite = capacite;\n";
  ecrire "    return t;\n}\n";
  ecrire "\nvoid ajouter_element_reel(TableauReel* t, float valeur) {\n";
  ecrire "    if (t->taille >= t->capacite) {\n";
  ecrire "        t->capacite *= 2;\n";
  ecrire "        t->donnees = realloc(t->donnees, t->capacite * sizeof(float));\n";
  ecrire "    }\n";
  ecrire "    t->donnees[t->taille++] = valeur;\n}\n";
  ecrire "\nvoid liberer_tableau_entier(TableauEntier* t) {\n";
  ecrire "    free(t->donnees);\n";
  ecrire "    free(t);\n}\n";
  ecrire "\nvoid liberer_tableau_reel(TableauReel* t) {\n";
  ecrire "    free(t->donnees);\n";
  ecrire "    free(t);\n}\n"

let rec ecrire_fonctions_pre_main ecrire_ast ast =
  match ast with
  | Recette(nom, arguments, type_function, corps) -> ecrire_function ecrire_ast nom arguments type_function corps
  | Localise (_, inner) -> ecrire_fonctions_pre_main ecrire_ast inner
  | Paragraphe l -> List.iter (ecrire_fonctions_pre_main ecrire_ast) l
  | _ -> ()

let ecrire_debut ecrire_ast ast nom_programme =
  let avec_tableaux = utilise_tableaux ast in
  ecrire_includes avec_tableaux;
  if avec_tableaux then ecrire_helpers_tableaux ();
  ecrire_fonctions_pre_main ecrire_ast ast;
  ecrire "\nint main(){\nsetlocale(LC_ALL, \"\");\nwprintf(L\"Programme : %s\\n\");\n" nom_programme
