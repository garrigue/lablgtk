(* $Id$ *)

open StdLabels

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
  "GtkTextMark", ("GtkText.Mark", "GText.mark");
  "GtkTextTag", ("GtkText.Tag", "GText.tag");
  "GtkTextTagTable", ("GtkText.TagTable", "GText.tag_table");
  "GtkTextBuffer", ("GtkText.Buffer", "GText.buffer");
  "GtkTextChildAnchor", ("GtkText.ChildAnchor", "GText.child_anchor");
  "GtkTextView", ("GtkText.View", "GText.view");
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
  begin match token lexbuf with Tag ("!doctype",_,_) -> ()
  | _ -> failwith "no DOCTYPE declaration" end;
  begin match token lexbuf with Tag ("glade-interface",_,_) -> ()
  | Tag(tag,_,_) -> prerr_endline tag
  | _ -> failwith "no glade-interface declaration" end

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

let rec parse_widget ~wclass ~wname lexbuf =
  let widgets = ref [] in
  while match token lexbuf with
  | Tag ("widget", attrs, closed) ->
      widgets := parse_widget ~wclass:(List.assoc "class" attrs)
	  ~wname:(List.assoc "id" attrs) lexbuf :: !widgets;
      true
  | Tag ("child",_,_) | Endtag "child" ->
      true
  | Tag (tag,_,closed) ->
      if not closed then while token lexbuf <> Endtag tag do () done; true
  | Endtag "widget" ->
      false
  | Chars _ ->
      true
  | Endtag _ | EOF ->
      failwith "bad XML syntax"
  do () done;
  { wclass = wclass; wname = wname;
    wchildren = List.rev !widgets; wrapped = false }

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

let roots = ref []
let embed = ref false
let trace = ref false

let output_wrapper ~file wtree =
  Printf.printf "class %s %s?domain ?autoconnect(*=true*) () =\n"
    wtree.wname
    (if !embed then "" else
    if file = "<stdin>" then "~file " else "?(file=\"" ^ file ^ "\") ");
  print_string "  object (self)\n";
  Printf.printf
    "    inherit Glade.xml %s ~root:\"%s\" ?domain %s?autoconnect ()\n"
    (if !embed then "~data" else "~file")
    wtree.wname
    (if !trace then "~trace:stderr " else "");
  let widgets = flatten_tree wtree in
  List.iter widgets ~f:output_widget;
  Printf.printf "    method check_widgets () =\n";
  List.iter widgets ~f:
    (fun w ->
      if w.wrapped then Printf.printf "      ignore self#%s;\n" w.wname);
  Printf.printf "  end\n"

let parse_body ~file lexbuf =
  while match token lexbuf with
    Tag("project", _, closed) ->
      if not closed then while token lexbuf <> Endtag "project" do () done;
      true
  | Tag("widget", attrs, false) ->
      let wtree = parse_widget ~wclass:(List.assoc "class" attrs)
	  ~wname:(List.assoc "id" attrs) lexbuf in
      let rec output_roots wtree =
        if List.mem wtree.wname ~set:!roots then output_wrapper ~file wtree;
        List.iter ~f:output_roots wtree.wchildren
      in
      if !roots = [] then output_wrapper ~file wtree
      else output_roots wtree;
      true
  | Tag(tag, _, closed) ->
      if not closed then while token lexbuf <> Endtag tag do () done; true
  | Chars _ -> true
  | Endtag "glade-interface" -> false
  | Endtag _ -> failwith "bad XML syntax"
  | EOF -> false
  do () done

let process ?(file="<stdin>") chan =
  let lexbuf, data =
    if !embed then begin
      let b = Buffer.create 1024 in
      let buf = String.create 1024 in
      while
        let len = input chan buf 0 1024 in
        Buffer.add_substring b buf 0 len;
        len > 0
      do () done;
      let data = Buffer.contents b in
      Lexing.from_string data, data
    end else
      Lexing.from_channel chan, ""
  in
  try
    parse_header lexbuf;
    Printf.printf "(* Automatically generated from %s by lablgladecc *)\n\n"
      file;
    if !embed then Printf.printf "let data = \"%s\"\n\n" (String.escaped data);
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
  let files = ref [] and test = ref false in
  Arg.parse
    [ "-test", Arg.Set test, " check lablgladecc (takes no input)";
      "-embed", Arg.Set embed, " embed input file into generated program";
      "-trace", Arg.Set trace, " trace calls to handlers";
      "-root", Arg.String (fun s -> roots := s :: !roots),
      "<widget>  generate only a wrapper for <widget> and its children" ]
    (fun s -> files := s :: !files)
    "lablgladecc2 [<options>] [<file.glade>]";
  if !test then
    output_test ()
  else if !files = [] then
    process ~file:"<stdin>" stdin
  else
    List.iter (List.rev !files) ~f:
      begin fun file ->
        let chan = open_in file in
        process ~file chan;
        close_in chan
      end

let () = main ()
