let remplacer_caractere ancien_caractere nouveau_caractere chaine_caractere =
  String.map
    (fun caractere_courrant ->
       if caractere_courrant = ancien_caractere then nouveau_caractere
       else caractere_courrant)
    chaine_caractere

let normaliser_chaine chaine_caractere =
  String.fold_left
    (fun acc caractere_courrant ->
       match caractere_courrant with
       | '%' -> acc ^ "%%"
       | '\\' -> acc ^ "\\\\"
       | _ -> acc ^ String.make 1 caractere_courrant)
    "" chaine_caractere
