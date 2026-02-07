open Alcotest
open FranC.Ast

let arbre_vide = Paragraphe []

let construire_arbre chaine_caractere =
  let lexbuf = Lexing.from_string chaine_caractere in
  FranC.Parser.main FranC.Lexer.decoupe lexbuf

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

let test_division () =
  let arbre = construire_arbre "X devient 10 divisé par 2." in
  (check bool) "division simple" true (arbre = Paragraphe [Assigne (Mot "X", Division(Entier("10"), Entier("2"))) ]);
  let arbre = construire_arbre "X devient 10 divise par 2." in
  (check bool) "division sans accent" true (arbre = Paragraphe [Assigne (Mot "X", Division(Entier("10"), Entier("2"))) ])

let retourne_tests () =
      "Parser", [
        test_case "Arbre vide" `Quick test_arbre_vide;
        test_case "Assignation" `Quick test_assignation;
        test_case "Mot" `Quick test_mot;
        test_case "Division" `Quick test_division
      ]
