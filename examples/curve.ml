(* $Id$ *)

let w = GWindow.window ~width:200 ~height:150 ();;
let curve = GMisc.curve ~packing:w#add ();;
let () =
  curve#event#connect#after_any ~callback:
    (fun _ ->
      let vect = curve#get_vector 5 in
      Printf.printf "%g %g %g %g %g\n%!"
        vect.(0) vect.(1) vect.(2) vect.(3) vect.(4));
  w#connect#destroy ~callback:GMain.quit;
  w#show ();
  GMain.main ()
  
    
