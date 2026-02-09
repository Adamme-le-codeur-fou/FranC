# FranC

Langage de programmation français

## Installation et Utilisation

### Prérequis

- OCaml et opam installés
- GCC (ou n'importe quel compilateur C)
- Dune (système de build pour OCaml : `opam install dune`)
- Alcotest (pour les tests unitaires : `opam install alcotest`)
- Clang (optionnel, pour le backend LLVM IR)

### Compilation du projet

1. **Nettoyer les builds précédents** :
   ```bash
    dune clean
   ```

2. **Compiler le projet** :
   ```bash
    dune build
   ```

3. **Exécuter les tests unitaires** :
   ```bash
    dune runtest
   ```

### Exécution d'un programme FranC

FranC propose deux backends : **C** et **LLVM IR**. Le choix se fait par l'extension du fichier de sortie.

#### Backend C (`.c`)
```bash
dune exec -- FranC votre_fichier.fr sortie.c
gcc -o sortie sortie.c -lm
./sortie
```

#### Backend LLVM IR (`.ll`)
```bash
dune exec -- FranC votre_fichier.fr sortie.ll
clang sortie.ll -o sortie -lm
./sortie
```

# Dictionnaire de Référence pour le Langage FranC

Ce dictionnaire fournit des exemples de comment différentes constructions en FranC sont traduites en code C (et LLVM IR).

## Règles des Variables

- En FranC, une variable est **définie** avec une **lettre majuscule** au début (exemple : `A`).
- Pour **utiliser** une variable déjà définie, on utilise une **lettre minuscule** au début (exemple : `a`).
- On ne peut pas utiliser une variable si elle n'a pas été définie auparavant.
- La réassignation d'une variable avec un type différent lève une erreur.
- Les variables déclarées dans un bloc (boucle, condition) ne sont **pas accessibles** en dehors (portée par bloc).

## Types de Données

| Type FranC                    | Type C       | Exemple                                  |
| ----------------------------- | ------------ | ---------------------------------------- |
| un entier                     | `int`        | `A devient 10.`                          |
| un réel                       | `float`      | `B devient 3,14.`                        |
| une chaîne de caractères      | `wchar_t *`  | `Message devient <Bonjour>.`             |
| booléen (vrai/faux)           | `int`        | `A devient vrai.`                        |

## Variables et Affectations

| FranC                  | C                |
| ---------------------- | ---------------- |
| `A devient 10.`        | `int A = 10;`    |
| `B prend la valeur 5.` | `int B = 5;`     |
| `C devient b plus c.`  | `int C = b + c;` |

## Opérations Arithmétiques

| FranC                                                       | C                           |
| ----------------------------------------------------------- | --------------------------- |
| `C devient 1 plus 1.`                                       | `int C = 1 + 1;`            |
| `D devient 10 moins 3.`                                     | `int D = 10 - 3;`           |
| `A devient 2. E devient a fois 3.`                          | `int A = 2; int E = a * 3;` |
| `F devient 10 divisé par 3.`                                | `int F = 10 / 3;`           |
| `G devient le reste de la division euclidienne de 5 par 3.` | `int G = 5 % 3;`            |
| `H devient -5.`                                            | `int H = (-5);`             |
| `I devient 10 plus -3.`                                    | `int I = (10 + (-3));`      |

## Fonctions Mathématiques

| FranC                                       | C                              | Type retour |
| ------------------------------------------- | ------------------------------ | ----------- |
| `la racine de x`                            | `sqrt(x)`                      | réel        |
| `la racine carrée de x`                     | `sqrt(x)`                      | réel        |
| `x puissance y`                             | `pow(x, y)`                    | réel        |
| `la valeur absolue de x`                    | `abs(x)` ou `fabs(x)`         | même que x  |
| `un nombre aléatoire entre x et y`          | `((rand() % (y-x+1)) + x)`    | entier      |

Les includes `<math.h>` sont ajoutés automatiquement. Si le programme utilise `aléatoire`, `<time.h>` et `srand(time(NULL))` sont aussi inclus.

## Booléens

| FranC                          | C                         |
| ------------------------------ | ------------------------- |
| `A devient vrai.`             | `int A = 1;`              |
| `B devient faux.`             | `int B = 0;`              |

## Comparaisons

| FranC                                    | C                   |
| ---------------------------------------- | ------------------- |
| `A devient a est égal à 4.`              | `int A = (a == 4);` |
| `B devient a est différent de b.`        | `int B = (a != b);` |
| `C devient a est inferieur à b.`         | `int C = (a < b);`  |
| `D devient a est inférieur ou égal à b.` | `int D = (a <= b);` |
| `E devient a est supérieur à b.`         | `int E = (a > b);`  |
| `F devient a est supérieur ou égal à b.` | `int F = (a >= b);` |

Les versions féminines sont aussi supportées (`égale`, `différente`, `inférieure`, `supérieure`).

## Opérateurs Logiques

| FranC                          | C                         |
| ------------------------------ | ------------------------- |
| `A devient a et b.`            | `int A = (a && b);`       |
| `B devient a ou b.`            | `int B = (a \|\| b);`     |

## Structures Conditionnelles

| FranC                                                                                                    | C                                        |
| -------------------------------------------------------------------------------------------------------- | ---------------------------------------- |
| `Si a est différent de b alors afficher a. Ce qui correspond à la fin de notre condition.`               | `if (a != b) { printf("%d\\n", a); }`    |
| `Si a est égal à b alors A devient 0. Sinon B devient 0. Ce qui correspond à la fin de notre condition.` | `if (a == b) { A = 0; } else { B = 0; }` |

## Boucles

| FranC                                                                                                                        | C                                                       |
| ---------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| `Tant que a est différent de 0 alors A devient a plus 1. Ce qui conclut la boucle.`                                          | `while (a != 0) { a = a + 1; }`                         |
| `En itérant sur i allant de 0 à 10 on agit selon la séquence suivante : afficher i. Ce qui termine la séquence.`             | `for (int i = 0; i < 10; i++) { printf("%d\\n", i); }`  |
| `En itérant sur i allant de 0 à 10 non compris on agit selon la séquence suivante : afficher i. Ce qui termine la séquence.` | `for (int i = 0; i < 10; i++) { printf("%d\\n", i); }`  |
| `En itérant sur i allant de 0 à 10 compris on agit selon la séquence suivante : afficher i. Ce qui termine la séquence.`     | `for (int i = 0; i <= 10; i++) { printf("%d\\n", i); }` |
| `Pour chaque element de nombres on agit selon la séquence suivante : afficher element. Ce qui termine la séquence.`          | `for (int _idx = 0; _idx < nombres->taille; _idx++) { int element = nombres->donnees[_idx]; ... }` |

## Affichage

| FranC                                    | C                                              |
| ---------------------------------------- | ---------------------------------------------- |
| `Afficher a.`                            | `printf("%d\n", a);`                            |
| `Afficher <Bonjour>.`                    | `wprintf(L"Bonjour\n");`                        |
| `Afficher <La valeur est [x]>.`          | `wprintf(L"La valeur est %d\n", x);`            |
| `Afficher <[nom] a [age] ans>.`          | `wprintf(L"%ls a %d ans\n", nom, age);`         |
| `Afficher <[[Entre crochets]]>`          | `wprintf(L"[Entre crochets]\n");`               |

Les chaînes formatées utilisent `[variable]` pour interpoler des variables. Le format (`%d`, `%f`, `%ls`) est déterminé automatiquement selon le type. Les doubles crochets `[[` et `]]` permettent d'échapper au formatage et d'afficher des crochets littéraux.

## Entrée Utilisateur

| FranC        | C                          |
| ------------ | -------------------------- |
| `Lire x.`   | `wscanf(L"%d", &x);`      |

La variable doit être déclarée avant. Types supportés : entier et réel.

## Opérations sur Variables

| FranC                        | C                                    |
| ---------------------------- | ------------------------------------ |
| `On incrémente a.`           | `a++;`                               |
| `On incrémente a de 5.`      | `a += 5;`                            |
| `On décrémente a.`           | `a--;`                               |
| `On décrémente a de 3.`      | `a -= 3;`                            |
| `Permuter a avec b.`         | `int temp = a; a = b; b = temp;` |

## Tableaux Dynamiques

| FranC                                              | C                                          |
| -------------------------------------------------- | ------------------------------------------ |
| `Nombres devient un tableau contenant 10, 20 et 30.` | `nombres = nouveau_tableau_entier(3); ...` |
| `Afficher l'element 0 de nombres.`                 | `wprintf(L"%d\n", nombres->donnees[0]);`   |
| `Modifier l'element 0 de nombres avec 99.`         | `nombres->donnees[0] = 99;`               |
| `Ajouter 50 à nombres.`                            | `ajouter_element_entier(nombres, 50);`     |
| `Afficher la taille de nombres.`                   | `wprintf(L"%d\n", nombres->taille);`       |

Les tableaux sont génériques (`void*`) et supportent les types entier, réel, chaîne de caractères et booléen. L'inférence de type est automatique. Les helpers C (allocation, ajout, libération) ne sont inclus dans le prélude que si le programme utilise des tableaux.

## Fonctions (Recettes)

En FranC, les fonctions sont appelées "recettes" :

```franc
On définit une recette nommée puissance dont les ingrédients sont :
 - un entier a
 - un entier b
et qui renvoie un entier :
    Si b est égal à 0 alors renvoyer 1.
    Sinon temp devient b moins 1. Renvoyer a multiplié par le résultat de puissance avec les ingrédients a et temp. Fin de la condition.
Fin de la recette.
```

Ce qui équivaut en C à :
```c
int puissance(int a, int b) {
    if (b == 0) {
        return 1;
    } else {
        int temp = b - 1;
        return a * puissance(a, temp);
    }
}
```

### Procédures (recettes sans retour)

Les procédures sont des recettes qui ne renvoient rien. On omet la clause `et qui renvoie` :

```franc
On définit une recette nommée saluer :
  Afficher <Bonjour>.
Fin de la recette.

On définit une recette nommée doubler dont les ingrédients sont :
- un entier n
:
  Afficher <[n] fois 2>.
Fin de la recette.
```

Ce qui génère des fonctions `void` en C.

**Appel d'une recette :**
| FranC                                                                     | C                                    |
| ------------------------------------------------------------------------- | ------------------------------------ |
| `Resultat devient le résultat de puissance avec les ingrédients a et b. ` | `int resultat = puissance(a, b);`    |
| `Resultat devient le résultat de carre avec l'ingrédient 5.`              | `int resultat = carre(5);`           |
| `Exécuter saluer.`                                                        | `saluer();`                          |
| `Exécuter doubler avec l'ingrédient 5.`                                   | `doubler(5);`                        |
| `Exécuter afficher avec les ingrédients a, b et c.`                       | `afficher(a, b, c);`                 |

## Commentaires

| FranC                              | C                    |
| ---------------------------------- | -------------------- |
| `N. B. : Ceci est un commentaire.` | `// Commentaire`     |
| `Nota bene : Un autre commentaire.`| `// Commentaire`     |

Note : Les exemples en C supposent que les variables sont déjà déclarées et initialisées si nécessaire.

## Gestion des Exceptions et Structure du AST

Dans le cadre du développement de FranC, plusieurs exceptions sont définies pour gérer les cas d'erreurs spécifiques :

- `Erreur_lexer` : Levée avec la position lorsqu'un caractère inconnu est rencontré dans l'analyse lexicale.
- `VariableNonDeclaree` : Levée lorsqu'une variable est utilisée sans avoir été déclarée auparavant.
- `Erreur_type` : Levée avec un message détaillé en français lors d'une erreur de typage (réassignation incompatible, lecture d'un type non supporté, variable non déclarée, etc.).

