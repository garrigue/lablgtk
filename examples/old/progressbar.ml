(* $Id$ *)

open Gtk

class bar () = object
  val mutable pstat = true
  method progress (bar : ProgressBar.t) =
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
  Container.border_width window 10;

  let table = Table.create 3 2 homogeneous:true in
  Container.add window table;
  
  let label = Label.create "Progress Bar Example" in
  Table.attach table label left:0 right:2 top:0;
  Widget.show label;
  
  let pbar = ProgressBar.create 
