open Alcotest
open FranC.Ast

let construire_arbre chaine_caractere =
  let lexbuf = Lexing.from_string chaine_caractere in
  FranC.Parser.main FranC.Lexer.decoupe lexbuf

let test_arbre_vide () =
  let arbre = construire_arbre "" in
  (check bool) "arbre vide" true (arbre = Paragraphe [])

let retourne_tests () =
      "Parser", [ 
        test_case "Arbre vide" `Quick test_arbre_vide
      ]
