(* $Id$ *)

open StdLabels
open Printf

let debug = ref false
let hide_default_names = ref false

let warning s = prerr_string "Warning: "; prerr_endline s

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
  "GtkSocket", ("GtkWindow.Socket", "GWindow.socket");
  "GtkInvisible", ("GtkBase.Container", "GContainer.container");
  "GtkButton", ("GtkButton.Button", "GButton.button");
  "GtkToggleButton", ("GtkButton.ToggleButton", "GButton.toggle_button");
  "GtkCheckButton", ("GtkButton.ToggleButton", "GButton.toggle_button");
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
  "GtkSeparatorMenuItem", ("GtkMenu.MenuItem", "GMenu.menu_item");
  "GtkTearoffMenuItem", ("GtkMenu.MenuItem", "GMenu.menu_item");
  "GtkCheckMenuItem", ("GtkMenu.CheckMenuItem", "GMenu.check_menu_item");
  "GtkRadioMenuItem", ("GtkMenu.RadioMenuItem", "GMenu.radio_menu_item");
  "GtkImageMenuItem", ("GtkMenu.ImageMenuItem", "GMenu.image_menu_item");
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
  "GtkPixmap", ("GtkMisc.Image", "GMisc.image");
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
(*  "GtkPacker", ("GtkPack.Packer", "GPack.packer"); *)
  "GtkPaned", ("GtkPack.Paned", "GPack.paned");
  "GtkTable", ("GtkPack.Table", "GPack.table");
  "GtkNotebook", ("GtkPack.Notebook", "GPack.notebook");
(*   "GtkProgress", ("GtkRange.Progress", "GRange.progress"); *)
  "GtkProgressBar", ("GtkRange.ProgressBar", "GRange.progress_bar");
  "GtkRange", ("GtkRange.Range", "GRange.range");
  "GtkScale", ("GtkRange.Scale", "GRange.scale");
  "GtkHScale", ("GtkRange.Scale", "GRange.scale");
  "GtkVScale", ("GtkRange.Scale", "GRange.scale");
  "GtkScrollbar", ("GtkRange.Scrollbar", "GRange.range");
  "GtkHScrollbar", ("GtkRange.Scrollbar", "GRange.range");
  "GtkVScrollbar", ("GtkRange.Scrollbar", "GRange.range");
  "GtkRuler", ("GtkRange.Ruler", "GRange.ruler");
  "GtkHRuler", ("GtkRange.Ruler", "GRange.ruler");
  "GtkVRuler", ("GtkRange.Ruler", "GRange.ruler");
(*   "GtkTextMark", ("GtkText.Mark", "GText.mark"); *)
  "GtkTextTag", ("GtkText.Tag", "GText.tag");
(*   "GtkTextTagTable", ("GtkText.TagTable", "GText.tag_table");*)
  "GtkTextBuffer", ("GtkText.Buffer", "GText.buffer");
(*   "GtkTextChildAnchor", ("GtkText.ChildAnchor", "GText.child_anchor");*)
  "GtkTextView", ("GtkText.View", "GText.view");
  "GtkTreeItem", ("GtkTree.TreeItem", "GTree.tree_item");
  "GtkTreeView", ("GtkTree.TreeView", "GTree.view");
  "GtkTree", ("GtkTree.Tree", "GTree.tree");
  "GtkCTree", ("GtkBase.Container", "GContainer.container");
  "GtkWindow", ("GtkWindow.Window", "GWindow.window_full");
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
    wcamlname : string;
    wchildren: wtree list;
    mutable wrapped: bool;
  }

exception Unsupported

(* map arbitrary strings to caml identifiers. Clashes may occur! *) 

let camlize s = match s with 
  | "" -> "_"
  |  s -> let s = String.uncapitalize s in
     for i = 0 to String.length s - 1 do 
       match s.[i] with
       | 'a'..'z'| 'A'..'Z' | '0'..'9' -> ()
       | _ -> s.[i] <- '_'
     done;
     s

(* this name is a default one created by glade? *)
let is_default_name s =
  let l = String.length s in
  let rec search p =
    if p < 0 then raise Not_found
    else
      match s.[p] with
      |	'0'..'9' -> search (p-1)
      |	_ -> p+1
  in
  try
    let pos = search (l-1) in
    pos > 0 && pos <> l
  with
  | _ -> false

