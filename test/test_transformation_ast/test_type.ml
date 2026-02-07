open Alcotest
open FranC.Ast
open FranC.Types

let test_type_de_variable_vers_string () =
  let portee = [("x", TypeEntier); ("y", TypeReel); ("z", TypeChaineCaractere)] in
  (check string) "type de x" "int "      (type_de_variable_vers_string portee "x");
  (check string) "type de y" "float "    (type_de_variable_vers_string portee "y");
  (check string) "type de z" "wchar_t *" (type_de_variable_vers_string portee "z")

let test_inference_type_expression () =
  let portee = [("x", TypeEntier); ("y", TypeReel)] in
  (check string) "entier litteral" "int " (type_vers_string (type_de_expression portee (Entier "5")));
  (check string) "reel litteral" "float " (type_vers_string (type_de_expression portee (Reel "3,14")));
  (check string) "chaine litterale" "wchar_t *" (type_vers_string (type_de_expression portee (Chaine_caractere "hello")));
  (check string) "variable entiere" "int " (type_vers_string (type_de_expression portee (Mot "x")));
  (check string) "variable reelle" "float " (type_vers_string (type_de_expression portee (Mot "y")));
  (check string) "entier plus entier" "int " (type_vers_string (type_de_expression portee (Plus (Entier "1", Entier "2"))));
  (check string) "entier plus reel" "float " (type_vers_string (type_de_expression portee (Plus (Entier "1", Reel "2,0"))));
  (check string) "comparaison" "int " (type_vers_string (type_de_expression portee (Egal (Entier "1", Entier "2"))))

let retourne_tests () =
  "Types", [
    test_case "Conversion type vers string" `Quick test_type_de_variable_vers_string;
    test_case "Inference de type" `Quick test_inference_type_expression
  ]