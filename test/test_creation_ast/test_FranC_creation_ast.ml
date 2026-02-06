open Alcotest

let () =
  run "Creation de l'ast" [
      Test_parser.retourne_tests ()
  ]
