(* $Id$ *)

(* One can roughly get defined classes by: *)
(* grep Object.try_cast *.ml | sed 's/gtk\([^.]*\)[^"]*"Gtk\([^"]*\)".*/  "Gtk\2", ("Gtk\1.\2", "G\1.\2");/' *)
(* But you also need to do some post-editing. Do not forget H and V classes *)

let classes = ref [
  "GtkWidget", ("GtkBase.Widget", "GObj.widget_full");
  "GtkContainer", ("GtkBase.Container", "GContainer.container");
  "GtkBin", ("GtkBase.Container", "GContainer.container");
  "GtkItem", ("GtkBase.Container", "GContainer.container");
  "GtkAlignment", ("GtkBin.Alignment", "GBin.alignment");
  "GtkEventBox", ("GtkBin.EventBox", "GBin.event_box");
  "GtkFrame", ("GtkBin.Frame", "GBin.frame");
  "GtkAspectFrame", ("GtkBin.AspectFrame", "GBin.aspect_frame");
  "GtkHandleBox", ("GtkBin.HandleBox", "GBin.handle_box");
  "GtkViewport", ("GtkBin.Viewport", "GBin.viewport");
  "GtkScrolledWindow", ("GtkBin.ScrolledWindow", "GBin.scrolled_window");
  "GtkSocket", ("GtkBin.Socket", "GBin.socket");
  "GtkInvisible", ("GtkBase.Container", "GContainer.container");
  "GtkButton", ("GtkButton.Button", "GButton.button");
  "GtkToggleButton", ("GtkButton.ToggleButton", "GButton.toggle_button");
  "GtkRadioButton", ("GtkButton.RadioButton", "GButton.radio_button");
  "GtkToolbar", ("GtkButton.Toolbar", "GButton.toolbar");
  "GtkEditable", ("GtkEdit.Editable", "GEdit.editable");
  "GtkEntry", ("GtkEdit.Entry", "GEdit.entry");
  "GtkSpinButton", ("GtkEdit.SpinButton", "GEdit.spin_button");
  "GtkText", ("GtkEdit.Text", "GEdit.text");
  "GtkCombo", ("GtkEdit.Combo", "GEdit.combo");
  "GtkListItem", ("GtkList.ListItem", "GList.list_item");
  "GtkList", ("GtkList.Liste", "GList.liste");
  "GtkCList", ("GtkList.CList", "GList.clist");
  "GtkMenuItem", ("GtkMenu.MenuItem", "GMenu.menu_item");
  "GtkCheckMenuItem", ("GtkMenu.CheckMenuItem", "GMenu.check_menu_item");
  "GtkRadioMenuItem", ("GtkMenu.RadioMenuItem", "GMenu.radio_menu_item");
  "GtkOptionMenu", ("GtkMenu.OptionMenu", "GMenu.option_menu");
  "GtkMenuShell", ("GtkMenu.MenuShell", "GMenu.menu_shell");
  "GtkMenu", ("GtkMenu.Menu", "GMenu.menu");
  "GtkMenuBar", ("GtkMenu.MenuBar", "GMenu.menu_shell");
  "GtkColorSelection", ("GtkMisc.ColorSelection", "GMisc.color_selection");
  "GtkStatusbar", ("GtkMisc.Statusbar", "GMisc.statusbar");
  "GtkCalendar", ("GtkMisc.Calendar", "GMisc.calendar");
  "GtkDrawingArea", ("GtkMisc.DrawingArea", "GMisc.drawing_area");
  "GtkCurve", ("GtkMisc.DrawingArea", "GMisc.drawing_area");
  "GtkMisc", ("GtkMisc.Misc", "GMisc.misc");
  "GtkArrow", ("GtkMisc.Arrow", "GMisc.arrow");
  "GtkImage", ("GtkMisc.Image", "GMisc.image");
  "GtkLabel", ("GtkMisc.Label", "GMisc.label");
  "GtkTipsQuery", ("GtkMisc.TipsQuery", "GMisc.tips_query");
  "GtkPixmap", ("GtkMisc.Pixmap", "GMisc.pixmap");
  "GtkSeparator", ("GtkMisc.Separator", "GObj.widget_full");
  "GtkFontSelection", ("GtkMisc.FontSelection", "GMisc.font_selection");
  "GtkBox", ("GtkPack.Box", "GPack.box");
  "GtkHBox", ("GtkPack.Box", "GPack.box");
  "GtkVBox", ("GtkPack.Box", "GPack.box");
  "GtkBBox", ("GtkPack.BBox", "GPack.button_box");
  "GtkHBBox", ("GtkPack.BBox", "GPack.button_box");
  "GtkVBBox", ("GtkPack.BBox", "GPack.button_box");
  "GtkFixed", ("GtkPack.Fixed", "GPack.fixed");
  "GtkLayout", ("GtkPack.Layout", "GPack.layout");
  "GtkPacker", ("GtkPack.Packer", "GPack.packer");
  "GtkPaned", ("GtkPack.Paned", "GPack.paned");
  "GtkTable", ("GtkPack.Table", "GPack.table");
  "GtkNotebook", ("GtkPack.Notebook", "GPack.notebook");
  "GtkProgress", ("GtkRange.Progress", "GRange.progress");
  "GtkProgressBar", ("GtkRange.ProgressBar", "GRange.progress_bar");
  "GtkRange", ("GtkRange.Range", "GRange.range");
  "GtkScale", ("GtkRange.Scale", "GRange.scale");
  "GtkHScale", ("GtkRange.Scale", "GRange.scale");
  "GtkVScale", ("GtkRange.Scale", "GRange.scale");
  "GtkScrollbar", ("GtkRange.Scrollbar", "GRange.scrollbar");
  "GtkHScrollbar", ("GtkRange.Scrollbar", "GRange.scrollbar");
  "GtkVScrollbar", ("GtkRange.Scrollbar", "GRange.scrollbar");
  "GtkRuler", ("GtkRange.Ruler", "GRange.ruler");
  "GtkHRuler", ("GtkRange.Ruler", "GRange.ruler");
  "GtkVRuler", ("GtkRange.Ruler", "GRange.ruler");
  "GtkTreeItem", ("GtkTree.TreeItem", "GTree.tree_item");
  "GtkTree", ("GtkTree.Tree", "GTree.tree");
  "GtkCTree", ("GtkBase.Container", "GContainer.container");
  "GtkWindow", ("GtkWindow.Window", "GWindow.window");
  "GtkDialog", ("GtkWindow.Dialog", "GWindow.dialog");
  "GtkInputDialog", ("GtkWindow.Dialog", "GWindow.dialog");
  "GtkFileSelection", ("GtkWindow.FileSelection", "GWindow.file_selection");
  "GtkFontSelectionDialog", ("GtkWindow.FontSelectionDialog",
                             "GWindow.font_selection_dialog");
  "GtkPlug", ("GtkWindow.Plug", "GWindow.plug");
] 

