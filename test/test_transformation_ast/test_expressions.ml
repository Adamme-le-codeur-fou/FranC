open Alcotest
open FranC.Ast
open FranC.Expressions
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

let retourne_tests () =
  "Expressions", [
    test_case "Ecrire division"            `Quick test_ecrire_division;
    test_case "Ecrire operations combinees" `Quick test_ecrire_operations_combinees
  ]
