let lexbuf = Lexing.from_channel (open_in Sys.argv.(1))

let _ =
  if Array.length Sys.argv <= 2 then
    begin
      Printf.eprintf "Usage: %s <source .fr file> <output .c file>\n" Sys.argv.(0);
      exit 1
    end;
  let oc = open_out Sys.argv.(2) in
  let a = Parser.main Lexer.decoupe lexbuf in
  Ast.affiche a oc;
  close_out oc