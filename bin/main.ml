open FranC.Ecrire
open FranC.Ast
open FranC.Expressions
open FranC.Boucles
open FranC.Declarations
open FranC.Prelude


let rec ecrire_ast portee ast =
  match ast with
  | ForInclus     (var, start_expr, end_expr, paragraphe) -> ecrire_for ecrire_ast portee var start_expr end_expr true paragraphe
  | ForExclus     (var, start_expr, end_expr, paragraphe) -> ecrire_for ecrire_ast portee var start_expr end_expr false paragraphe
  | Paragraphe    (liste)                                 -> List.fold_left ecrire_ast portee liste
  | Assigne       (Mot mot, expression)                   -> ecrire_assignation portee (mot, expression)
  | Afficher      (expression)                            -> ecrire_printf portee expression
  | Condition     (condition, alors_liste, sinon_OPTION)  -> ecrire_condition ecrire_ast portee condition alors_liste sinon_OPTION
  | BoucleTantQue (condition, paragraphe)                 -> ecrire_boucle ecrire_ast portee condition paragraphe
  | Increment     (variable, expression)                  -> ecrire_incrementer portee variable expression
  | Decrement     (variable, expression)                  -> ecrire_decrementer portee variable expression
  | Permuter      (variable1, variable2)                  -> ecrire_permuter portee variable1 variable2
  | Renvoyer      (expression)                            -> ecrire_renvoyer portee expression 
  | Recette(_)                                            -> portee
  | _                                                     -> ecrire_expression portee ast; portee

let affiche a channel nom_programme =
  change_canal channel;
  ecrire_debut ecrire_ast a nom_programme;
  let _ = ecrire_ast [] a in
  ecrire "return 0;\n}"

let affiche_usage_et_quitte_erreur () =
  Printf.eprintf "Usage: %s <source .fr file> <output .c file>\n" (Filename.basename Sys.argv.(0));
  exit 1

let verifie_arguments () =
  if Array.length Sys.argv <> 3 then affiche_usage_et_quitte_erreur ();
  if not (Filename.check_suffix Sys.argv.(1) ".fr") then
    begin
      Printf.eprintf "Le fichier source doit avoir l'extension .fr\n";
      affiche_usage_et_quitte_erreur ()
    end

let _ =
  verifie_arguments ();
  let lexbuf = Lexing.from_channel (open_in Sys.argv.(1)) in
  let nom_programme = Filename.basename Sys.argv.(1) in
  let canal_sortie = open_out Sys.argv.(2) in
  let arbre = FranC.Parser.main FranC.Lexer.decoupe lexbuf in
  affiche arbre canal_sortie nom_programme;
  close_out canal_sortie