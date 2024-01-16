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
  | Decrementer
  | Commence
  | Dedans
  | Attend
  | Proceder
  | Termine_fonction
  | Virgule
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
# 48 "src/parser.ml"
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
  283 (* Decrementer *);
  284 (* Commence *);
  285 (* Dedans *);
  286 (* Attend *);
  287 (* Proceder *);
  288 (* Termine_fonction *);
  289 (* Virgule *);
    0 (* EOF *);
  290 (* Tabulation *);
    0|]

let yytransl_block = [|
  291 (* Mot *);
  292 (* Mot_majuscule *);
  293 (* Ponctuation_fin_phrase *);
  294 (* Entier *);
  295 (* Reel *);
    0|]

let yylhs = "\255\255\
\001\000\003\000\004\000\004\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\005\000\005\000\006\000\006\000\007\000\
\008\000\008\000\008\000\009\000\009\000\009\000\009\000\009\000\
\009\000\009\000\009\000\009\000\002\000\002\000\011\000\011\000\
\010\000\000\000"

let yylen = "\002\000\
\002\000\001\000\004\000\003\000\003\000\003\000\003\000\003\000\
\001\000\001\000\001\000\004\000\003\000\006\000\008\000\006\000\
\011\000\011\000\010\000\001\000\001\000\001\000\001\000\001\000\
\003\000\005\000\003\000\005\000\002\000\001\000\003\000\001\000\
\010\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\002\000\034\000\000\000\000\000\020\000\022\000\023\000\
\024\000\000\000\021\000\000\000\000\000\011\000\009\000\010\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\001\000\
\000\000\029\000\000\000\000\000\000\000\000\000\000\000\000\000\
\013\000\000\000\000\000\000\000\000\000\025\000\000\000\027\000\
\000\000\000\000\004\000\000\000\000\000\000\000\006\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\012\000\000\000\
\000\000\000\000\000\000\000\000\026\000\028\000\000\000\000\000\
\000\000\014\000\016\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\031\000\000\000\015\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\019\000\
\033\000\017\000\018\000"

let yydgoto = "\002\000\
\011\000\012\000\013\000\025\000\014\000\015\000\016\000\017\000\
\018\000\019\000\072\000"

let yysindex = "\004\000\
\071\255\000\000\251\254\251\254\251\254\243\254\000\255\013\255\
\022\255\000\000\000\000\050\000\061\255\000\000\000\000\000\000\
\000\000\071\255\000\000\251\254\251\254\000\000\000\000\000\000\
\003\255\151\255\159\255\053\255\005\255\015\255\037\255\000\000\
\251\254\000\000\167\255\136\255\251\254\251\254\251\254\251\254\
\000\000\071\255\071\255\251\254\251\254\000\000\251\254\000\000\
\049\255\008\255\000\000\251\254\078\255\018\255\000\000\018\255\
\070\255\072\255\050\255\012\255\023\255\058\255\000\000\078\255\
\071\255\057\255\063\255\251\254\000\000\000\000\062\255\067\255\
\094\255\000\000\000\000\129\255\058\255\059\255\074\255\085\255\
\088\255\071\255\000\000\071\255\000\000\071\255\071\255\090\255\
\082\255\096\255\102\255\089\255\093\255\099\255\101\255\000\000\
\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\001\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\081\255\100\255\000\000\107\255\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\055\255\
\000\000\000\000\000\000\000\000\000\000\000\000\106\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\238\255\000\000\255\255\000\000\000\000\000\000\000\000\
\000\000\000\000\068\000"

