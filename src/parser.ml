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
  | Compris
  | Non_compris
  | Termine_sequence
  | Agir
  | Incrementer
  | De
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
# 41 "src/parser.ml"
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
  277 (* Compris *);
  278 (* Non_compris *);
  279 (* Termine_sequence *);
  280 (* Agir *);
  281 (* Incrementer *);
  282 (* De *);
    0 (* EOF *);
  283 (* Tabulation *);
    0|]

let yytransl_block = [|
  284 (* Mot *);
  285 (* Mot_majuscule *);
  286 (* Ponctuation_fin_phrase *);
  287 (* Entier *);
  288 (* Reel *);
    0|]

let yylhs = "\255\255\
\001\000\003\000\004\000\004\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\005\000\005\000\006\000\006\000\007\000\
\008\000\008\000\008\000\009\000\009\000\009\000\009\000\009\000\
\009\000\002\000\002\000\000\000"

let yylen = "\002\000\
\002\000\001\000\004\000\003\000\003\000\003\000\003\000\003\000\
\001\000\001\000\001\000\004\000\003\000\006\000\008\000\006\000\
\011\000\011\000\010\000\001\000\001\000\001\000\001\000\003\000\
\005\000\002\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\
\028\000\000\000\000\000\020\000\021\000\022\000\023\000\000\000\
\000\000\000\000\011\000\009\000\010\000\000\000\000\000\000\000\
\000\000\000\000\001\000\000\000\026\000\000\000\000\000\000\000\
\000\000\000\000\000\000\013\000\000\000\000\000\000\000\000\000\
\024\000\000\000\004\000\000\000\000\000\000\000\006\000\000\000\
\000\000\000\000\000\000\000\000\012\000\000\000\000\000\000\000\
\000\000\000\000\025\000\000\000\014\000\016\000\000\000\000\000\
\000\000\000\000\000\000\015\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\019\000\017\000\018\000"

let yydgoto = "\002\000\
\009\000\010\000\011\000\022\000\012\000\013\000\014\000\015\000\
\016\000"

let yysindex = "\004\000\
\011\255\000\000\083\255\083\255\083\255\245\254\247\254\000\000\
\000\000\023\000\024\255\000\000\000\000\000\000\000\000\011\255\
\083\255\083\255\000\000\000\000\000\000\004\255\155\255\163\255\
\008\255\244\254\000\000\083\255\000\000\144\255\140\255\083\255\
\083\255\083\255\083\255\000\000\011\255\011\255\083\255\083\255\
\000\000\064\255\000\000\083\255\030\255\001\255\000\000\001\255\
\000\255\015\255\104\255\070\255\000\000\030\255\011\255\013\255\
\014\255\083\255\000\000\029\255\000\000\000\000\133\255\017\255\
\025\255\031\255\011\255\000\000\011\255\011\255\034\255\036\255\
\037\255\035\255\041\255\047\255\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\001\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\075\255\096\255\000\000\111\255\
\000\000\000\000\000\000\000\000\000\000\042\255\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\240\255\000\000\254\255\000\000\000\000\000\000\000\000\
\000\000"

let yytablesize = 280
let yytable = "\029\000\
\027\000\023\000\024\000\032\000\001\000\034\000\032\000\033\000\
\034\000\035\000\055\000\056\000\003\000\040\000\030\000\031\000\
\025\000\041\000\026\000\004\000\049\000\050\000\027\000\005\000\
\028\000\042\000\039\000\006\000\057\000\045\000\046\000\047\000\
\048\000\036\000\034\000\007\000\051\000\052\000\060\000\008\000\
\064\000\054\000\061\000\062\000\003\000\003\000\068\000\003\000\
\069\000\003\000\071\000\003\000\072\000\073\000\070\000\063\000\
\074\000\003\000\075\000\076\000\000\000\003\000\003\000\003\000\
\077\000\003\000\032\000\033\000\034\000\035\000\078\000\003\000\
\032\000\033\000\034\000\035\000\079\000\000\000\005\000\000\000\
\005\000\000\000\005\000\000\000\005\000\000\000\000\000\000\000\
\000\000\017\000\005\000\000\000\000\000\053\000\005\000\005\000\
\005\000\018\000\005\000\059\000\000\000\000\000\000\000\007\000\
\005\000\007\000\032\000\033\000\034\000\035\000\019\000\007\000\
\000\000\020\000\021\000\007\000\007\000\007\000\008\000\007\000\
\008\000\000\000\000\000\058\000\000\000\007\000\008\000\000\000\
\000\000\000\000\008\000\008\000\008\000\000\000\008\000\032\000\
\033\000\034\000\035\000\000\000\008\000\000\000\032\000\033\000\
\034\000\035\000\032\000\033\000\034\000\035\000\000\000\043\000\
\000\000\065\000\066\000\044\000\067\000\032\000\033\000\034\000\
\035\000\000\000\000\000\000\000\037\000\032\000\033\000\034\000\
\035\000\000\000\000\000\000\000\038\000\000\000\000\000\000\000\
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
\000\000\000\000\000\000\027\000\027\000\000\000\027\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\027\000"

