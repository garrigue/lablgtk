(* $Id$ *)

open StdLabels
open Gobject.Data

let cols = new GTree.column_list
let title = cols#add string
let author = cols#add string
let checked = cols#add boolean

let create_model () =
  let store = GTree.tree_store cols in
  let row = store#append () in
  store#set ~row ~column:title "The Art of Computer Programming";
  store#set ~row ~column:author "Donald E. Knuth";
  store#set ~row ~column:checked false;
  store#set ~row:(store#append ~parent:row ())
    ~column:title "Volume 1: Fundamental Algorithms";
  store#set ~row:(store#append ~parent:row ())
    ~column:title "Volume 2: Seminumerical Algorithms";
  store#set ~row:(store#append ~parent:row ())
    ~column:title "Volume 3: Sorting and Searching Algorithms";
  store

let main () =
  let model = create_model () in
  let window = GWindow.window () in
  window#connect#destroy ~callback:GMain.quit;
  let view = GTree.view ~model ~packing:window#add () in
  let col = GTree.view_column ~title:"Title" ()
      ~renderer:(GTree.cell_renderer_text[], ["text",title]) in
  view#append_column col;
  let col = GTree.view_column ~title:"Author" ()
      ~renderer:(GTree.cell_renderer_text[], ["text",author]) in
  view#append_column col;
  let col = GTree.view_column ~title:"Checked-out" ()
      ~renderer:(GTree.cell_renderer_text[], ["text",checked]) in
  view#append_column col;
  view#selection#connect#after#changed ~callback:
    begin fun () ->
      prerr_endline "selection changed";
      List.iter view#selection#get_selected_rows ~f:
        (fun p -> prerr_endline (GtkTree.TreePath.to_string p));
    end;
  view#connect#after#row_activated ~callback:
    (fun path vcol ->
       prerr_endline "Row activated";
       let it = model#get_iter path in
       assert (model#iter_is_valid it);
       model#clear ();
    );
  window#show ();
  GMain.main ()

let () = main ()
