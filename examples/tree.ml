(* $Id$ *)

open GTree.Data

let cols = new GTree.column_list
let title = cols#add string
let author = cols#add string
let checked = cols#add boolean

let create_model () =
  let store = GTree.store cols in
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
      ~renderer:(GTree.cell_renderer_text(), ["text",title]) in
  view#append_column col;
  let col = GTree.view_column ~title:"Author" ()
      ~renderer:(GTree.cell_renderer_text(), ["text",author]) in
  view#append_column col;
  let col = GTree.view_column ~title:"Checked-out" ()
      ~renderer:(GTree.cell_renderer_text(), ["text",checked]) in
  view#append_column col;
  window#show ();
  GMain.main ()

let () = main ()
