(* $Id$ *)

open Gtk

class bar bar = object
  val bar : ProgressBar.t obj= bar
  val mutable pstat = true
  method progress =
    let pvalue = ProgressBar.percent bar in
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
  Window.Connect.destroy window cb:Main.quit;
  Window.set window border_width: 10;

  let table = Table.create rows:3 columns:2 in
  Window.add window table;
  
  let label = Label.create "Progress Bar Example" in
  Table.attach table label left:0 right:2 top:0 expand:`x shrink:`both;
  
  let pbar = ProgressBar.create () in
  Table.attach table pbar left:0 right:2 top:1 fill:`x shrink:`both;

  let bar = new bar pbar in
  let ptimer = Timeout.add 100 cb:(fun () -> bar#progress) in

  let button = Button.create label:"Reset" in
  Button.Connect.clicked button cb:(fun () -> bar#progress_r);
  Table.attach table button left:0 top:2 expand:`none fill:`x shrink:`both;

  let button = Button.create label:"Cancel" in
  Button.Connect.clicked button cb:Main.quit;
  Table.attach table button left:1 top:2 expand:`none fill:`x shrink:`both;

  Window.show_all window


let _ =
  main ();
  Main.main ()