open Xml_lexer

let parse_header lexbuf =
  begin match token lexbuf with Tag ("?xml",_,true) -> ()
  | _ -> failwith "no XML header" end;
  begin match token lexbuf with Tag ("gtk-interface",_,_) -> ()
  | Tag(tag,_,_) -> prerr_endline tag
  | _ -> failwith "no GTK-interface declaration" end

let parse_field lexbuf ~tag =
  let b = Buffer.create 80 and first = ref true in
  while match token lexbuf with
    Chars s ->
      if not !first then Buffer.add_char b '\n' else first := false;
      Buffer.add_string b s;
      true
  | Endtag tag' when tag = tag' ->
      false
  | _ ->
      failwith "bad field"
  do () done;
  Buffer.contents b

type wtree = {
    wclass: string;
    wname: string;
    wchildren: wtree list;
    mutable wrapped: bool;
  }

let rec parse_widget lexbuf =
  let wclass = ref None and wname = ref None and widgets = ref [] in
  while match token lexbuf with
    Tag ("class",_,false) ->
      wclass := Some (parse_field lexbuf ~tag:"class"); true
  | Tag ("name",_,false) ->
      wname := Some (parse_field lexbuf ~tag:"name"); true
  | Tag ("widget",_,false) ->
      widgets := parse_widget lexbuf :: !widgets; true
  | Tag (tag,_,closed) ->
      if not closed then while token lexbuf <> Endtag tag do () done; true
  | Endtag "widget" ->
      false
  | Chars _ ->
      true
  | Endtag _ | EOF ->
      failwith "bad XML syntax"
  do () done;
  match !wclass, !wname with
  | Some wclass, Some wname ->
      { wclass = wclass; wname = wname;
        wchildren = List.rev !widgets; wrapped = false }
  | Some wclass, None ->
      failwith ("no name for widget of class " ^ wclass)
  | None, Some wname ->
      failwith ("no class for widget " ^ wname)
  | None, None ->
      failwith "empty widget"

