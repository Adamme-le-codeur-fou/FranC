type token =
  | Assigne
  | Afficher
  | Plus
  | Egal
  | Fois
  | Different
  | Parenthese_Gauche
  | Parenthese_Droite
  | Si
  | Alors
  | Sinon
  | Fin_condition
  | Tant_que
  | Fin_boucle
  | Reste_division_euclidienne_debut
  | Par
  | Iterer
  | Sur
  | Allant_de
  | A
  | Compri
  | Non_compri
  | Termine_sequence
  | Agir
  | EOF
  | Tabulation
  | Mot of (string)
  | Mot_majuscule of (string)
  | Ponctuation_fin_phrase of (string)
  | Entier of (string)
  | Reel of (string)

open Parsing;;
let _ = parse_error;;
# 2 "src/parser.mly"
    open Ast
# 39 "src/parser.ml"
let yytransl_const = [|
  257 (* Assigne *);
  258 (* Afficher *);
  259 (* Plus *);
  260 (* Egal *);
  261 (* Fois *);
  262 (* Different *);
  263 (* Parenthese_Gauche *);
  264 (* Parenthese_Droite *);
  265 (* Si *);
  266 (* Alors *);
  267 (* Sinon *);
  268 (* Fin_condition *);
  269 (* Tant_que *);
  270 (* Fin_boucle *);
  271 (* Reste_division_euclidienne_debut *);
  272 (* Par *);
  273 (* Iterer *);
  274 (* Sur *);
  275 (* Allant_de *);
  276 (* A *);
  277 (* Compri *);
  278 (* Non_compri *);
  279 (* Termine_sequence *);
  280 (* Agir *);
    0 (* EOF *);
  281 (* Tabulation *);
    0|]

let yytransl_block = [|
  282 (* Mot *);
  283 (* Mot_majuscule *);
  284 (* Ponctuation_fin_phrase *);
  285 (* Entier *);
  286 (* Reel *);
    0|]

let yylhs = "\255\255\
\001\000\003\000\004\000\004\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\005\000\005\000\006\000\006\000\007\000\
\008\000\008\000\008\000\009\000\009\000\009\000\009\000\002\000\
\002\000\000\000"

let yylen = "\002\000\
\002\000\001\000\004\000\003\000\003\000\003\000\003\000\003\000\
\001\000\001\000\001\000\004\000\003\000\006\000\008\000\006\000\
\011\000\011\000\010\000\001\000\001\000\001\000\001\000\002\000\
\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\002\000\026\000\
\000\000\000\000\020\000\021\000\022\000\023\000\000\000\000\000\
\000\000\011\000\009\000\010\000\000\000\000\000\000\000\000\000\
\001\000\000\000\024\000\000\000\000\000\000\000\000\000\000\000\
\000\000\013\000\000\000\000\000\000\000\000\000\004\000\000\000\
\000\000\000\000\006\000\000\000\000\000\000\000\000\000\012\000\
\000\000\000\000\000\000\000\000\000\000\000\000\014\000\016\000\
\000\000\000\000\000\000\000\000\000\000\015\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\019\000\017\000\
\018\000"

let yydgoto = "\002\000\
\008\000\009\000\010\000\021\000\011\000\012\000\013\000\014\000\
\015\000"

let yysindex = "\255\255\
\056\255\000\000\070\255\070\255\070\255\242\254\000\000\000\000\
\016\000\020\255\000\000\000\000\000\000\000\000\056\255\070\255\
\070\255\000\000\000\000\000\000\004\255\106\255\146\255\003\255\
\000\000\070\255\000\000\154\255\102\255\070\255\070\255\070\255\
\070\255\000\000\056\255\056\255\070\255\014\255\000\000\070\255\
\018\255\008\255\000\000\008\255\249\254\011\255\075\255\000\000\
\018\255\056\255\005\255\006\255\070\255\024\255\000\000\000\000\
\098\255\009\255\015\255\016\255\056\255\000\000\056\255\056\255\
\022\255\026\255\030\255\019\255\029\255\031\255\000\000\000\000\
\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\001\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\066\255\105\255\000\000\120\255\000\000\000\000\000\000\000\000\
\040\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000"

