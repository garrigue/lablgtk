(* $Id$ *)

#load "gtkObj.cmo"

open Gtk
open GtkObj

class bar bar = object
  val bar : progress_bar = bar
  val mutable pstat = true
  method progress () =
    let pvalue = bar#percent in
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

  let window = new_window `TOPLEVEL in
  window#connect#destroy cb:Main.quit;
  window#border_width 10;

  let table = new_table 3 2 in
  window#add table;
  
  let label = new_label "Progress Bar Example" in
  table#attach label left:0 right:2 top:0 expand:`x shrink:`both;
  
  let pbar = new_progress_bar () in
  table#attach pbar left:0 right:2 top:1 fill:`x shrink:`both;

  let bar = new bar pbar in
  let ptimer = Timeout.add 100 cb:bar#progress in

  let button = new_button label:"Reset" in
  button#connect#clicked cb:bar#reset;
  table#attach button left:0 top:2 expand:`none fill:`x shrink:`both;

  let button = new_button label:"Cancel" in
  button#connect#clicked cb:Main.quit;
  table#attach button left:1 top:2 expand:`none fill:`x shrink:`both;

  window#show_all ();
  Main.main ()

let _ = main ()
