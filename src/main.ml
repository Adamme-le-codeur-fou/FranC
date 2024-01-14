

let lexbuf = Lexing.from_channel stdin

let _ =
    let a = Parser.main (Lexer.decoupe) lexbuf
    in
    Ast.affiche a

  
  
(* let emitf x = Printf.ksprintf print_endline x
  
let rec emit = function
    | Main body ->
        emitf ".global _main";
        emitf "_main:";
        emit body;
        emitf "  ret"
    | Number n ->
        emitf "  mov rax, %d" n
    | Add (left, right) ->
        emit left;
        emitf "  push rax";
        emit right;
        emitf "  pop rbx";
        emitf "  add rax, rbx"
    | Mul (left, right) ->
        emit left;
        emitf "  push rax";
        emit right;
        emitf "  pop rbx";
        emitf "  mul rbx"
  
let () = 
    (* main() = 4 + 2 * 10 + 3 * (5 + 1) *)
    let term = 
      Main (
        Add (
          Number 4, 
          Add (
            Mul (Number 2, Number 10), 
            Mul (Number 3, Add (Number 5, Number 1))
          )
        )
      )
     in
     emit term *)