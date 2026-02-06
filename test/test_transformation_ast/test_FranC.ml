open Alcotest


let () =
  run "Transformation de l'ast" [
      Test_portee.retourne_tests ();
      Test_type.retourne_tests   ();
      Test_boucle.retourne_tests ()
  ]