let rec flatten_tree w =
  let children = List.map ~f:flatten_tree w.wchildren in
  w :: List.flatten children

let output_widget w =
  try
    let (modul, clas) = List.assoc w.wclass !classes in
    w.wrapped <- true;
    if clas = "GList.clist" then
      Printf.printf "    method %s : int %s = new %s\n" w.wname clas clas
    else Printf.printf "    method %s = new %s\n" w.wname clas;
    Printf.printf "      (%s.cast (Glade.get_widget xml ~name:\"%s\"))\n"
      modul w.wname;
  with Not_found -> ()

let parse_body ~file lexbuf =
  while match token lexbuf with
    Tag("project", _, closed) ->
      if not closed then while token lexbuf <> Endtag "project" do () done;
      true
  | Tag("widget", _, false) ->
      let wtree = parse_widget lexbuf in
      Printf.printf "class %s %s ?autoconnect(*=true*) () =\n  object (self)\n"
        wtree.wname
        (if file = "<stdin>" then "~file" else "?(file=\"" ^ file ^ "\")");
      Printf.printf
        "    inherit Glade.xml ~file ~root:\"%s\" ?autoconnect ()\n"
        wtree.wname;
      let widgets = flatten_tree wtree in
      List.iter widgets ~f:output_widget;
      Printf.printf "    method check_widgets () =\n";
      List.iter widgets ~f:
	(fun w ->
	  if w.wrapped then Printf.printf "      ignore self#%s;\n" w.wname);
      Printf.printf "  end\n";
      true
  | Tag(tag, _, closed) ->
      if not closed then while token lexbuf <> Endtag tag do () done; true
  | Chars _ -> true
  | Endtag "gtk-interface" -> false
  | Endtag _ -> failwith "bad XML syntax"
  | EOF -> false
  do () done

let process ?(file="<stdin>") chan =
  let lexbuf = Lexing.from_channel chan in
  try
    parse_header lexbuf;
    Printf.printf "(* Automatically generated from %s by lablgladecc *)\n\n"
      file;
    parse_body ~file lexbuf
  with Failure s ->
    Printf.eprintf "lablgladecc: in %s, before char %d, %s\n"
      file (Lexing.lexeme_start lexbuf) s

let output_test () =
  print_string "(* Test class definitions *)\n\n";
  print_string "class test xml =\n  object\n";
  List.iter !classes ~f:
    begin fun (clas, _) ->
      output_widget
        {wname = "a"^clas; wclass = clas; wchildren = []; wrapped = true}
    end;
  print_string "  end\n\n";
  print_string "let _ = print_endline \"lablgladecc test finished\"\n"

let main () =
  if Array.length Sys.argv = 1 then
    process stdin
  else if List.mem Sys.argv.(1) ["-h"; "-help"; "--help"] then
    begin
      prerr_string "%s <file.glade> \n";
      prerr_string
        "  Convert glade specification file to caml wrappers, to be used\n";
      prerr_string "  with libglade. Results are on standard output.\n"
    end
  else if Sys.argv.(1) = "-test" then
    output_test ()
  else
    for i = 1 to Array.length Sys.argv - 1 do
      let chan = open_in Sys.argv.(i) in
      process ~file:Sys.argv.(i) chan;
      close_in chan
    done  

let () = main ()
