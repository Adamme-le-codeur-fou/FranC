open Unix
open FranC.Ecrire

let capture_sortie_avec fonction =
  let lecture, ecriture = pipe () in
  let canal_entree = in_channel_of_descr lecture in
  let canal_sortie = out_channel_of_descr ecriture in

  change_canal canal_sortie;
  fonction ();
  close_out canal_sortie;

  let resultat = really_input_string canal_entree (in_channel_length canal_entree) in
  close_in canal_entree;
  resultat
