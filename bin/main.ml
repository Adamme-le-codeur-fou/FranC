open FranC.Ecrire
open FranC.Ast
open FranC.Expressions
open FranC.Boucles
open FranC.Declarations
open FranC.Prelude

let position_courante = ref None

let formater_erreur_avec_position msg =
  match !position_courante with
  | Some pos -> FranC.Erreurs.formater_erreur (FranC.Erreurs.formater_position pos) msg
  | None -> Printf.sprintf "Erreur : %s" msg

let rec ecrire_ast portee ast =
  match ast with
  | Localise (pos, inner) ->
    position_courante := Some pos;
    ecrire_ast portee inner
  | ForInclus     (var, start_expr, end_expr, paragraphe) -> ecrire_for ecrire_ast portee var start_expr end_expr true paragraphe
  | ForExclus     (var, start_expr, end_expr, paragraphe) -> ecrire_for ecrire_ast portee var start_expr end_expr false paragraphe
  | PourChaque    (element, tableau, paragraphe)          -> ecrire_pour_chaque ecrire_ast portee element tableau paragraphe
  | Assigne       (Mot mot, expression)                   -> ecrire_assignation portee (mot, expression)
  | Afficher      (expression)                            -> ecrire_printf portee expression
  | Condition     (condition, alors_liste, sinon_OPTION)  -> ecrire_condition ecrire_ast portee condition alors_liste sinon_OPTION
  | BoucleTantQue (condition, paragraphe)                 -> ecrire_boucle ecrire_ast portee condition paragraphe
  | Increment     (variable, expression)                  -> ecrire_incrementer portee variable expression
  | Decrement     (variable, expression)                  -> ecrire_decrementer portee variable expression
  | Permuter      (variable1, variable2)                  -> ecrire_permuter portee variable1 variable2
  | Renvoyer      (expression)                            -> ecrire_renvoyer portee expression
  | ModificationTableau (nom, index, valeur)              -> ecrire_modification_tableau portee nom index valeur
  | AjouterTableau (nom, valeur)                          -> ecrire_ajouter_tableau portee nom valeur
  | Lire var                                               -> ecrire_lire portee var
  | Appel_recette (_, _)                                   -> ecrire_expression portee ast; ecrire ";\n"; portee
  | Paragraphe    (liste)                                 -> List.fold_left ecrire_ast portee liste
  | Recette(nom, _, type_retour, _)                        -> (nom, type_retour) :: portee
  | _                                                     -> ecrire_expression portee ast; portee

let affiche arbre canal_sortie nom_programme=
  change_canal canal_sortie;
  ecrire_debut ecrire_ast arbre nom_programme;
  let portee_finale = ecrire_ast [] arbre in
  ecrire_liberation_tableaux [] portee_finale;
  ecrire "return 0;\n}"

let affiche_usage_et_quitte_erreur () =
  Printf.eprintf "Utilisation : %s <fichier source .fr> <fichier de sortie .c ou .ll>\n" (Filename.basename Sys.argv.(0));
  exit 1

let verifie_arguments () =
  if Array.length Sys.argv <> 3 then affiche_usage_et_quitte_erreur ();
  if not (Filename.check_suffix Sys.argv.(1) ".fr") then begin
    Printf.eprintf "Le fichier source doit avoir l'extension .fr\n";
    affiche_usage_et_quitte_erreur ()
  end;
  if not (Filename.check_suffix Sys.argv.(2) ".c" || Filename.check_suffix Sys.argv.(2) ".ll") then begin
    Printf.eprintf "Le fichier de sortie doit avoir l'extension .c ou .ll\n";
    affiche_usage_et_quitte_erreur ()
  end

let _ =
  verifie_arguments ();
  let lexbuf = Lexing.from_channel (open_in Sys.argv.(1)) in
  let nom_programme = Filename.basename Sys.argv.(1) in
  let canal_sortie = open_out Sys.argv.(2) in
  let quitter_erreur msg =
    close_out canal_sortie;
    Printf.eprintf "%s\n" msg;
    exit 1
  in
  try
    let arbre = FranC.Parser.main FranC.Lexer.decoupe lexbuf in
    if Filename.check_suffix Sys.argv.(2) ".ll" then
      FranC.Llvm_programme.generer arbre canal_sortie nom_programme
    else
      affiche arbre canal_sortie nom_programme;
    close_out canal_sortie
  with
  | FranC.Erreurs.Erreur_lexer msg -> quitter_erreur msg
  | Parsing.Parse_error ->
    quitter_erreur (FranC.Erreurs.formater_erreur
      (FranC.Erreurs.formater_position lexbuf.Lexing.lex_curr_p)
      "phrase invalide, vérifiez la syntaxe de votre programme")
  | FranC.Types.VariableNonDeclaree var ->
    quitter_erreur (formater_erreur_avec_position
      (Printf.sprintf "la variable '%s' n'a pas été déclarée. Vérifiez qu'elle a bien été initialisée (exemple : %s devient ...)"
        var (String.capitalize_ascii var)))
  | FranC.Erreurs.Erreur_type msg -> quitter_erreur (formater_erreur_avec_position msg)
  | e -> quitter_erreur (formater_erreur_avec_position (Printf.sprintf "erreur inattendue : %s" (Printexc.to_string e)))
