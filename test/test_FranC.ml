open Alcotest

let () =
  run "Tous les tests" [
      Test_portee.retourne_tests ();
      Test_type.retourne_tests ();
    ]