(* $Id$ *)

open GMain

class bar bar = object
  val bar : #GRange.progress = bar
  val mutable pstat = true
  method progress () =
    let pvalue = bar#percentage in
    let pvalue =
      if pvalue > 0.99 || not pstat then (pstat <- true; 0.0)
      else pvalue +. 0.01
    in
    bar#set_percentage pvalue;
    true
  method reset () =
    pstat <- false
end

let main () =

  let window = GWindow.window ~border_width: 10 () in
  window#connect#destroy ~callback:Main.quit;

  let table = GPack.table ~rows:3 ~columns:2 ~packing: window#add () in
  
  GMisc.label ~text:"Progress Bar Example" ()
    ~packing:(table#attach ~left:0 ~right:2 ~top:0 ~expand:`X ~shrink:`BOTH);
  
  let pbar =
    GRange.progress_bar ~bar_style:`DISCRETE ~discrete_blocks:20 ()
      ~packing:(table#attach ~left:0 ~right:2 ~top:1 ~fill:`X ~shrink:`BOTH) in

  let bar = new bar pbar in
  let ptimer = Timeout.add 100 ~callback:bar#progress in

  let button = GButton.button ~label:"Reset" ()
      ~packing:(table#attach ~left:0 ~top:2 ~expand:`NONE ~fill:`X ~shrink:`BOTH) in
  button#connect#clicked ~callback:bar#reset;

  let button = GButton.button ~label:"Cancel" ()
      ~packing:(table#attach ~left:1 ~top:2 ~expand:`NONE ~fill:`X ~shrink:`BOTH) in
  button#connect#clicked ~callback:Main.quit;

  window#show ();
  Main.main ()

let _ = main ()
