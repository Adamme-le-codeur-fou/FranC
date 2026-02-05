open Alcotest
open FranC.Ast
open FranC.Portee
open FranC.Types

let test_variable_est_declaree () =
  let portee = [("x", TypeEntier); ("y", TypeReel)] in
  (check bool) "variable x declaree"     true  (variable_est_declaree portee "x");
  (check bool) "variable y declaree"     true  (variable_est_declaree portee "y");
  (check bool) "variable z non declaree" false (variable_est_declaree portee "z")


let test_type_de_variable_vers_string () =
  let portee = [("x", TypeEntier); ("y", TypeReel); ("z", TypeChaineCaractere)] in
  (check string) "type de x" "int "      (type_de_variable_vers_string portee "x");
  (check string) "type de y" "float "    (type_de_variable_vers_string portee "y");
  (check string) "type de z" "wchar_t *" (type_de_variable_vers_string portee "z")

let test_verifier_type () =
  (check bool) "types compatibles" true (try verifier_type TypeEntier TypeEntier; true with IncompatibiliteDeType -> false);
  (check bool) "types incompatibles" true (try verifier_type TypeEntier TypeReel; false with IncompatibiliteDeType -> true)

let () =
  run "All" [
      "Portée", [ test_case "Portée declaration" `Quick test_variable_est_declaree ];
      "Types", [
        test_case "Conversion type vers string" `Quick test_type_de_variable_vers_string;
        test_case "Vérification de type"        `Quick test_verifier_type
        ];
    ]