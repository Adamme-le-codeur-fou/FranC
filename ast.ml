exception PhraseInvalide
exception TokenInvalide

type ast = 
  | Mot of string
  | Nombre of string
  | Phrase of ast list * string
  | Plus of ast * ast
  | Egal of ast * ast
  | Fois of ast * ast
  | Assigne of ast * ast
  | Paragraphe of ast list


let rec print_mot_liste l =
  match l with
  | [] -> ()
  | Mot(m)::q -> Printf.printf "mot(%s)%s" m (if q = [] then "" else ", "); print_mot_liste q
  | _ -> raise PhraseInvalide


let rec affiche a =
  match a with
  | Phrase(l, p) ->
    print_string "Phrase(";
    print_mot_liste l;
    Printf.printf ", Ponctuation(%s)" p;
    print_string ")\n"
  | Plus(p1, p2) ->
    print_string "(";
    affiche p1;
    print_string " + ";
    affiche p2;
    print_string ")"
  | Fois(p1, p2) ->
    print_string "(";
    affiche p1;
    print_string " * ";
    affiche p2;
    print_string ")"
  | Egal(p1, p2) -> 
    print_string "(";
    affiche p1;
    print_string " = ";
    affiche p2;
    print_string ")"
  | Nombre(d) -> print_string d
  | Mot(m) -> print_string (String.lowercase_ascii m)
  | Assigne(m, e) ->
    affiche m;
    print_string " = ";
    affiche e;
    print_string ";"
  | Paragraphe(l) -> 
    print_string "Paragraphe(";
    List.iter affiche l;
    print_string ")"
  | _ -> raise TokenInvalide