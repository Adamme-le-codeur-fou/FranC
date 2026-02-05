open Alcotest

let () =
  run "Tous les tests" [
      Test_portee.retourne_tests ();
      Test_types.retourne_tests ();
    ]