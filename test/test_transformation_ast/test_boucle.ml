open Alcotest
open FranC.Ast
open FranC.Boucles
open FranC.Declarations
open Capture_sortie

let ecrire_ast_mock portee ast =
  match ast with
  | Assigne (Mot m, expr) -> ecrire_assignation portee (m, expr)
  | _ -> portee

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

let test_condition_portee_symetrique () =
  let (_, portee) = capture_sortie_avec_retour(fun () ->
    ecrire_condition ecrire_ast_mock []
      (Entier("1"))
      [Assigne (Mot "Y", Entier("1"))]
      (Some [Assigne (Mot "Z", Entier("2"))])
  ) in
  (check bool) "alors ne fuit pas" false
    (FranC.Portee.variable_est_declaree portee "y");
  (check bool) "sinon ne fuit pas" false
    (FranC.Portee.variable_est_declaree portee "z")

let test_block_scoping_while () =
  let (_, portee) = capture_sortie_avec_retour(fun () ->
    ecrire_boucle ecrire_ast_mock []
      (Entier("1"))
      [Assigne (Mot "X", Entier("42"))]
  ) in
  (check bool) "while variable ne fuit pas" false
    (FranC.Portee.variable_est_declaree portee "x")

let test_block_scoping_for () =
  let (_, portee) = capture_sortie_avec_retour(fun () ->
    ecrire_for ecrire_ast_mock [] "i" (Entier("0")) (Entier("10")) true
      [Assigne (Mot "X", Entier("42"))]
  ) in
  (check bool) "for compteur ne fuit pas" false
    (FranC.Portee.variable_est_declaree portee "i");
  (check bool) "for variable ne fuit pas" false
    (FranC.Portee.variable_est_declaree portee "x")

let test_reassignation_type_incompatible () =
  let leve_erreur = try
    let portee = [("x", TypeEntier)] in
    let _ = capture_sortie_avec(fun () ->
      let _ = ecrire_assignation portee ("X", Reel("3,14")) in ()
    ) in false
  with FranC.Erreurs.Erreur_type _ -> true | _ -> false in
  (check bool) "reassignation type incompatible" true leve_erreur


let retourne_tests () =
  "Boucles", [
    test_case "Ecrire boucle while"               `Quick test_ecrire_boucle_while;
    test_case "Ecrire boucle for"                  `Quick test_ecrire_for;
    test_case "Ecrire condition"                   `Quick test_ecrire_condition;
    test_case "Condition portee symetrique"         `Quick test_condition_portee_symetrique;
    test_case "Block scoping while"                `Quick test_block_scoping_while;
    test_case "Block scoping for"                  `Quick test_block_scoping_for;
    test_case "Reassignation type incompatible"    `Quick test_reassignation_type_incompatible
  ]
