open Ast
open Fonctions
open Ecrire

let rec existe_dans_ast predicat ast =
  if predicat ast then true
  else match ast with
  | Assigne (_, expr) | Afficher expr | Renvoyer expr
  | RacineCarre expr | ValeurAbsolue expr | Negatif expr -> existe_dans_ast predicat expr
  | Paragraphe l | Tableau l -> List.exists (existe_dans_ast predicat) l
  | Recette (_, _, _, corps) -> List.exists (existe_dans_ast predicat) corps
  | Condition (cond, alors, sinon) ->
    existe_dans_ast predicat cond || List.exists (existe_dans_ast predicat) alors
    || (match sinon with Some s -> List.exists (existe_dans_ast predicat) s | None -> false)
  | BoucleTantQue (cond, corps) ->
    existe_dans_ast predicat cond || List.exists (existe_dans_ast predicat) corps
  | ForInclus (_, s, e, corps) | ForExclus (_, s, e, corps) ->
    existe_dans_ast predicat s || existe_dans_ast predicat e || List.exists (existe_dans_ast predicat) corps
  | PourChaque (_, _, corps) -> List.exists (existe_dans_ast predicat) corps
  | Plus (a, b) | Moins (a, b) | Fois (a, b) | Division (a, b)
  | Egal (a, b) | Different (a, b) | Et (a, b) | Ou (a, b)
  | Inferieur (a, b) | Superieur (a, b) | Inferieur_ou_egal (a, b)
  | Superieur_ou_egal (a, b) | Modulo (a, b)
  | Puissance (a, b) | Aleatoire (a, b) ->
    existe_dans_ast predicat a || existe_dans_ast predicat b
  | Increment (_, Some e) | Decrement (_, Some e) -> existe_dans_ast predicat e
  | Appel_recette (_, args) -> List.exists (existe_dans_ast predicat) args
  | Localise (_, inner) -> existe_dans_ast predicat inner
  | _ -> false

let utilise_tableaux = existe_dans_ast (function
  | Tableau _ | AccesTableau _ | ModificationTableau _
  | TailleTableau _ | AjouterTableau _ | PourChaque _ -> true
  | _ -> false)

let utilise_aleatoire = existe_dans_ast (function
  | Aleatoire _ -> true
  | _ -> false)

let ecrire_includes avec_tableaux avec_aleatoire =
  ecrire "#include <stdio.h>\n#include <wchar.h>\n#include <locale.h>\n#include <math.h>\n";
  if avec_tableaux then ecrire "#include <stdlib.h>\n#include <string.h>\n"
  else if avec_aleatoire then ecrire "#include <stdlib.h>\n"
  else ecrire "\n";
  if avec_aleatoire then ecrire "#include <time.h>\n"

let ecrire_helpers_tableaux () =
  ecrire "\ntypedef struct { void* donnees; int taille; int capacite; size_t taille_element; } Tableau;\n";
  ecrire "\nTableau* nouveau_tableau(int capacite, size_t taille_element) {\n";
  ecrire "    Tableau* t = malloc(sizeof(Tableau));\n";
  ecrire "    t->donnees = malloc(capacite * taille_element);\n";
  ecrire "    t->taille = 0;\n";
  ecrire "    t->capacite = capacite;\n";
  ecrire "    t->taille_element = taille_element;\n";
  ecrire "    return t;\n}\n";
  ecrire "\nvoid ajouter_element(Tableau* t, void* valeur) {\n";
  ecrire "    if (t->taille >= t->capacite) {\n";
  ecrire "        t->capacite *= 2;\n";
  ecrire "        t->donnees = realloc(t->donnees, t->capacite * t->taille_element);\n";
  ecrire "    }\n";
  ecrire "    memcpy((char*)t->donnees + t->taille * t->taille_element, valeur, t->taille_element);\n";
  ecrire "    t->taille++;\n}\n";
  ecrire "\nvoid liberer_tableau(Tableau* t) {\n";
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
  let avec_aleatoire = utilise_aleatoire ast in
  ecrire_includes avec_tableaux avec_aleatoire;
  if avec_tableaux then ecrire_helpers_tableaux ();
  ecrire_fonctions_pre_main ecrire_ast ast;
  ecrire "\nint main(){\nsetlocale(LC_ALL, \"\");\n";
  if avec_aleatoire then ecrire "srand(time(NULL));\n";
  ecrire "wprintf(L\"Programme : %s\\n\");\n" nom_programme
