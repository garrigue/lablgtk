open Gtk
open GObj
open GWindow
open GPack
open GdkObj
open GPix
open GFrame


let targets = [ { target = "STRING"; flags = []; info = 0} ]


let xpm_window () =
  let source_drag_data_get classe _ (data : selection_data) :info :time =
    data#set type:data#target format:0 data:classe in
  let window = new window show:true title:"icons" in
  let table = new table rows:5 columns:5 packing:window#add in

  let add_xpm :file :left :top :classe =
  let gdk_pix = new pixmap_from_xpm :file window:window#misc#window in
  let ev = new event_box in
  let pix = new pixmap gdk_pix packing:ev#add in
  table#attach ev :left :top;
  ev#drag#source_set mod:[`BUTTON1] :targets actions:[`COPY];
  ev#drag#source_set_icon colormap:window#misc#style#colormap 
    gdk_pix; 
  ev#connect#drag#data_get callback:(source_drag_data_get classe) in

  add_xpm file:"button.xpm"         left:0 top:0 classe:"button";
  add_xpm file:"togglebutton.xpm"   left:1 top:0 classe:"toggle_button";
  add_xpm file:"checkbutton.xpm"    left:2 top:0 classe:"check_button";
  add_xpm file:"hbox.xpm"           left:0 top:1 classe:"hbox";
  add_xpm file:"vbox.xpm"           left:1 top:1 classe:"vbox";
  add_xpm file:"frame.xpm"          left:2 top:1 classe:"frame";
  add_xpm file:"scrolledwindow.xpm" left:3 top:1 classe:"scrolled_window"
;;

xpm_window ()
