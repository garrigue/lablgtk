
let locale = GtkMain.Main.init ()

let add_stuff canvas =
  let group = canvas#get_root_item in
  let r1 = GooCanvas.rect
    ~props: [`X 10. ; `Y 50. ; `WIDTH 200. ; `HEIGHT 100. ;
      `LINE_WIDTH 1. ; `FILL_COLOR "red"] group
  in
  let text =
    let font_desc = Pango.Font.from_string "Sans 14" in
    let props =
      [ `TEXT "Hello world!" ; `FONT_DESC font_desc  ; `ANCHOR `NW ;
        `FILL_COLOR "blue" ;
        `X 200. ; `Y 200. ;
      ]
    in
    GooCanvas.text ~props group
  in
  ()


let main () =
  let window = GWindow.window ~title:"GooCanvas example"
    ~width:400 ~height:400 ()
  in
  let evbox = GBin.event_box ~packing:window#add () in
  let () = evbox#misc#set_can_focus true in
  let wscroll = GBin.scrolled_window
    ~hpolicy:`AUTOMATIC ~vpolicy:`AUTOMATIC
    ~packing:evbox#add
    ()
  in
  let canvas = GooCanvas.canvas ~packing:wscroll#add () in
  add_stuff canvas ;
  ignore (window#connect#destroy (fun _ -> GMain.quit ()));
  window#show ();
  GMain.Main.main ()

let () = main ()
