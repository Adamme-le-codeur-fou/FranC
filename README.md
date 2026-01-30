# FranC

Langage de programmation français

## Installation et Utilisation (Linux)

### Prérequis

- OCaml et opam installés
- GCC (ou n'importe quel compilateur C)
- Dune (système de build pour OCaml)

### Compilation du projet

1. **Nettoyer les builds précédents** :
   ```bash
    dune clean
   ```

2. **Compiler le projet** :
   ```bash
    dune build
   ```

### Exécution d'un programme FranC

1. **Compiler un fichier FranC vers C puis vers un exécutable** :
   ```bash
    ./_build/default/src/main.exe votre_fichier.fr output/output.c
    gcc -Wall -Wextra -std=c99 -o output/output output/output.c
   ```

2. **Exécuter le programme compilé** :
   ```bash
    ./output/output
   ```

# Dictionnaire de Référence pour le Langage FranC vers C

Ce dictionnaire fournit des exemples de comment différentes constructions en FranC sont traduites en code C.

## Règles des Variables

- En FranC, une variable est **définie** avec une **lettre majuscule** au début (exemple : `A`).
- Pour **utiliser** une variable déjà définie, on utilise une **lettre minuscule** au début (exemple : `a`).
- On ne peut pas utiliser une variable si elle n'a pas été définie auparavant.

## Types de Données

| Type FranC                    | Type C       | Exemple                                  |
| ----------------------------- | ------------ | ---------------------------------------- |
| un entier                     | `int`        | `A devient 10.`                          |
| un réel                       | `float`      | `B devient 3,14.`                        |
| une chaîne de caractères      | `wchar_t *`  | `Message devient <Bonjour>.`             |

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
| `F devient le reste de la division euclidienne de 5 par 3.` | `int F = 5 % 3;`            |

## Comparaisons

| FranC                                    | C                   |
| ---------------------------------------- | ------------------- |
| `A devient a est égal à 4.`              | `int A = (a == 4);` |
| `B devient a est différent de b.`        | `int B = (a != b);` |
| `C devient a est inferieur à b.`         | `int C = (a < b);`  |
| `D devient a est inférieur ou égal à b.` | `int D = (a <= b);` |
| `E devient a est supérieur à b.`         | `int E = (a > b);`  |
| `F devient a est supérieur ou égal à b.` | `int F = (a >= b);` |

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

## Affichage

| FranC                        | C                         |
| ---------------------------- | ------------------------- |
| `Afficher a.`                | `printf("%d\n", a);`      |
| `Afficher <Bonjour>.`        | `wprintf(L"Bonjour\n");`  |

## Opérations sur Variables

| FranC                        | C                                    |
| ---------------------------- | ------------------------------------ |
| `On incrémente a.`           | `a++;`                               |
| `On incrémente a de 5.`      | `a += 5;`                            |
| `On décrémente a.`           | `a--;`                               |
| `On décrémente a de 3.`      | `a -= 3;`                            |
| `Permuter a avec b.`         | `int temp = a; a = b; b = temp;` |

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

**Appel d'une recette :**
| FranC                                                                     | C                                    |
| ------------------------------------------------------------------------- | ------------------------------------ |
| `Resultat devient le résultat de puissance avec les ingrédients a et b. ` | `int resultat = puissance(a, b);`    |

## Commentaires

| FranC                              | C                    |
| ---------------------------------- | -------------------- |
| `N. B. : Ceci est un commentaire.` | `// Commentaire`     |
| `Nota bene : Un autre commentaire.`| `// Commentaire`     |

Note : Les exemples en C supposent que les variables sont déjà déclarées et initialisées si nécessaire.

## Gestion des Exceptions et Structure du AST

Dans le cadre du développement de FranC, plusieurs exceptions sont définies pour gérer les cas d'erreurs spécifiques :

- `PhraseInvalide` : Levée lorsqu'une phrase ne peut pas être correctement analysée ou transformée en AST.
- `TokenInvalide` : Levée lorsqu'un jeton (token) inattendu ou invalide est rencontré dans l'analyse syntaxique.
- `IncompatibiliteDeType` : Levée lorsqu'il y a une incompatibilité de types dans les expressions ou affectations.
- `VariableNonDeclaree` : Levée lorsqu'une variable est utilisée sans avoir été déclarée auparavant.

La structure du Abstract Syntax Tree (AST) est définie comme suit :

- `Mot` : Représente un mot ou une variable dans le code FranC.
- `Entier` : Représente un nombre entier littéral.
- `Reel` : Représente un nombre réel littéral.
- `Chaine_caractere` : Représente une chaîne de caractères littérale.
- `Phrase` : Une suite d'éléments AST formant une phrase.
- `Plus`, `Moins`, `Fois`, `Modulo` : Représentent les opérations arithmétiques.
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

## À Vérifier

- [ ] Les erreurs de scope

## TODO

- [x] Ajouter le support pour les chaînes de caractères et les opérations associées.
- [x] Ajouter la prise en charge des commentaires dans le code FranC.
- [x] Implémenter les fonctions (recettes).
- [x] Ajouter les opérateurs de comparaison complets (<, <=, >, >=).
- [x] Ajouter les opérateurs logiques (et, ou).
- [x] Ajouter les nombres réels.
- [x] Ajouter l'incrémentation et la décrémentation.
- [ ] Implémenter le typage haut niveau pour des structures de données complexes.
- [ ] Développer des fonctions intégrées pour les opérations courantes (mathématiques, chaînes, etc.).
- [ ] Améliorer le système d'erreur pour fournir des messages plus détaillés et des suggestions de correction.
- [ ] Ajouter une fonctionnalité de vérification de type statique.
- [ ] Créer un système de modules ou de packages pour permettre la réutilisation du code.
- [ ] Étendre la documentation pour couvrir plus de cas d'utilisation et d'exemples.
- [ ] Implémenter une interface graphique pour faciliter l'écriture et le test de code en FranC.
- [ ] Ajouter le support pour les tableaux et les structures de données.
- [ ] Ajouter les opérations sur les chaînes de caractères (concaténation, longueur, etc.).