Toutes les erreurs incluent la position (ligne, colonne) dans le fichier source.

La structure du Abstract Syntax Tree (AST) est définie comme suit :

- `Mot` : Représente un mot ou une variable dans le code FranC.
- `Entier` : Représente un nombre entier littéral.
- `Reel` : Représente un nombre réel littéral.
- `Chaine_caractere` : Représente une chaîne de caractères littérale.
- `ChaineFormatee` : Représente une chaîne avec interpolation de variables (`<Bonjour [nom]>`).
- `Phrase` : Une suite d'éléments AST formant une phrase.
- `Plus`, `Moins`, `Fois`, `Division`, `Modulo` : Représentent les opérations arithmétiques.
- `Egal`, `Different`, `Inferieur`, `Inferieur_ou_egal`, `Superieur`, `Superieur_ou_egal` : Représentent les opérations de comparaison.
- `Et`, `Ou` : Représentent les opérations logiques.
- `Assigne`, `Afficher` : Représentent l'assignation et l'affichage.
- `Paragraphe` : Un ensemble d'instructions ou d'expressions.
- `Condition` : Représente une structure conditionnelle (if-else).
- `BoucleTantQue` : Représente une boucle while.
- `ForInclus` et `ForExclus` : Représentent des boucles for, avec des limites inclusives ou exclusives.
- `Increment`, `Decrement` : Représentent l'incrémentation et la décrémentation d'une variable.
- `Permuter` : Représente l'échange de valeurs entre deux variables.
- `Recette` : Représente une définition de fonction.
- `Appel_recette` : Représente un appel de fonction.
- `Renvoyer` : Représente l'instruction return dans une fonction.
- `Tableau` : Représente un tableau littéral.
- `AccesTableau` : Représente l'accès à un élément d'un tableau.
- `ModificationTableau` : Représente la modification d'un élément d'un tableau.
- `TailleTableau` : Représente l'accès à la taille d'un tableau.
- `AjouterTableau` : Représente l'ajout d'un élément à un tableau.
- `Lire` : Représente la lecture d'une entrée utilisateur.
- `Negatif` : Représente un nombre négatif (unaire).
- `Vrai`, `Faux` : Représentent les littéraux booléens.
- `RacineCarre` : Représente la racine carrée d'une expression.
- `Puissance` : Représente l'élévation à une puissance.
- `ValeurAbsolue` : Représente la valeur absolue d'une expression.
- `Aleatoire` : Représente un nombre aléatoire entre deux bornes.
- `PourChaque` : Représente une boucle foreach sur un tableau.