let yytablesize = 289
let yytable = "\034\000\
\030\000\020\000\026\000\027\000\001\000\037\000\038\000\039\000\
\040\000\021\000\037\000\038\000\039\000\040\000\037\000\038\000\
\039\000\040\000\035\000\036\000\037\000\028\000\039\000\057\000\
\058\000\037\000\038\000\039\000\040\000\022\000\045\000\050\000\
\023\000\024\000\029\000\053\000\054\000\055\000\056\000\041\000\
\047\000\046\000\059\000\060\000\063\000\061\000\073\000\030\000\
\069\000\032\000\064\000\048\000\037\000\038\000\039\000\040\000\
\031\000\003\000\003\000\070\000\003\000\033\000\003\000\088\000\
\003\000\089\000\076\000\090\000\091\000\068\000\003\000\044\000\
\003\000\049\000\003\000\003\000\003\000\062\000\003\000\004\000\
\065\000\066\000\039\000\005\000\005\000\067\000\005\000\006\000\
\005\000\084\000\005\000\003\000\071\000\074\000\077\000\007\000\
\005\000\008\000\009\000\075\000\005\000\005\000\005\000\078\000\
\005\000\079\000\010\000\007\000\086\000\007\000\085\000\087\000\
\092\000\093\000\008\000\007\000\008\000\005\000\094\000\007\000\
\007\000\007\000\008\000\007\000\095\000\096\000\008\000\008\000\
\008\000\097\000\008\000\037\000\038\000\039\000\040\000\098\000\
\007\000\099\000\037\000\038\000\039\000\040\000\032\000\008\000\
\083\000\000\000\000\000\000\000\000\000\080\000\081\000\052\000\
\082\000\037\000\038\000\039\000\040\000\000\000\000\000\000\000\
\042\000\037\000\038\000\039\000\040\000\000\000\000\000\000\000\
\043\000\037\000\038\000\039\000\040\000\000\000\051\000\000\000\
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
\000\000\000\000\000\000\030\000\030\000\000\000\030\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\030\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\030\000"

let yycheck = "\018\000\
\000\000\007\001\004\000\005\000\001\000\003\001\004\001\005\001\
\006\001\015\001\003\001\004\001\005\001\006\001\003\001\004\001\
\005\001\006\001\020\000\021\000\003\001\035\001\005\001\042\000\
\043\000\003\001\004\001\005\001\006\001\035\001\026\001\033\000\
\038\001\039\001\035\001\037\000\038\000\039\000\040\000\037\001\
\026\001\037\001\044\000\045\000\037\001\047\000\065\000\035\001\
\037\001\000\000\052\000\037\001\003\001\004\001\005\001\006\001\
\035\001\003\001\004\001\037\001\006\001\001\001\008\001\082\000\
\010\001\084\000\068\000\086\000\087\000\020\001\016\001\019\001\
\002\001\037\001\020\001\021\001\022\001\029\001\024\001\009\001\
\011\001\012\001\005\001\013\001\004\001\014\001\006\001\017\001\
\008\001\031\001\010\001\037\001\035\001\037\001\033\001\025\001\
\016\001\027\001\028\001\037\001\020\001\021\001\022\001\037\001\
\024\001\012\001\036\001\008\001\024\001\010\001\037\001\024\001\
\023\001\032\001\008\001\016\001\010\001\037\001\023\001\020\001\
\021\001\022\001\016\001\024\001\023\001\037\001\020\001\021\001\
\022\001\037\001\024\001\003\001\004\001\005\001\006\001\037\001\
\037\001\037\001\003\001\004\001\005\001\006\001\037\001\037\001\
\077\000\255\255\255\255\255\255\255\255\021\001\022\001\016\001\
\024\001\003\001\004\001\005\001\006\001\255\255\255\255\255\255\
\010\001\003\001\004\001\005\001\006\001\255\255\255\255\255\255\
\010\001\003\001\004\001\005\001\006\001\255\255\008\001\255\255\
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
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\023\001\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\032\001"

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
  Decrementer\000\
  Commence\000\
  Dedans\000\
  Attend\000\
  Proceder\000\
  Termine_fonction\000\
  Virgule\000\
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
# 32 "src/parser.mly"
                     ( Paragraphe(_1) )
# 294 "src/parser.ml"
               : Ast.ast))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 39 "src/parser.mly"
                       ( Mot(_1) )
# 301 "src/parser.ml"
               : 'maj_mot))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 44 "src/parser.mly"
                                                                 ( Modulo(_2, _4) )
# 309 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    Obj.repr(
# 45 "src/parser.mly"
                                                     ( _2 )
# 316 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 46 "src/parser.mly"
                                 ( Plus(_1, _3) )
