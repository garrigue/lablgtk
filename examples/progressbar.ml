(* $Id$ *)

open GMain

class bar bar = object
  val bar : GRange.progress_bar = bar
  val mutable pstat = true
  method progress () =
    let pvalue = bar#percentage in
    let pvalue =
      if pvalue >= 1.0 || not pstat then (pstat <- true; 0.0)
      else pvalue +. 0.01
    in
    bar#update pvalue;
    true
  method reset () =
    pstat <- false
end

let main () =

  let window = new GWin.window `TOPLEVEL border_width: 10 in
  window#connect#destroy callback:Main.quit;

  let table = new GPack.table rows:3 columns:2 packing: window#add in
  
  let label = new GMisc.label text:"Progress Bar Example" in
  table#attach label left:0 right:2 top:0 expand:`X shrink:`BOTH;
  
  let pbar = new GRange.progress_bar in
  table#attach pbar left:0 right:2 top:1 fill:`X shrink:`BOTH;

  let bar = new bar pbar in
  let ptimer = Timeout.add 100 callback:bar#progress in

  let button = new GButton.button label:"Reset" in
  button#connect#clicked callback:bar#reset;
  table#attach button left:0 top:2 expand:`NONE fill:`X shrink:`BOTH;

  let button = new GButton.button label:"Cancel" in
  button#connect#clicked callback:Main.quit;
  table#attach button left:1 top:2 expand:`NONE fill:`X shrink:`BOTH;

  window#show_all ();
  Main.main ()

let _ = main ()
