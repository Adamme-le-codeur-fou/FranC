let canal_sortie = ref stdout

let change_canal nouveau_canal =
  canal_sortie := nouveau_canal

let ecrire chaine_format = Printf.fprintf !canal_sortie chaine_format

let ecrire_ligne_drapeau_fr taille =
  let fond_bleu = "\\e[0;104m" and fond_blanc = "\\e[0;107m" and fond_rouge = "\\e[0;101m" in
  let original_style = "\\e[0m" in
  let taille_bleu = taille / 3 and taille_blanc = taille / 3 and taille_rouge = taille - 2 * (taille / 3) in
  ecrire "wprintf(L\"%s%%%dc%s%%%dc%s%%%dc%s\\n\", ' ', ' ', ' ');\n"
      fond_bleu  taille_bleu
      fond_blanc taille_blanc
      fond_rouge taille_rouge
      original_style


(* Ne pas passer de chaines qui contiennent des retour à la ligne *)
let ecrire_texte_fond_france chaine_format =
  Printf.ksprintf (fun chaine_formatee ->
    let chaine_formatee = String.make 1 ' ' ^ chaine_formatee ^ String.make 1 ' ' in
    let fond_bleu = "\\e[44m" and fond_blanc = "\\e[48;5;251m" and fond_rouge = "\\e[41m" in
    let original_style = "\\e[0m" in
    let ecriture_noire = "\\e[1;30m" in
    let chaine_longueur = String.length chaine_formatee in
    let un_tiers_de_chaine = chaine_longueur / 3 in
    let partie_bleue   = String.sub chaine_formatee 0 un_tiers_de_chaine in
    let partie_blanche = String.sub chaine_formatee un_tiers_de_chaine un_tiers_de_chaine in
    let partie_rouge   = String.sub chaine_formatee (2 * un_tiers_de_chaine) (chaine_longueur - 2 * un_tiers_de_chaine) in
    ecrire_ligne_drapeau_fr chaine_longueur;
    ecrire "wprintf(L\"%s%s%s%s%s%s%s%s\\n\");\n"
        ecriture_noire fond_bleu partie_bleue fond_blanc partie_blanche fond_rouge partie_rouge original_style;
    ecrire_ligne_drapeau_fr chaine_longueur;
  ) chaine_format