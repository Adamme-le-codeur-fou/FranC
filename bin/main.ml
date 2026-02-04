open FranC.Ecrire
open FranC.Ast
open FranC.Expressions
open FranC.Boucles
open FranC.Declarations
open FranC.Types
open FranC.Prelude


let rec afficher_ast portee ast =
  match ast with
  | ForInclus (var, start_expr, end_expr, paragraphe) -> afficher_for afficher_ast portee var start_expr end_expr true paragraphe
  | ForExclus (var, start_expr, end_expr, paragraphe) -> afficher_for afficher_ast portee var start_expr end_expr false paragraphe
  | Paragraphe l -> List.fold_left afficher_ast portee l
  | Assigne (Mot m, e) -> afficher_assignation portee (m, e)
  | Afficher e -> afficher_printf portee e; portee
  | Condition (cond, alors_list, sinon_opt) -> afficher_condition afficher_ast portee cond alors_list sinon_opt
  | BoucleTantQue (cond, paragraphe) -> afficher_boucle afficher_ast portee cond paragraphe
  | Increment (var, None) -> ecrire "%s++;\n" (String.lowercase_ascii var); portee
  | Increment (var, Some expr) ->
    ecrire "%s += " (String.lowercase_ascii var);
    afficher_expression portee expr;
    ecrire ";\n";
    portee
  | Decrement (var, None) ->
    ecrire "%s--;\n" (String.lowercase_ascii var);
    portee
  | Decrement (var, Some expr) ->
    ecrire "%s -= " (String.lowercase_ascii var);
    afficher_expression portee expr;
    ecrire ";\n";
    portee
  | Permuter (var1, var2) ->
    let v1 = String.lowercase_ascii var1 in
    let v2 = String.lowercase_ascii var2 in
    let variable_temporaire = temporaire_suivant () in
    ecrire "%s %s = %s;\n" (type_vers_chaine_caractere (type_variable portee v1)) variable_temporaire v1;
    ecrire "%s = %s;\n" v1 v2;
    ecrire "%s = %s;\n" v2 variable_temporaire;
    portee
  | Renvoyer a -> 
    ecrire "return ";
    let _ = afficher_ast portee a in
    ecrire ";\n";
    portee
  | Recette(_) -> portee
  | _ -> afficher_expression portee ast; portee


let affiche a channel nom_programme =
  change_canal channel;
  ecrire_debut afficher_ast a nom_programme;
  let _ = afficher_ast [] a in
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

