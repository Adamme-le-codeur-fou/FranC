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

let retourne_tests () =
  "Expressions", [
    test_case "Ecrire division"            `Quick test_ecrire_division;
    test_case "Ecrire operations combinees" `Quick test_ecrire_operations_combinees;
    test_case "Assignation avec types"     `Quick test_ecrire_assignation_types;
    test_case "Printf avec types"          `Quick test_ecrire_printf_types
  ]
