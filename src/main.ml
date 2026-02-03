open Ecrire
open Ast
open Expressions
open Boucles
open Declarations
open Types
open Fonctions

let lexbuf = Lexing.from_channel (open_in Sys.argv.(1))


let rec afficher_ast portee ast =
  match ast with
  | ForInclus (var, start_expr, end_expr, paragraphe) ->
    afficher_for afficher_ast portee var start_expr end_expr true paragraphe
  | ForExclus (var, start_expr, end_expr, paragraphe) ->
    afficher_for afficher_ast portee var start_expr end_expr false paragraphe
  | Paragraphe l -> List.fold_left afficher_ast portee l
  | Assigne (Mot m, e) -> afficher_assignation portee (m, e)
  | Afficher e ->
    afficher_printf portee e;
    portee
  | Condition (cond, alors_list, sinon_opt) ->
    afficher_condition afficher_ast portee cond alors_list sinon_opt
  | BoucleTantQue (cond, paragraphe) -> afficher_boucle afficher_ast portee cond paragraphe
  | Increment (var, None) ->
    ecrire "%s++;\n" (String.lowercase_ascii var);
    portee
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
  | _ ->
    afficher_expression portee ast;
    portee

let rec afficher_fonctions_pre_main ast =
  match ast with
  | Recette(nom, arguments, type_function, corps) -> afficher_function afficher_ast nom arguments type_function corps
  | Paragraphe l -> List.iter afficher_fonctions_pre_main l
  | _ -> ()


let affiche a channel =
  change_canal channel;
  ecrire "#include <stdio.h>\n#include <wchar.h>\n#include <locale.h>\n";
  afficher_fonctions_pre_main a;
  ecrire "\nint main(){\nsetlocale(LC_ALL, \"\");\n";
  let _ = afficher_ast [] a in
  ecrire "return 0;\n}"


let _ =
  if Array.length Sys.argv <= 2 then
    begin
      Printf.eprintf "Usage: %s <source .fr file> <output .c file>\n" Sys.argv.(0);
      exit 1
    end;
  let oc = open_out Sys.argv.(2) in
  let a = Parser.main Lexer.decoupe lexbuf in
  affiche a oc;
  close_out oc

