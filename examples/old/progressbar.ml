(* $Id$ *)

open Gtk
open GtkBase
open GtkMisc
open GtkWindow
open GtkRange
open GtkPack
open GtkButton
open GtkMain


class bar bar = object
  val bar : progress_bar obj = bar
  val mutable pstat = true
  method progress =
    let pvalue = Progress.get_percentage bar in
    let pvalue =
      if pvalue >= 1.0 || not pstat then (pstat <- true; 0.0)
      else pvalue +. 0.01
    in
    ProgressBar.update bar percent:pvalue;
    true
  method progress_r =
    pstat <- false
end

let main () =

  let window = Window.create `TOPLEVEL in
  GtkSignal.connect sig:Object.Signals.destroy window callback:Main.quit;
  Container.set_border_width window 10;

  let table = Table.create rows:3 columns:2 in
  Container.add window table;
  
  let label = Label.create "Progress Bar Example" in
  Table.attach table label left:0 right:2 top:0 expand:`X shrink:`BOTH;
  
  let pbar = ProgressBar.create () in
  Table.attach table pbar left:0 right:2 top:1 fill:`X shrink:`BOTH;

  let bar = new bar pbar in
  let ptimer = Timeout.add 100 callback:(fun () -> bar#progress) in

  let button = Button.create label:"Reset" in
  GtkSignal.connect sig:Button.Signals.clicked button
    callback:(fun () -> bar#progress_r);
  Table.attach table button left:0 top:2 expand:`NONE fill:`X shrink:`BOTH;

  let button = Button.create label:"Cancel" in
  GtkSignal.connect sig:Button.Signals.clicked button callback:Main.quit;
  Table.attach table button left:1 top:2 expand:`NONE fill:`X shrink:`BOTH;

  Widget.show_all window


let _ =
  main ();
  Main.main ()