## Architecture

```
lib/
├── coeur/           Lexer (ocamllex) et Parser (ocamlyacc)
├── analyse/         AST, types, erreurs
├── ecriture/        Backend C
└── ecriture_llvm/   Backend LLVM IR
bin/
└── main.ml          CLI (choix du backend par extension .c ou .ll)
test/                Tests Alcotest (parser + codegen C)
```

Le backend est choisi automatiquement selon l'extension du fichier de sortie :
- `.c` → génération de code C (wprintf, tableaux via struct Tableau)
- `.ll` → génération de LLVM IR (printf, SSA, basic blocks, struct %Tableau)

Les deux backends couvrent l'intégralité du langage FranC.

## TODO

- [x] Chaînes de caractères et interpolation (`<Bonjour [x]>`)
- [x] Commentaires (`N. B. :`)
- [x] Fonctions (recettes) et procédures
- [x] Opérateurs de comparaison, logiques, arithmétiques
- [x] Nombres réels et négatifs
- [x] Booléens (vrai/faux)
- [x] Incrémentation / décrémentation
- [x] Tableaux dynamiques génériques avec inférence de type
- [x] Portée par bloc et gestion mémoire automatique
- [x] Entrée utilisateur (Lire)
- [x] Boucles (tant que, pour, pour chaque)
- [x] Fonctions mathématiques (racine, puissance, valeur absolue, aléatoire)
- [x] Backend LLVM IR complet
- [ ] Opérations sur les chaînes (concaténation, longueur, sous-chaîne)
- [ ] Négation logique (non / pas)
- [ ] `sinon si` (else if) sans imbriquer les conditions
- [ ] Boucle `répéter ... jusqu'à` (do-while)
- [ ] Constantes (valeur non modifiable après déclaration)
- [ ] Conversions de type explicites (entier vers réel, réel vers entier)
- [ ] Système d'import de fichiers / modules
- [ ] Messages d'erreur avec suggestions de correction
- [ ] Vérification de type statique avant la génération de code