let yygindex = "\000\000\
\000\000\247\255\000\000\254\255\000\000\000\000\000\000\000\000\
\000\000"

let yytablesize = 280
let yytable = "\001\000\
\025\000\022\000\023\000\050\000\051\000\027\000\030\000\031\000\
\032\000\033\000\030\000\024\000\032\000\028\000\029\000\025\000\
\030\000\031\000\032\000\033\000\026\000\037\000\032\000\038\000\
\052\000\045\000\046\000\041\000\042\000\043\000\044\000\034\000\
\055\000\056\000\047\000\058\000\062\000\049\000\063\000\064\000\
\054\000\048\000\003\000\003\000\068\000\003\000\071\000\003\000\
\069\000\003\000\057\000\065\000\070\000\066\000\067\000\003\000\
\072\000\003\000\073\000\003\000\003\000\003\000\000\000\003\000\
\004\000\000\000\000\000\003\000\005\000\005\000\000\000\005\000\
\006\000\005\000\000\000\005\000\016\000\030\000\031\000\032\000\
\033\000\005\000\007\000\000\000\017\000\005\000\005\000\005\000\
\000\000\005\000\000\000\000\000\000\000\005\000\053\000\018\000\
\000\000\000\000\019\000\020\000\030\000\031\000\032\000\033\000\
\030\000\031\000\032\000\033\000\030\000\031\000\032\000\033\000\
\007\000\000\000\007\000\035\000\000\000\040\000\059\000\060\000\
\007\000\061\000\000\000\000\000\007\000\007\000\007\000\008\000\
\007\000\008\000\000\000\000\000\007\000\000\000\000\000\008\000\
\000\000\000\000\000\000\008\000\008\000\008\000\000\000\008\000\
\000\000\000\000\000\000\008\000\030\000\031\000\032\000\033\000\
\000\000\000\000\000\000\036\000\030\000\031\000\032\000\033\000\
\000\000\039\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\025\000\025\000\000\000\025\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\025\000"

let yycheck = "\001\000\
\000\000\004\000\005\000\011\001\012\001\015\000\003\001\004\001\
\005\001\006\001\003\001\026\001\005\001\016\000\017\000\000\000\
\003\001\004\001\005\001\006\001\001\001\019\001\005\001\026\000\
\014\001\035\000\036\000\030\000\031\000\032\000\033\000\028\001\
\028\001\028\001\037\000\012\001\028\001\040\000\024\001\024\001\
\050\000\028\001\003\001\004\001\023\001\006\001\028\001\008\001\
\023\001\010\001\053\000\061\000\023\001\063\000\064\000\016\001\
\028\001\002\001\028\001\020\001\021\001\022\001\255\255\024\001\
\009\001\255\255\255\255\028\001\013\001\004\001\255\255\006\001\
\017\001\008\001\255\255\010\001\007\001\003\001\004\001\005\001\
\006\001\016\001\027\001\255\255\015\001\020\001\021\001\022\001\
\255\255\024\001\255\255\255\255\255\255\028\001\020\001\026\001\
\255\255\255\255\029\001\030\001\003\001\004\001\005\001\006\001\
\003\001\004\001\005\001\006\001\003\001\004\001\005\001\006\001\
\008\001\255\255\010\001\010\001\255\255\016\001\021\001\022\001\
\016\001\024\001\255\255\255\255\020\001\021\001\022\001\008\001\
\024\001\010\001\255\255\255\255\028\001\255\255\255\255\016\001\
\255\255\255\255\255\255\020\001\021\001\022\001\255\255\024\001\
\255\255\255\255\255\255\028\001\003\001\004\001\005\001\006\001\
\255\255\255\255\255\255\010\001\003\001\004\001\005\001\006\001\
\255\255\008\001\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\011\001\012\001\255\255\014\001\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\023\001"

