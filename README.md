# FranC

Langage de programmation français

# Dictionnaire de Référence pour le Langage FranC vers C

Ce dictionnaire fournit des exemples de comment différentes constructions en FranC sont traduites en code C.

## Règles des Variables

- En FranC, une variable est **définie** avec une **lettre majuscule** au début (exemple : `A`).
- Pour **utiliser** une variable déjà définie, on utilise une **lettre minuscule** au début (exemple : `a`).
- On ne peut pas utiliser une variable si elle n'a pas été définie auparavant.

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
| `A devient 2. D devient a fois 3.`                          | `int A = 2; int D = a * 3;` |
| `E devient le reste de la division euclidienne de 5 par 3.` | `int E = 5 % 3;`            |

## Comparaisons

| FranC                             | C                   |
| --------------------------------- | ------------------- |
| `A devient a est égal à 4`        | `int A = (a == 4);` |
| `B devient a est différent de b.` | `int B = (a != b);` |

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

| FranC         | C                    |
| ------------- | -------------------- |
| `Afficher a.` | `printf("%d\n", a);` |

Note : Les exemples en C supposent que les variables sont déjà déclarées et initialisées si nécessaire.

## Gestion des Exceptions et Structure du AST

Dans le cadre du développement de FranC, plusieurs exceptions sont définies pour gérer les cas d'erreurs spécifiques :

- `PhraseInvalide` : Levée lorsqu'une phrase ne peut pas être correctement analysée ou transformée en AST.
- `TokenInvalide` : Levée lorsqu'un jeton (token) inattendu ou invalide est rencontré dans l'analyse syntaxique.
- `IncompatibiliteDeType` : Levée lorsqu'il y a une incompatibilité de types dans les expressions ou affectations.

La structure du Abstract Syntax Tree (AST) est définie comme suit :

- `Mot` : Représente un mot ou une variable dans le code FranC.
- `Nombre` : Représente un nombre littéral.
- `Phrase` : Une suite d'éléments AST formant une phrase.
- `Plus`, `Egal`, `Fois`, `Modulo`, `Assigne`, `Afficher` : Représentent respectivement les opérations d'addition, égalité, multiplication, modulo, assignation et affichage.
- `Paragraphe` : Un ensemble d'instructions ou d'expressions.
- `Condition` : Représente une structure conditionnelle (if-else).
- `BoucleTantQue` : Représente une boucle while.
- `Different` : Représente une comparaison de non-égalité.
- `ForInclus` et `ForExclus` : Représentent des boucles for, avec des limites inclusives ou exclusives.

Les fonctions `print_mot_liste` et `contient_afficher` sont utilisées pour analyser et transformer le AST en code exécutable ou pour vérifier la présence d'éléments spécifiques dans le AST.

## À Vérifier

- [ ] Les erreurs de scope

## TODO

- [ ] Implémenter le typage haut niveau pour des structures de données complexes.
- [ ] Ajouter le support pour les chaînes de caractères et les opérations associées.
- [ ] Développer des fonctions intégrées pour les opérations courantes (mathématiques, chaînes, etc.).
- [ ] Améliorer le système d'erreur pour fournir des messages plus détaillés et des suggestions de correction.
- [ ] Optimiser le parseur pour une meilleure performance sur des scripts plus longs.
- [ ] Ajouter une fonctionnalité de vérification de type statique.
- [ ] Créer un système de modules ou de packages pour permettre la réutilisation du code.
- [ ] Ajouter la prise en charge des commentaires dans le code FranC.
- [ ] Étendre la documentation pour couvrir plus de cas d'utilisation et d'exemples.
- [ ] Implémenter une interface graphique pour faciliter l'écriture et le test de code en FranC.
