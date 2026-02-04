open Ast

type portee = (string * type_expression) list

let variable_est_declaree portee var_name =
  List.exists (fun (name, _) -> name = var_name) portee