let yynames_const = "\
  Assigne\000\
  Afficher\000\
  Plus\000\
  Egal\000\
  Fois\000\
  Different\000\
  Parenthese_Gauche\000\
  Parenthese_Droite\000\
  Si\000\
  Alors\000\
  Sinon\000\
  Fin_condition\000\
  Tant_que\000\
  Fin_boucle\000\
  Reste_division_euclidienne_debut\000\
  Par\000\
  Iterer\000\
  Sur\000\
  Allant_de\000\
  A\000\
  Compri\000\
  Non_compri\000\
  Termine_sequence\000\
  Agir\000\
  EOF\000\
  Tabulation\000\
  "

let yynames_block = "\
  Mot\000\
  Mot_majuscule\000\
  Ponctuation_fin_phrase\000\
  Entier\000\
  Reel\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'paragraphe) in
    Obj.repr(
# 29 "src/parser.mly"
                     ( Paragraphe(_1) )
# 252 "src/parser.ml"
               : Ast.ast))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 37 "src/parser.mly"
                       ( Mot(_1) )
# 259 "src/parser.ml"
               : 'maj_mot))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 42 "src/parser.mly"
                                                                 ( Modulo(_2, _4) )
# 267 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    Obj.repr(
# 43 "src/parser.mly"
                                                     ( _2 )
# 274 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 44 "src/parser.mly"
                                 ( Plus(_1, _3) )
# 282 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 45 "src/parser.mly"
                                 ( Fois(_1, _3) )
# 290 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 46 "src/parser.mly"
                                 ( Egal(_1, _3) )
# 298 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 47 "src/parser.mly"
                                      ( Different(_1, _3) )
# 306 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 48 "src/parser.mly"
             ( Entier(_1) )
# 313 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 49 "src/parser.mly"
           ( Reel(_1) )
# 320 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 50 "src/parser.mly"
          ( Mot(_1) )
# 327 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'maj_mot) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 53 "src/parser.mly"
                                                        ( Assigne(_1, _3) )
# 336 "src/parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 54 "src/parser.mly"
                                                 ( Afficher(_2) )
# 344 "src/parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 57 "src/parser.mly"
                                                                        ( Condition(_2, _4, None) )
# 353 "src/parser.ml"
               : 'conditionnelle))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'paragraphe) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 58 "src/parser.mly"
                                                                                         ( Condition(_2, _4, Some _6) )
# 363 "src/parser.ml"
               : 'conditionnelle))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 60 "src/parser.mly"
                                                                                          ( BoucleTantQue(_2, _4) )
# 372 "src/parser.ml"
               : 'boucle_tant_que))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 9 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 7 : 'expression) in
    let _6 = (Parsing.peek_val __caml_parser_env 5 : 'expression) in
    let _9 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _11 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 64 "src/parser.mly"
        ( ForInclus(_2, _4, _6, _9) )
# 383 "src/parser.ml"
               : 'boucle_pour))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 9 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 7 : 'expression) in
    let _6 = (Parsing.peek_val __caml_parser_env 5 : 'expression) in
    let _9 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _11 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 66 "src/parser.mly"
        ( ForExclus(_2, _4, _6, _9) )
# 394 "src/parser.ml"
               : 'boucle_pour))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 8 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 6 : 'expression) in
    let _6 = (Parsing.peek_val __caml_parser_env 4 : 'expression) in
    let _8 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _10 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 68 "src/parser.mly"
        ( ForExclus(_2, _4, _6, _8) )
# 405 "src/parser.ml"
               : 'boucle_pour))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'declaration) in
    Obj.repr(
# 72 "src/parser.mly"
                ( _1 )
# 412 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'conditionnelle) in
    Obj.repr(
# 73 "src/parser.mly"
                   ( _1 )
# 419 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boucle_tant_que) in
    Obj.repr(
# 74 "src/parser.mly"
                    ( _1 )
# 426 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boucle_pour) in
    Obj.repr(
# 75 "src/parser.mly"
                ( _1 )
# 433 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instruction) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'paragraphe) in
    Obj.repr(
# 78 "src/parser.mly"
                             ( _1 :: _2 )
# 441 "src/parser.ml"
               : 'paragraphe))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instruction) in
    Obj.repr(
# 79 "src/parser.mly"
                  ( [_1] )
# 448 "src/parser.ml"
               : 'paragraphe))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Ast.ast)