# 324 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 47 "src/parser.mly"
                                 ( Fois(_1, _3) )
# 332 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 48 "src/parser.mly"
                                 ( Egal(_1, _3) )
# 340 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 49 "src/parser.mly"
                                      ( Different(_1, _3) )
# 348 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 50 "src/parser.mly"
             ( Entier(_1) )
# 355 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 51 "src/parser.mly"
           ( Reel(_1) )
# 362 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 52 "src/parser.mly"
          ( Mot(_1) )
# 369 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'maj_mot) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 55 "src/parser.mly"
                                                        ( Assigne(_1, _3) )
# 378 "src/parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 56 "src/parser.mly"
                                                 ( Afficher(_2) )
# 386 "src/parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 59 "src/parser.mly"
                                                                        ( Condition(_2, _4, None) )
# 395 "src/parser.ml"
               : 'conditionnelle))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'paragraphe) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 60 "src/parser.mly"
                                                                                         ( Condition(_2, _4, Some _6) )
# 405 "src/parser.ml"
               : 'conditionnelle))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 62 "src/parser.mly"
                                                                                          ( BoucleTantQue(_2, _4) )
# 414 "src/parser.ml"
               : 'boucle_tant_que))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 9 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 7 : 'expression) in
    let _6 = (Parsing.peek_val __caml_parser_env 5 : 'expression) in
    let _9 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _11 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 66 "src/parser.mly"
        ( ForInclus(_2, _4, _6, _9) )
# 425 "src/parser.ml"
               : 'boucle_pour))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 9 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 7 : 'expression) in
    let _6 = (Parsing.peek_val __caml_parser_env 5 : 'expression) in
    let _9 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _11 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 68 "src/parser.mly"
        ( ForExclus(_2, _4, _6, _9) )
# 436 "src/parser.ml"
               : 'boucle_pour))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 8 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 6 : 'expression) in
    let _6 = (Parsing.peek_val __caml_parser_env 4 : 'expression) in
    let _8 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _10 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 70 "src/parser.mly"
        ( ForExclus(_2, _4, _6, _8) )
# 447 "src/parser.ml"
               : 'boucle_pour))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'declaration) in
    Obj.repr(
# 73 "src/parser.mly"
                ( _1 )
# 454 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'fonction) in
    Obj.repr(
# 74 "src/parser.mly"
             ( _1 )
# 461 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'conditionnelle) in
    Obj.repr(
# 75 "src/parser.mly"
                   ( _1 )
# 468 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boucle_tant_que) in
    Obj.repr(
# 76 "src/parser.mly"
                    ( _1 )
# 475 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boucle_pour) in
    Obj.repr(
# 77 "src/parser.mly"
                ( _1 )
# 482 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 78 "src/parser.mly"
                                           ( Increment(_2, None) )
# 490 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 79 "src/parser.mly"
                                                         ( Increment(_2, Some _4) )
# 499 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 80 "src/parser.mly"
                                           ( Decrement(_2, None) )
# 507 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 81 "src/parser.mly"
                                                         ( Decrement(_2, Some _4) )
# 516 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instruction) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'paragraphe) in
    Obj.repr(
# 84 "src/parser.mly"
                             ( _1 :: _2 )
# 524 "src/parser.ml"
               : 'paragraphe))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instruction) in
    Obj.repr(
# 85 "src/parser.mly"
                  ( [_1] )
# 531 "src/parser.ml"
               : 'paragraphe))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'parametres) in
    Obj.repr(
# 89 "src/parser.mly"
                           ( _1 :: _3 )
# 539 "src/parser.ml"
               : 'parametres))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 90 "src/parser.mly"
        ( [_1] )
# 546 "src/parser.ml"
               : 'parametres))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 8 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 7 : string) in
    let _5 = (Parsing.peek_val __caml_parser_env 5 : 'parametres) in
    let _6 = (Parsing.peek_val __caml_parser_env 4 : string) in
    let _8 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _10 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 94 "src/parser.mly"
                                                                                                                                             ( Fonction(_2, _5, _8) )
# 558 "src/parser.ml"
               : 'fonction))
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
