(* $Id$ *)

open GMain

let main () =
  let window = GWindow.window () in
  window#connect#destroy ~callback:Main.quit;

  let calendar = GMisc.calendar ~packing:window#add () in
  calendar#connect#day_selected ~callback:
    begin fun () ->
      let (year,month,day) = calendar#date in
      Printf.printf "You selected %d/%d/%02d.\n"
	day (month+1) (year mod 100);
      flush stdout
    end;

  window#show ();
  Main.main ()

let _ = main ()
