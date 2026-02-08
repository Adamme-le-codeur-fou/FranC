open Alcotest
open FranC.Ast
open FranC.Expressions
open FranC.Declarations
open Capture_sortie

let test_ecrire_division () =
  let resultat = capture_sortie_avec(fun () ->
    ecrire_expression [] (Division(Entier("10"), Entier("2")))
  ) in
  let expected = "(10 / 2)" in
  (check string) "division entiers" expected resultat;

  let resultat = capture_sortie_avec(fun () ->
    ecrire_expression [] (Division(Entier("10"), Entier("3")))
  ) in
  let expected = "(10 / 3)" in
  (check string) "division entiers non exacte" expected resultat;

  let resultat = capture_sortie_avec(fun () ->
    ecrire_expression [] (Division(Reel("3,0"), Entier("2")))
  ) in
  let expected = "(3.0 / 2)" in
  (check string) "division reel par entier" expected resultat

let test_ecrire_operations_combinees () =
  let resultat = capture_sortie_avec(fun () ->
    ecrire_expression [] (Plus(Division(Entier("10"), Entier("2")), Entier("1")))
  ) in
  let expected = "((10 / 2) + 1)" in
  (check string) "division dans addition" expected resultat

let test_ecrire_assignation_types () =
  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_assignation [] ("X", Reel("3,14")) in ()
  ) in
  (check string) "assignation reel" "float x = 3.14;\n" resultat;

  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_assignation [] ("X", Chaine_caractere("Bonjour")) in ()
  ) in
  (check string) "assignation chaine" "wchar_t *x = L\"Bonjour\";\n" resultat;

  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_assignation [] ("X", Entier("42")) in ()
  ) in
  (check string) "assignation entier" "int x = 42;\n" resultat

let test_ecrire_printf_types () =
  let portee = [("x", TypeReel)] in
  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_printf portee (Mot "x") in ()
  ) in
  (check string) "printf reel" "wprintf(L\"%f\\n\", x);\n" resultat;

  let portee = [("x", TypeEntier)] in
  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_printf portee (Mot "x") in ()
  ) in
  (check string) "printf entier" "wprintf(L\"%d\\n\", x);\n" resultat

let test_ecrire_acces_tableau () =
  let portee = [("nombres", TypeTableau TypeEntier)] in
  let resultat = capture_sortie_avec(fun () ->
    ecrire_expression portee (AccesTableau("nombres", Entier("0")))
  ) in
  (check string) "acces tableau" "((int*)nombres->donnees)[0]" resultat

let test_ecrire_taille_tableau () =
  let portee = [("nombres", TypeTableau TypeEntier)] in
  let resultat = capture_sortie_avec(fun () ->
    ecrire_expression portee (TailleTableau "nombres")
  ) in
  (check string) "taille tableau" "nombres->taille" resultat

let test_ecrire_negatif () =
  let resultat = capture_sortie_avec(fun () ->
    ecrire_expression [] (Negatif(Entier("5")))
  ) in
  (check string) "negatif entier" "(-5)" resultat;

  let resultat = capture_sortie_avec(fun () ->
    ecrire_expression [] (Plus(Entier("10"), Negatif(Entier("3"))))
  ) in
  (check string) "negatif dans addition" "(10 + (-3))" resultat

let test_ecrire_booleens () =
  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_assignation [] ("X", Vrai) in ()
  ) in
  (check string) "assignation vrai" "int x = 1;\n" resultat;

  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_assignation [] ("X", Faux) in ()
  ) in
  (check string) "assignation faux" "int x = 0;\n" resultat

let test_ecrire_printf_formate () =
  let portee = [("x", TypeEntier)] in
  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_printf portee (ChaineFormatee(["Valeur : "; ""], ["x"])) in ()
  ) in
  (check string) "printf formate entier" "wprintf(L\"Valeur : %d\\n\", x);\n" resultat;

  let portee = [("nom", TypeChaineCaractere); ("age", TypeEntier)] in
  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_printf portee (ChaineFormatee(["Bonjour "; ", vous avez "; " ans"], ["nom"; "age"])) in ()
  ) in
  (check string) "printf formate multiple" "wprintf(L\"Bonjour %ls, vous avez %d ans\\n\", nom, age);\n" resultat

