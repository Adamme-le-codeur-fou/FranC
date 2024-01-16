type token =
  | Assigne
  | Afficher
  | Plus
  | Egal
  | Fois
  | Different
  | Parenthese_Gauche
  | Parenthese_Droite
  | Guillemet_Gauche
  | Guillemet_Droit
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
  | Chaine_de_caracteres of (string)
  | Entier of (string)
  | Reel of (string)

open Parsing;;
let _ = parse_error;;
# 2 "src/parser.mly"
    open Ast
# 44 "src/parser.ml"
let yytransl_const = [|
  257 (* Assigne *);
  258 (* Afficher *);
  259 (* Plus *);
  260 (* Egal *);
  261 (* Fois *);
  262 (* Different *);
  263 (* Parenthese_Gauche *);
  264 (* Parenthese_Droite *);
  265 (* Guillemet_Gauche *);
  266 (* Guillemet_Droit *);
  267 (* Si *);
  268 (* Alors *);
  269 (* Sinon *);
  270 (* Fin_condition *);
  271 (* Tant_que *);
  272 (* Fin_boucle *);
  273 (* Reste_division_euclidienne_debut *);
  274 (* Par *);
  275 (* Iterer *);
  276 (* Sur *);
  277 (* Allant_de *);
  278 (* A *);
  279 (* Compris *);
  280 (* Non_compris *);
  281 (* Termine_sequence *);
  282 (* Agir *);
  283 (* Incrementer *);
  284 (* De *);
    0 (* EOF *);
  285 (* Tabulation *);
    0|]

let yytransl_block = [|
  286 (* Mot *);
  287 (* Mot_majuscule *);
  288 (* Ponctuation_fin_phrase *);
  289 (* Chaine_de_caracteres *);
  290 (* Entier *);
  291 (* Reel *);
    0|]

let yylhs = "\255\255\
\001\000\003\000\004\000\004\000\004\000\004\000\004\000\004\000\
\004\000\004\000\004\000\004\000\005\000\005\000\006\000\006\000\
\007\000\008\000\008\000\008\000\009\000\009\000\009\000\009\000\
\009\000\009\000\002\000\002\000\000\000"

let yylen = "\002\000\
\002\000\001\000\004\000\003\000\003\000\003\000\003\000\003\000\
\001\000\001\000\001\000\001\000\004\000\003\000\006\000\008\000\
\006\000\011\000\011\000\010\000\001\000\001\000\001\000\001\000\
\003\000\005\000\002\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\
\029\000\000\000\000\000\021\000\022\000\023\000\024\000\000\000\
\000\000\000\000\011\000\012\000\009\000\010\000\000\000\000\000\
\000\000\000\000\000\000\001\000\000\000\027\000\000\000\000\000\
\000\000\000\000\000\000\000\000\014\000\000\000\000\000\000\000\
\000\000\025\000\000\000\004\000\000\000\000\000\000\000\006\000\
\000\000\000\000\000\000\000\000\000\000\013\000\000\000\000\000\
\000\000\000\000\000\000\026\000\000\000\015\000\017\000\000\000\
\000\000\000\000\000\000\000\000\016\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\020\000\018\000\019\000"

let yydgoto = "\002\000\
\009\000\010\000\011\000\023\000\012\000\013\000\014\000\015\000\
\016\000"

let yysindex = "\013\000\
\056\255\000\000\079\255\079\255\079\255\243\254\251\254\000\000\
\000\000\026\000\029\255\000\000\000\000\000\000\000\000\056\255\
\079\255\079\255\000\000\000\000\000\000\000\000\003\255\135\255\
\146\255\016\255\252\254\000\000\079\255\000\000\151\255\086\255\
\079\255\079\255\079\255\079\255\000\000\056\255\056\255\079\255\
\079\255\000\000\015\255\000\000\079\255\031\255\046\255\000\000\
\046\255\247\254\032\255\007\255\073\255\000\000\031\255\056\255\
\013\255\021\255\079\255\000\000\045\255\000\000\000\000\122\255\
\033\255\037\255\040\255\056\255\000\000\056\255\056\255\043\255\
\044\255\047\255\041\255\042\255\049\255\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\001\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\076\255\098\255\000\000\
\111\255\000\000\000\000\000\000\000\000\000\000\038\255\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\240\255\000\000\254\255\000\000\000\000\000\000\000\000\
\000\000"

let yytablesize = 282
let yytable = "\030\000\
\028\000\024\000\025\000\056\000\057\000\033\000\034\000\035\000\
\036\000\033\000\034\000\035\000\036\000\001\000\031\000\032\000\
\026\000\033\000\034\000\035\000\036\000\050\000\051\000\041\000\
\027\000\028\000\043\000\042\000\059\000\029\000\046\000\047\000\
\048\000\049\000\037\000\035\000\040\000\052\000\053\000\061\000\
\003\000\003\000\055\000\003\000\062\000\003\000\054\000\058\000\
\033\000\003\000\035\000\072\000\063\000\073\000\074\000\003\000\
\064\000\003\000\065\000\003\000\003\000\003\000\070\000\003\000\
\069\000\071\000\004\000\075\000\076\000\003\000\005\000\077\000\
\078\000\079\000\006\000\033\000\034\000\035\000\036\000\005\000\
\080\000\005\000\007\000\005\000\000\000\017\000\008\000\005\000\
\033\000\034\000\035\000\036\000\000\000\005\000\000\000\018\000\
\000\000\005\000\005\000\005\000\000\000\005\000\000\000\045\000\
\060\000\007\000\000\000\005\000\019\000\007\000\000\000\020\000\
\021\000\022\000\000\000\007\000\000\000\000\000\008\000\007\000\
\007\000\007\000\008\000\007\000\033\000\034\000\035\000\036\000\
\008\000\007\000\000\000\000\000\008\000\008\000\008\000\000\000\
\008\000\033\000\034\000\035\000\036\000\000\000\008\000\000\000\
\066\000\067\000\038\000\068\000\033\000\034\000\035\000\036\000\
\000\000\033\000\034\000\035\000\036\000\039\000\044\000\000\000\
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
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\028\000\028\000\000\000\
\028\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\028\000"

