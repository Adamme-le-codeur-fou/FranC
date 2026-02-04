open Alcotest
open FranC.Ast
open FranC.Portee

let test_variable_est_declaree () =
  let portee = [("x", TypeEntier); ("y", TypeReel)] in
  (check bool) "variable x declaree"     true  (variable_est_declaree portee "x");
  (check bool) "variable y declaree"     true  (variable_est_declaree portee "y");
  (check bool) "variable z non declaree" false (variable_est_declaree portee "z")

let () =
  run "All" [
      "Portee", [ test_case "Portee declaration" `Quick test_variable_est_declaree ];
    ]