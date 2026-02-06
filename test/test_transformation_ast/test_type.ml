open Alcotest
open FranC.Ast
open FranC.Types

let test_type_de_variable_vers_string () =
  let portee = [("x", TypeEntier); ("y", TypeReel); ("z", TypeChaineCaractere)] in
  (check string) "type de x" "int "      (type_de_variable_vers_string portee "x");
  (check string) "type de y" "float "    (type_de_variable_vers_string portee "y");
  (check string) "type de z" "wchar_t *" (type_de_variable_vers_string portee "z")

let retourne_tests () =
  "Types", [ test_case "Conversion type vers string" `Quick test_type_de_variable_vers_string ]