let yycheck = "\016\000\
\000\000\004\000\005\000\003\001\001\000\005\001\003\001\004\001\
\005\001\006\001\011\001\012\001\002\001\026\001\017\000\018\000\
\028\001\030\001\028\001\009\001\037\000\038\000\000\000\013\001\
\001\001\028\000\019\001\017\001\014\001\032\000\033\000\034\000\
\035\000\030\001\005\001\025\001\039\000\040\000\055\000\029\001\
\012\001\044\000\030\001\030\001\003\001\004\001\030\001\006\001\
\024\001\008\001\067\000\010\001\069\000\070\000\024\001\058\000\
\023\001\016\001\023\001\023\001\255\255\020\001\021\001\022\001\
\030\001\024\001\003\001\004\001\005\001\006\001\030\001\030\001\
\003\001\004\001\005\001\006\001\030\001\255\255\004\001\255\255\
\006\001\255\255\008\001\255\255\010\001\255\255\255\255\255\255\
\255\255\007\001\016\001\255\255\255\255\030\001\020\001\021\001\
\022\001\015\001\024\001\030\001\255\255\255\255\255\255\008\001\
\030\001\010\001\003\001\004\001\005\001\006\001\028\001\016\001\
\255\255\031\001\032\001\020\001\021\001\022\001\008\001\024\001\
\010\001\255\255\255\255\020\001\255\255\030\001\016\001\255\255\
\255\255\255\255\020\001\021\001\022\001\255\255\024\001\003\001\
\004\001\005\001\006\001\255\255\030\001\255\255\003\001\004\001\
\005\001\006\001\003\001\004\001\005\001\006\001\255\255\008\001\
\255\255\021\001\022\001\016\001\024\001\003\001\004\001\005\001\
\006\001\255\255\255\255\255\255\010\001\003\001\004\001\005\001\
\006\001\255\255\255\255\255\255\010\001\255\255\255\255\255\255\
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
  Compris\000\
  Non_compris\000\
  Termine_sequence\000\
  Agir\000\
  Incrementer\000\
  De\000\
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
# 30 "src/parser.mly"
                     ( Paragraphe(_1) )
# 258 "src/parser.ml"
               : Ast.ast))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 38 "src/parser.mly"
                       ( Mot(_1) )
# 265 "src/parser.ml"
               : 'maj_mot))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 43 "src/parser.mly"
                                                                 ( Modulo(_2, _4) )
# 273 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    Obj.repr(
# 44 "src/parser.mly"
                                                     ( _2 )
# 280 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 45 "src/parser.mly"
                                 ( Plus(_1, _3) )
# 288 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 46 "src/parser.mly"
                                 ( Fois(_1, _3) )
# 296 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 47 "src/parser.mly"
                                 ( Egal(_1, _3) )
# 304 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 48 "src/parser.mly"
                                      ( Different(_1, _3) )
# 312 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 49 "src/parser.mly"
             ( Entier(_1) )
# 319 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 50 "src/parser.mly"
           ( Reel(_1) )
# 326 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 51 "src/parser.mly"
          ( Mot(_1) )
# 333 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'maj_mot) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 54 "src/parser.mly"
                                                        ( Assigne(_1, _3) )
# 342 "src/parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 55 "src/parser.mly"
                                                 ( Afficher(_2) )
# 350 "src/parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 58 "src/parser.mly"
                                                                        ( Condition(_2, _4, None) )
# 359 "src/parser.ml"
               : 'conditionnelle))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'paragraphe) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 59 "src/parser.mly"
                                                                                         ( Condition(_2, _4, Some _6) )
# 369 "src/parser.ml"
               : 'conditionnelle))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 61 "src/parser.mly"
                                                                                          ( BoucleTantQue(_2, _4) )
# 378 "src/parser.ml"
               : 'boucle_tant_que))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 9 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 7 : 'expression) in
    let _6 = (Parsing.peek_val __caml_parser_env 5 : 'expression) in
    let _9 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _11 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 65 "src/parser.mly"
        ( ForInclus(_2, _4, _6, _9) )
# 389 "src/parser.ml"
               : 'boucle_pour))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 9 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 7 : 'expression) in
    let _6 = (Parsing.peek_val __caml_parser_env 5 : 'expression) in
    let _9 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _11 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 67 "src/parser.mly"
        ( ForExclus(_2, _4, _6, _9) )
# 400 "src/parser.ml"
               : 'boucle_pour))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 8 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 6 : 'expression) in
    let _6 = (Parsing.peek_val __caml_parser_env 4 : 'expression) in
    let _8 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _10 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 69 "src/parser.mly"
        ( ForExclus(_2, _4, _6, _8) )
# 411 "src/parser.ml"
               : 'boucle_pour))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'declaration) in
    Obj.repr(
# 72 "src/parser.mly"
                ( _1 )
# 418 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'conditionnelle) in
    Obj.repr(
# 73 "src/parser.mly"
                   ( _1 )
# 425 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boucle_tant_que) in
    Obj.repr(
# 74 "src/parser.mly"
                    ( _1 )
# 432 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boucle_pour) in
    Obj.repr(
# 75 "src/parser.mly"
                ( _1 )
# 439 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 76 "src/parser.mly"
                                           ( Increment(_2, None) )
# 447 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 77 "src/parser.mly"
                                                         ( Increment(_2, Some _4) )
# 456 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instruction) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'paragraphe) in
    Obj.repr(
# 80 "src/parser.mly"
                             ( _1 :: _2 )
# 464 "src/parser.ml"
               : 'paragraphe))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instruction) in
    Obj.repr(
# 81 "src/parser.mly"
                  ( [_1] )
# 471 "src/parser.ml"
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
