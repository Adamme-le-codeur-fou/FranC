open Alcotest
open FranC.Ast

let arbre_vide = Paragraphe []

let rec supprimer_positions ast =
  match ast with
  | Localise (_, inner) -> supprimer_positions inner
  | Paragraphe l -> Paragraphe (List.map supprimer_positions l)
  | Condition (c, a, s) ->
    Condition (supprimer_positions c,
      List.map supprimer_positions a,
      Option.map (List.map supprimer_positions) s)
  | BoucleTantQue (c, corps) ->
    BoucleTantQue (supprimer_positions c, List.map supprimer_positions corps)
  | ForInclus (v, s, e, corps) ->
    ForInclus (v, supprimer_positions s, supprimer_positions e, List.map supprimer_positions corps)
  | ForExclus (v, s, e, corps) ->
    ForExclus (v, supprimer_positions s, supprimer_positions e, List.map supprimer_positions corps)
  | PourChaque (v, arr, corps) ->
    PourChaque (v, arr, List.map supprimer_positions corps)
  | Recette (n, args, t, corps) ->
    Recette (n, args, t, List.map supprimer_positions corps)
  | Afficher e -> Afficher (supprimer_positions e)
  | Assigne (m, e) -> Assigne (supprimer_positions m, supprimer_positions e)
  | other -> other

let construire_arbre chaine_caractere =
  let lexbuf = Lexing.from_string chaine_caractere in
  let arbre = FranC.Parser.main FranC.Lexer.decoupe lexbuf in
  supprimer_positions arbre

let test_arbre_vide () =
  let arbre = construire_arbre "" in
  (check bool) "arbre vide" true (arbre = arbre_vide)
  
let test_assignation () =
  let arbre = construire_arbre "X devient 0." in
  (check bool) "assignation simple" true (arbre = Paragraphe [Assigne (Mot "X", Entier("0")) ])

let test_mot () =
  let arbre = construire_arbre "Mot'Valide devient 0." in
  (check bool) "mot valide" true (arbre = Paragraphe [Assigne (Mot "Mot'Valide", Entier("0")) ]);
  let arbre = try construire_arbre "Mot_invalide devient 0." with _ -> arbre_vide in
  (check bool) "mot invalide underscore" true (arbre = arbre_vide);
  let arbre = try construire_arbre "MotInvalide devient 0." with _ -> arbre_vide in
  (check bool) "mot invalide majuscule" true (arbre = arbre_vide)

let contient_sous_chaine chaine sous_chaine =
  let len_c = String.length chaine in
  let len_s = String.length sous_chaine in
  if len_s > len_c then false
  else
    let rec aux i =
      if i > len_c - len_s then false
      else if String.sub chaine i len_s = sous_chaine then true
      else aux (i + 1)
    in aux 0

let test_erreur_lexer () =
  let leve_erreur_lexer = try let _ = construire_arbre "X devient a _ b." in false
    with FranC.Erreurs.Erreur_lexer _ -> true | _ -> false in
  (check bool) "caractere inconnu leve Erreur_lexer" true leve_erreur_lexer;
  let message = try let _ = construire_arbre "X devient a _ b." in ""
    with FranC.Erreurs.Erreur_lexer msg -> msg | _ -> "" in
  (check bool) "message contient position" true (contient_sous_chaine message "ligne")

let test_erreur_syntaxe () =
  let leve_erreur_syntaxe = try let _ = construire_arbre "X devient." in false
    with Parsing.Parse_error -> true | _ -> false in
  (check bool) "syntaxe invalide leve Parse_error" true leve_erreur_syntaxe

let test_division () =
  let arbre = construire_arbre "X devient 10 divisé par 2." in
  (check bool) "division simple" true (arbre = Paragraphe [Assigne (Mot "X", Division(Entier("10"), Entier("2"))) ]);
  let arbre = construire_arbre "X devient 10 divise par 2." in
  (check bool) "division sans accent" true (arbre = Paragraphe [Assigne (Mot "X", Division(Entier("10"), Entier("2"))) ])

let test_tableau () =
  let arbre = construire_arbre "X devient un tableau contenant 1, 2 et 3." in
  (check bool) "tableau litteral" true
    (arbre = Paragraphe [Assigne (Mot "X", Tableau [Entier("1"); Entier("2"); Entier("3")])])

let test_acces_tableau () =
  let arbre = construire_arbre "Afficher l'element 0 de nombres." in
  (check bool) "acces tableau" true
    (arbre = Paragraphe [Afficher (AccesTableau ("nombres", Entier("0")))])

let test_taille_tableau () =
  let arbre = construire_arbre "Afficher la taille de nombres." in
  (check bool) "taille tableau" true
    (arbre = Paragraphe [Afficher (TailleTableau "nombres")])

let test_lire () =
  let arbre = construire_arbre "X devient 0. Lire x." in
  (check bool) "lire variable" true
    (arbre = Paragraphe [Assigne (Mot "X", Entier("0")); Lire "x"])

