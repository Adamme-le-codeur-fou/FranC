open Ast

let type_llvm = function
  | TypeEntier | TypeBooleen -> "i32"
  | TypeReel -> "double"
  | TypeChaineCaractere -> "i8*"
  | TypeNeant -> "void"
  | TypeTableau _ -> "%Tableau*"

let sizeof_llvm = function
  | "i32" -> 4
  | "double" -> 8
  | _ -> 8

let llvm_vers_type = function
  | "i32" -> TypeEntier
  | "double" -> TypeReel
  | "i8*" -> TypeChaineCaractere
  | _ -> TypeEntier