let yycheck = "\016\000\
\000\000\004\000\005\000\013\001\014\001\003\001\004\001\005\001\
\006\001\003\001\004\001\005\001\006\001\001\000\017\000\018\000\
\030\001\003\001\004\001\005\001\006\001\038\000\039\000\028\001\
\030\001\000\000\029\000\032\001\022\001\001\001\033\000\034\000\
\035\000\036\000\032\001\005\001\021\001\040\000\041\000\056\000\
\003\001\004\001\045\000\006\001\032\001\008\001\032\001\016\001\
\003\001\012\001\005\001\068\000\032\001\070\000\071\000\018\001\
\059\000\002\001\014\001\022\001\023\001\024\001\026\001\026\001\
\032\001\026\001\011\001\025\001\025\001\032\001\015\001\025\001\
\032\001\032\001\019\001\003\001\004\001\005\001\006\001\004\001\
\032\001\006\001\027\001\008\001\255\255\007\001\031\001\012\001\
\003\001\004\001\005\001\006\001\255\255\018\001\255\255\017\001\
\255\255\022\001\023\001\024\001\255\255\026\001\255\255\018\001\
\032\001\008\001\255\255\032\001\030\001\012\001\255\255\033\001\
\034\001\035\001\255\255\018\001\255\255\255\255\008\001\022\001\
\023\001\024\001\012\001\026\001\003\001\004\001\005\001\006\001\
\018\001\032\001\255\255\255\255\022\001\023\001\024\001\255\255\
\026\001\003\001\004\001\005\001\006\001\255\255\032\001\255\255\
\023\001\024\001\012\001\026\001\003\001\004\001\005\001\006\001\
\255\255\003\001\004\001\005\001\006\001\012\001\008\001\255\255\
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
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\013\001\014\001\255\255\
\016\001\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\025\001"

let yynames_const = "\
  Assigne\000\
  Afficher\000\
  Plus\000\
  Egal\000\
  Fois\000\
  Different\000\
  Parenthese_Gauche\000\
  Parenthese_Droite\000\
  Guillemet_Gauche\000\
  Guillemet_Droit\000\
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
  Chaine_de_caracteres\000\
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
# 269 "src/parser.ml"
               : Ast.ast))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 38 "src/parser.mly"
                       ( Mot(_1) )
# 276 "src/parser.ml"
               : 'maj_mot))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 43 "src/parser.mly"
                                                                 ( Modulo(_2, _4) )
# 284 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    Obj.repr(
# 44 "src/parser.mly"
                                                     ( _2 )
# 291 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 45 "src/parser.mly"
                                 ( Plus(_1, _3) )
# 299 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 46 "src/parser.mly"
                                 ( Fois(_1, _3) )
# 307 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 47 "src/parser.mly"
                                 ( Egal(_1, _3) )
# 315 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'expression) in
    Obj.repr(
# 48 "src/parser.mly"
                                      ( Different(_1, _3) )
# 323 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 49 "src/parser.mly"
             ( Entier(_1) )
# 330 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 50 "src/parser.mly"
           ( Reel(_1) )
# 337 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 51 "src/parser.mly"
          ( Mot(_1) )
# 344 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 52 "src/parser.mly"
                           ( ChaineDeCaracteres(_1) )
# 351 "src/parser.ml"
               : 'expression))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 3 : 'maj_mot) in
    let _3 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 55 "src/parser.mly"
                                                        ( Assigne(_1, _3) )
# 360 "src/parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 56 "src/parser.mly"
                                                 ( Afficher(_2) )
# 368 "src/parser.ml"
               : 'declaration))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 59 "src/parser.mly"
                                                                        ( Condition(_2, _4, None) )
# 377 "src/parser.ml"
               : 'conditionnelle))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'paragraphe) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 60 "src/parser.mly"
                                                                                         ( Condition(_2, _4, Some _6) )
# 387 "src/parser.ml"
               : 'conditionnelle))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'expression) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'paragraphe) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 62 "src/parser.mly"
                                                                                          ( BoucleTantQue(_2, _4) )
# 396 "src/parser.ml"
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
# 407 "src/parser.ml"
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
# 418 "src/parser.ml"
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
# 429 "src/parser.ml"
               : 'boucle_pour))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'declaration) in
    Obj.repr(
# 73 "src/parser.mly"
                ( _1 )
# 436 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'conditionnelle) in
    Obj.repr(
# 74 "src/parser.mly"
                   ( _1 )
# 443 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boucle_tant_que) in
    Obj.repr(
# 75 "src/parser.mly"
                    ( _1 )
# 450 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'boucle_pour) in
    Obj.repr(
# 76 "src/parser.mly"
                ( _1 )
# 457 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 77 "src/parser.mly"
                                           ( Increment(_2, None) )
# 465 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'expression) in
    let _5 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 78 "src/parser.mly"
                                                         ( Increment(_2, Some _4) )
# 474 "src/parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instruction) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'paragraphe) in
    Obj.repr(
# 81 "src/parser.mly"
                             ( _1 :: _2 )
# 482 "src/parser.ml"
               : 'paragraphe))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instruction) in
    Obj.repr(
# 82 "src/parser.mly"
                  ( [_1] )
# 489 "src/parser.ml"
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