let test_negatif () =
  let arbre = construire_arbre "X devient -5." in
  (check bool) "negatif entier" true
    (arbre = Paragraphe [Assigne (Mot "X", Negatif(Entier("5")))]);
  let arbre = construire_arbre "X devient -3,14." in
  (check bool) "negatif reel" true
    (arbre = Paragraphe [Assigne (Mot "X", Negatif(Reel("3,14")))]);
  let arbre = construire_arbre "X devient 10 plus -3." in
  (check bool) "negatif dans expression" true
    (arbre = Paragraphe [Assigne (Mot "X", Plus(Entier("10"), Negatif(Entier("3"))))])

let test_chaine_formatee () =
  let arbre = construire_arbre "Afficher <Bonjour [nom]>." in
  (check bool) "chaine formatee simple" true
    (arbre = Paragraphe [Afficher (ChaineFormatee(["Bonjour "; ""], ["nom"]))]);
  let arbre = construire_arbre "Afficher <[x] plus [y] egale [z]>." in
  (check bool) "chaine formatee multiple" true
    (arbre = Paragraphe [Afficher (ChaineFormatee([""; " plus "; " egale "; ""], ["x"; "y"; "z"]))]);
  let arbre = construire_arbre "Afficher <Pas de variable>." in
  (check bool) "chaine sans interpolation" true
    (arbre = Paragraphe [Afficher (Chaine_caractere("Pas de variable"))])

let test_booleens () =
  let arbre = construire_arbre "X devient vrai." in
  (check bool) "vrai" true (arbre = Paragraphe [Assigne (Mot "X", Vrai)]);
  let arbre = construire_arbre "X devient faux." in
  (check bool) "faux" true (arbre = Paragraphe [Assigne (Mot "X", Faux)])

let test_associativite () =
  let arbre = construire_arbre "X devient 10 moins 3 moins 2." in
  (check bool) "associativite moins" true
    (arbre = Paragraphe [Assigne (Mot "X", Moins(Moins(Entier "10", Entier "3"), Entier "2"))]);
  let arbre = construire_arbre "X devient 2 fois 3 fois 4." in
  (check bool) "associativite fois" true
    (arbre = Paragraphe [Assigne (Mot "X", Fois(Fois(Entier "2", Entier "3"), Entier "4"))])

let test_pour_chaque () =
  let arbre = construire_arbre "Pour chaque element de nombres on agit selon la séquence suivante :\n  Afficher element.\nCe qui termine la séquence." in
  (check bool) "pour chaque" true
    (arbre = Paragraphe [PourChaque ("element", "nombres", [Afficher (Mot "element")])])

let test_procedure () =
  let arbre = construire_arbre "On définit une recette nommée saluer :\n  Afficher <Bonjour>.\nFin de la recette." in
  (check bool) "procedure sans args" true
    (arbre = Paragraphe [Recette ("saluer", [], TypeNeant, [Afficher (Chaine_caractere "Bonjour")])])

let test_procedure_avec_ingredients () =
  let arbre = construire_arbre "On définit une recette nommée doubler dont les ingrédients sont :\n- un entier n\n:\n  Afficher n.\nFin de la recette." in
  (check bool) "procedure avec args" true
    (arbre = Paragraphe [Recette ("doubler", [("n", TypeEntier)], TypeNeant, [Afficher (Mot "n")])])

let test_executer () =
  let arbre = construire_arbre "Exécuter saluer." in
  (check bool) "executer sans args" true
    (arbre = Paragraphe [Appel_recette ("saluer", [])]);
  let arbre = construire_arbre "Exécuter doubler avec l'ingrédient 5." in
  (check bool) "executer avec un ingredient" true
    (arbre = Paragraphe [Appel_recette ("doubler", [Entier "5"])])

let retourne_tests () =
      "Parser", [
        test_case "Arbre vide" `Quick test_arbre_vide;
        test_case "Assignation" `Quick test_assignation;
        test_case "Mot" `Quick test_mot;
        test_case "Division" `Quick test_division;
        test_case "Erreur lexer" `Quick test_erreur_lexer;
        test_case "Erreur syntaxe" `Quick test_erreur_syntaxe;
        test_case "Tableau" `Quick test_tableau;
        test_case "Acces tableau" `Quick test_acces_tableau;
        test_case "Taille tableau" `Quick test_taille_tableau;
        test_case "Lire" `Quick test_lire;
        test_case "Negatif" `Quick test_negatif;
        test_case "Chaine formatee" `Quick test_chaine_formatee;
        test_case "Booleens" `Quick test_booleens;
        test_case "Associativite" `Quick test_associativite;
        test_case "Pour chaque" `Quick test_pour_chaque;
        test_case "Procedure" `Quick test_procedure;
        test_case "Procedure avec ingredients" `Quick test_procedure_avec_ingredients;
        test_case "Executer" `Quick test_executer
      ]
