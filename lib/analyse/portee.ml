open Ast

type portee = (string * type_expression) list

let variable_est_declaree portee var_name =
  List.exists (fun (name, _) -> name = var_name) portee

let debug_portee portee type_vers_string =
  let string_list = List.map (fun (nom, t) -> Printf.sprintf "(%s,%s)" nom (type_vers_string t)) portee in
  Printf.printf "[%s]\n" (String.concat "; " string_list)