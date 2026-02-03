let canal_sortie = ref stdout

let change_canal nouveau_canal =
  canal_sortie := nouveau_canal

let ecrire chaine_format = Printf.fprintf !canal_sortie chaine_format