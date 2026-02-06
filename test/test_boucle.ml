open Alcotest
open FranC.Ast
open FranC.Boucles
open Capture_sortie

let test_ecrire_boucle_while () =
  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_boucle (fun portee _ -> portee) [] (Entier("1")) []
  in ()) in
  let expected = "while (1) {\n}\n" in
  (check string) "ecrire_boucle_while" expected resultat

let test_ecrire_for () =
  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_for (fun portee _ -> portee) [] "i" (Entier("0")) (Entier("10")) true []
  in ()) in
  let expected = "for (int i = 0; i <= 10; i++) {\n}\n" in
  (check string) "ecrire_for_inclus" expected resultat;

  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_for (fun portee _ -> portee) [] "j" (Entier("1")) (Entier("5")) false []
  in ()) in
  let expected_exclus = "for (int j = 1; j < 5; j++) {\n}\n" in
  (check string) "ecrire_for_exclus" expected_exclus resultat

let test_ecrire_condition () =
  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_condition (fun portee _ -> portee) [] (Entier("0")) [] (None)
  in ()) in
  let expected = "if (0) {\n}\n" in
  (check string) "ecrire_condition" expected resultat;

  let resultat = capture_sortie_avec(fun () ->
    let _ = ecrire_condition (fun portee _ -> portee) [] (Entier("1")) [] (Some [])
  in ()) in
  let expected = "if (1) {\n}\nelse {\n}\n" in
  (check string) "ecrire_condition_avec_else" expected resultat


let retourne_tests () =
  "Boucles", [
    test_case "Ecrire boucle while" `Quick test_ecrire_boucle_while;
    test_case "Ecrire boucle for"   `Quick test_ecrire_for;
    test_case "Ecrire condition"    `Quick test_ecrire_condition 
    ]