let is_top_widget wtree w =
  match wtree.wchildren with
  | [w'] -> w.wcamlname = w'.wcamlname
  | _ -> false

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
  { wclass = wclass; wname = wname; wcamlname = camlize wname;
    wchildren = List.rev !widgets; wrapped = false }

let rec flatten_tree w =
  let children = List.map ~f:flatten_tree w.wchildren in
  w :: List.flatten children

let output_widget w =
  try
    let (modul, clas) = List.assoc w.wclass !classes in
    w.wrapped <- true;
    
    begin match clas with
    | "GList.clist" ->
  	printf "    val %s : int %s =\n" w.wcamlname clas
    | "GWindow.dialog" ->
  	printf "    val %s : [`NONE | `DELETE_EVENT | `ID of int] %s =\n"
          w.wcamlname clas
    | _ ->
        printf "    val %s =\n" w.wcamlname
    end;
  
    if !debug then 
      printf "      prerr_endline \"creating %s:%s\";\n" w.wclass w.wcamlname;
    printf "      new %s (%s.cast\n" clas modul;
    printf "        (%s ~name:\"%s\" ~info:\"%s\" xmldata))\n"
      "Glade.get_widget_msg" w.wname w.wclass;
    printf "    method %s = %s\n" w.wcamlname w.wcamlname
  with Not_found -> 
    warning (sprintf "Widget %s::%s is not supported" w.wname w.wclass)
;;

let roots = ref []
let embed = ref false
let trace = ref false
let output_classes = ref []

let output_wrapper ~file wtree =
  printf "class %s %s?domain ?autoconnect(*=true*) () =\n"
    wtree.wcamlname
    (if !embed then "" else
    if file = "<stdin>" then "~file " else "?(file=\"" ^ file ^ "\") ");
  output_classes := wtree.wcamlname :: !output_classes;
  printf "  let xmldata = Glade.create %s ~root:\"%s\" ?domain () in\n" 
    (if !embed then "~data " else "~file ")
    wtree.wname;
  print_string "  object (self)\n";
  printf
    "    inherit Glade.xml %s?autoconnect xmldata\n"
    (if !trace then "~trace:stderr " else "");
  let widgets = {wtree with wcamlname= "toplevel"} :: flatten_tree wtree in
  
  let is_hidden w = 
    w.wcamlname = "_" || 
    (!hide_default_names && not (is_top_widget wtree w) &&
     is_default_name w.wname)
  in
    
  List.iter (List.filter (fun w -> not (is_hidden w)) widgets) 
    ~f:output_widget;

  (* reparent method *)
  begin match wtree.wchildren with
  | [w] ->
      printf "    method reparent parent =\n";
      printf "      %s#misc#reparent parent;\n" w.wcamlname;
      printf "      toplevel#destroy ()\n";
  | _ -> ()
  end;
  
  printf "    method check_widgets () = ()\n";
  (* useless, since they are already built anyway
  List.iter widgets ~f:
    (fun w ->
      if w.wrapped then printf "      ignore self#%s;\n" w.wcamlname);
  *)
  printf "  end\n"

let output_check_all () =
  printf "\nlet check_all ?(show=false) () =\n";
  printf "  ignore (GMain.Main.init ());\n";
  List.iter (fun cl ->   
    printf "  let %s = new %s () in\n" cl cl;
    printf "  if show then %s#toplevel#show ();\n" cl;
    printf "  %s#check_widgets ();\n" cl) !output_classes;
  printf "  if show then GMain.Main.main ()\n";
  printf ";;\n";
;;
 
let parse_body ~file lexbuf =
  while match token lexbuf with
    Tag("project", _, closed) ->
      if not closed then while token lexbuf <> Endtag "project" do () done;
      true
  | Tag("widget", attrs, false) ->
      let wtree = 
	parse_widget ~wclass:(List.assoc "class" attrs)
	  ~wname:(List.assoc "id" attrs) lexbuf 
      in
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
    printf "(* Automatically generated from %s by lablgladecc *)\n\n"
      file;
    if !embed then printf "let data = \"%s\"\n\n" (String.escaped data);
    parse_body ~file lexbuf;
    output_check_all ()
  with Failure s ->
    eprintf "lablgladecc: in %s, before char %d, %s\n"
      file (Lexing.lexeme_start lexbuf) s

let output_test () =
  print_string "(* Test class definitions *)\n\n";
  print_string "class test xmldata =\n  object\n";
  List.iter !classes ~f:
    begin fun (clas, _) ->
      output_widget
        {wname = "a"^clas; wcamlname = camlize ("a"^clas);
	 wclass = clas; wchildren = []; wrapped = true}
    end;
  print_string "  end\n\n";
  print_string "let _ = print_endline \"lablgladecc test finished\"\n"

let main () =
  let files = ref [] and test = ref false in
  Arg.parse
    [ "-test", Arg.Set test, " check lablgladecc (takes no input)";
      "-embed", Arg.Set embed, " embed input file into generated program";
      "-trace", Arg.Set trace, " trace calls to handlers";
      "-debug", Arg.Set debug, " add debug code";
      "-root", Arg.String (fun s -> roots := s :: !roots),
      "<widget>  generate only a wrapper for <widget> and its children";
      "-hide-default", Arg.Set hide_default_names, 
        " hide widgets with default names like 'label23'"
    ]
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