let test_ecrire_lire () =
  let portee = [("x", TypeEntier)] in
  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_lire portee "x" in ()
  ) in
  (check string) "lire entier" "wscanf(L\"%d\", &x);\n" resultat;

  let portee = [("y", TypeReel)] in
  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_lire portee "y" in ()
  ) in
  (check string) "lire reel" "wscanf(L\"%f\", &y);\n" resultat

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

let test_erreur_variable_non_declaree () =
  let leve_erreur = try
    let _ = ecrire_expression [] (Mot "x") in false
  with FranC.Erreurs.Erreur_type msg ->
    contient_sous_chaine msg "x"
  | _ -> false in
  (check bool) "variable non declaree contient nom" true leve_erreur

let test_erreur_type_reassignation () =
  let leve_erreur = try
    let _ = ecrire_assignation [("x", TypeEntier)] ("X", Reel("3,14")) in false
  with FranC.Erreurs.Erreur_type msg ->
    contient_sous_chaine msg "entier" && contient_sous_chaine msg "réel"
  | _ -> false in
  (check bool) "reassignation type contient les types" true leve_erreur

let test_ecrire_racine () =
  let resultat = capture_sortie_avec(fun () ->
    ecrire_expression [] (RacineCarre(Entier("25")))
  ) in
  (check string) "racine" "sqrt(25)" resultat

let test_ecrire_puissance () =
  let resultat = capture_sortie_avec(fun () ->
    ecrire_expression [] (Puissance(Entier("2"), Entier("3")))
  ) in
  (check string) "puissance" "pow(2, 3)" resultat

let test_ecrire_valeur_absolue () =
  let resultat = capture_sortie_avec(fun () ->
    ecrire_expression [] (ValeurAbsolue(Negatif(Entier("5"))))
  ) in
  (check string) "valeur absolue entier" "abs((-5))" resultat;

  let portee = [("x", TypeReel)] in
  let resultat = capture_sortie_avec(fun () ->
    ecrire_expression portee (ValeurAbsolue(Mot("x")))
  ) in
  (check string) "valeur absolue reel" "fabs(x)" resultat

let test_ecrire_aleatoire () =
  let resultat = capture_sortie_avec(fun () ->
    ecrire_expression [] (Aleatoire(Entier("1"), Entier("10")))
  ) in
  (check string) "aleatoire" "((rand() % (10 - 1 + 1)) + 1)" resultat

let retourne_tests () =
  "Expressions", [
    test_case "Ecrire division"            `Quick test_ecrire_division;
    test_case "Ecrire operations combinees" `Quick test_ecrire_operations_combinees;
    test_case "Assignation avec types"     `Quick test_ecrire_assignation_types;
    test_case "Printf avec types"          `Quick test_ecrire_printf_types;
    test_case "Acces tableau"              `Quick test_ecrire_acces_tableau;
    test_case "Taille tableau"             `Quick test_ecrire_taille_tableau;
    test_case "Negatif"                    `Quick test_ecrire_negatif;
    test_case "Booleens"                   `Quick test_ecrire_booleens;
    test_case "Printf formate"            `Quick test_ecrire_printf_formate;
    test_case "Lire"                       `Quick test_ecrire_lire;
    test_case "Erreur variable non declaree" `Quick test_erreur_variable_non_declaree;
    test_case "Erreur type reassignation"    `Quick test_erreur_type_reassignation;
    test_case "Racine"                       `Quick test_ecrire_racine;
    test_case "Puissance"                    `Quick test_ecrire_puissance;
    test_case "Valeur absolue"               `Quick test_ecrire_valeur_absolue;
    test_case "Aleatoire"                    `Quick test_ecrire_aleatoire
  ]
