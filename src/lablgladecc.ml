(**************************************************************************)
(*                Lablgtk                                                 *)
(*                                                                        *)
(*    This program is free software; you can redistribute it              *)
(*    and/or modify it under the terms of the GNU Library General         *)
(*    Public License as published by the Free Software Foundation         *)
(*    version 2, with the exception described in file COPYING which       *)
(*    comes with the library.                                             *)
(*                                                                        *)
(*    This program is distributed in the hope that it will be useful,     *)
(*    but WITHOUT ANY WARRANTY; without even the implied warranty of      *)
(*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the       *)
(*    GNU Library General Public License for more details.                *)
(*                                                                        *)
(*    You should have received a copy of the GNU Library General          *)
(*    Public License along with this program; if not, write to the        *)
(*    Free Software Foundation, Inc., 59 Temple Place, Suite 330,         *)
(*    Boston, MA 02111-1307  USA                                          *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)

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
  (* CSC: GLists no longer bound
  "GtkListItem", ("GtkList.ListItem", "GList.list_item");
  "GtkList", ("GtkList.Liste", "GList.liste");
  "GtkCList", ("GtkList.CList", "GList.clist");*)
  (* CSC: I have no idea how to biind GWindow.message_dialog that has a
     Construct Only ~buttons parameter
  "GtkMessageDialog", ("GtkWindow.MessageDialog", "GWindow.message_dialog");*)
  (* CSC: for some reason GtkComboBoxText functionality has been replicated
     by hand instead of using the existent machinery
  "GtkComboBoxText", ("GtkEdit.ComboBoxText", "GEdit.combo_box_text");*)
(* CSC: GtkOrientable is not fully implemented
  "GtkOrientable", ("", "");*)
  "GtkAboutDialog", ("GtkWindow.AboutDialog", "GWindow.about_dialog");
  "GtkAction", ("GtkActionProps.Action", "GAction.action");
  "GtkActionGroup", ("GtkActionProps.ActionGroup", "GAction.action_group");
  "GtkAdjustment", ("GtkBaseProps.Adjustment", "GData.adjustment");
  "GtkAlignment", ("GtkBin.Alignment", "GBin.alignment");
  "GtkArrow", ("GtkMisc.Arrow", "GMisc.arrow");
  "GtkAspectFrame", ("GtkBin.AspectFrame", "GBin.aspect_frame");
  "GtkAssistant", ("GtkAssistant.Assistant", "GAssistant.assistant");
  "GtkBBox", ("GtkPack.BBox", "GPack.button_box");
  "GtkBin", ("GtkBase.Container", "GContainer.container");
  "GtkBox", ("GtkPack.Box", "GPack.box");
  "GtkBuilder", ("GtkBuilder.Builder", "GBuilder.builder");
  "GtkButton", ("GtkButton.Button", "GButton.button");
  "GtkButtonBox", ("GtkPack.BBox", "GPack.button_box");
  "GtkCTree", ("GtkBase.Container", "GContainer.container");
  "GtkCalendar", ("GtkMisc.Calendar", "GMisc.calendar");
  "GtkCellLayout", ("GtkTree.CellLayout", "GTree.cell_layout");
  "GtkCellRendererAccel", ("GtkTree.CellRendererAccel", "GTree.cell_renderer_accel");
  "GtkCellRendererCombo", ("GtkTree.CellRendererCombo", "GTree.cell_renderer_combo");
  "GtkCellRendererPixbuf", ("GtkTree.CellRendererPixbuf", "GTree.cell_renderer_pixbuf");
  "GtkCellRendererProgress", ("GtkTree.CellRendererProgress", "GTree.cell_renderer_progress");
  "GtkCellRendererText", ("GtkTree.CellRendererText", "GTree.cell_renderer_text");
  "GtkCellRendererToggle", ("GtkTree.CellRendererToggle", "GTree.cell_renderer_toggle");
  "GtkCheckButton", ("GtkButton.ToggleButton", "GButton.toggle_button");
  "GtkCheckMenuItem", ("GtkMenu.CheckMenuItem", "GMenu.check_menu_item");
  "GtkColorButton", ("GtkButton.ColorButton", "GButton.color_button");
  "GtkColorSelection", ("GtkMisc.ColorSelection", "GMisc.color_selection");
  "GtkComboBox", ("GtkEdit.ComboBox", "GEdit.combo_box");
  "GtkContainer", ("GtkBase.Container", "GContainer.container");
  "GtkCurve", ("GtkMisc.DrawingArea", "GMisc.drawing_area");
  "GtkDialog", ("GtkWindow.Dialog", "GWindow.dialog_any");
  "GtkDrawingArea", ("GtkMisc.DrawingArea", "GMisc.drawing_area");
  "GtkEditable", ("GtkEdit.Editable", "GEdit.editable");
  "GtkEntry", ("GtkEdit.Entry", "GEdit.entry");
  "GtkEntryCompletion", ("GtkEdit.EntryCompletion", "GEdit.entry_completion");
  "GtkEventBox", ("GtkBin.EventBox", "GBin.event_box");
  "GtkExpander", ("GtkBin.Expander", "GBin.expander");
  "GtkFileChooserButton", ("GtkFile.FileChooserButton", "GFile.chooser_button");
  "GtkFixed", ("GtkPack.Fixed", "GPack.fixed");
  "GtkFontButton", ("GtkButton.FontButton", "GButton.font_button");
  "GtkFontSelection", ("GtkMisc.FontSelection", "GMisc.font_selection");
  "GtkFrame", ("GtkBin.Frame", "GBin.frame");
  "GtkGrid", ("GtkPack.Grid", "GPack.grid");
  "GtkHBox", ("GtkPack.Box", "GPack.box");
  "GtkHButtonBox", ("GtkPack.BBox", "GPack.button_box");
  "GtkHPaned", ("GtkPack.Paned", "GPack.paned");
  "GtkHScale", ("GtkRange.Scale", "GRange.scale");
  "GtkHScrollbar", ("GtkRange.Scrollbar", "GRange.range");
  "GtkHSeparator", ("GtkMisc.Separator", "GObj.widget_full");
  "GtkHandleBox", ("GtkBin.HandleBox", "GBin.handle_box");
  "GtkIconView", ("GtkTree.IconView", "GTree.icon_view");
  "GtkImage", ("GtkMisc.Image", "GMisc.image");
  "GtkInputDialog", ("GtkWindow.Dialog", "GWindow.dialog");
  "GtkInvisible", ("GtkBase.Container", "GContainer.container");
  "GtkItem", ("GtkBase.Container", "GContainer.container");
  "GtkLabel", ("GtkMisc.Label", "GMisc.label");
  "GtkLayout", ("GtkPack.Layout", "GPack.layout");
  "GtkLinkButton", ("GtkButton.LinkButton", "GButton.link_button");
  "GtkListStore", ("GtkTree.ListStore", "GTree.list_store");
  "GtkMenu", ("GtkMenu.Menu", "GMenu.menu");
  "GtkMenuBar", ("GtkMenu.MenuBar", "GMenu.menu_shell");
  "GtkMenuItem", ("GtkMenu.MenuItem", "GMenu.menu_item");
  "GtkMenuShell", ("GtkMenu.MenuShell", "GMenu.menu_shell");
  "GtkMenuToolButton", ("GtkButton.MenuToolButton", "GButton.menu_tool_button");
  "GtkMisc", ("GtkMisc.Misc", "GMisc.misc");
  "GtkNotebook", ("GtkPack.Notebook", "GPack.notebook");
  "GtkPaned", ("GtkPack.Paned", "GPack.paned");
  "GtkPixmap", ("GtkMisc.Image", "GMisc.image");
  "GtkPlug", ("GtkWindow.Plug", "GWindow.plug");
  "GtkProgressBar", ("GtkRange.ProgressBar", "GRange.progress_bar");
  "GtkRadioAction", ("GtkActionProps.RadioAction", "GAction.radio_action");
  "GtkRadioButton", ("GtkButton.RadioButton", "GButton.radio_button");
  "GtkRadioMenuItem", ("GtkMenu.RadioMenuItem", "GMenu.radio_menu_item");
  "GtkRadioToolButton", ("GtkButton.RadioToolButton", "GButton.radio_tool_button");
  "GtkRange", ("GtkRange.Range", "GRange.range");
  "GtkScale", ("GtkRange.Scale", "GRange.scale");
  "GtkScrollbar", ("GtkRange.Scrollbar", "GRange.range");
  "GtkScrolledWindow", ("GtkBin.ScrolledWindow", "GBin.scrolled_window");
  "GtkSeparator", ("GtkMisc.Separator", "GObj.widget_full");
  "GtkSeparatorMenuItem", ("GtkMenu.MenuItem", "GMenu.menu_item");
  "GtkSeparatorToolItem", ("GtkButton.SeparatorToolItem", "GButton.separator_tool_item");
  "GtkSizeGroup", ("GtkPack.SizeGroup", "GPack.size_group");
  "GtkSocket", ("GtkWindow.Socket", "GWindow.socket");
  "GtkSourceBuffer", ("GtkSourceView3.SourceBuffer", "GSourceView3.source_buffer");
  "GtkSourceCompletion", ("GtkSourceView3.SourceCompletion", "GSourceView3.source_completion");
  "GtkSourceCompletionContext", ("GtkSourceView3.SourceCompletionContext", "GSourceView3.source_completion_context");
  "GtkSourceCompletionInfo", ("GtkSourceView3.SourceCompletionInfo", "GSourceView3.source_completion_info");
  "GtkSourceCompletionItem", ("GtkSourceView3.SourceCompletionItem", "GSourceView3.source_completion_item");
  "GtkSourceCompletionProposal", ("GtkSourceView3Props.SourceCompletionProposal", "GSourceView3.source_completion_proposal");
  "GtkSourceCompletionProvider", ("GtkSourceView3.SourceCompletionProvider", "GSourceView3.source_completion_provider");
  "GtkSourceLanguage", ("GtkSourceView3.SourceLanguage", "GSourceView3.source_language");
  "GtkSourceLanguageManager", ("GtkSourceView3.SourceLanguageManager", "GSourceView3.source_language_manager");
  "GtkSourceMark", ("GtkSourceView3.SourceMark", "GSourceView3.source_mark");
  "GtkSourceStyleScheme", ("GtkSourceView3.SourceStyleScheme", "GSourceView3.source_style_scheme");
  "GtkSourceStyleSchemeManager", ("GtkSourceView3.SourceStyleSchemeManager", "GSourceView3.source_style_scheme_manager");
  "GtkSourceUndoManager", ("GtkSourceView3.SourceUndoManager", "GSourceView3.source_undo_manager");
  "GtkSourceView", ("GtkSourceView3.SourceView", "GSourceView3.source_view");
  "GtkSpinButton", ("GtkEdit.SpinButton", "GEdit.spin_button");
  "GtkStatusIcon", ("GtkMisc.StatusIcon", "GMisc.status_icon");
  "GtkStatusbar", ("GtkMisc.Statusbar", "GMisc.statusbar");
  "GtkTable", ("GtkPack.Table", "GPack.table");
  "GtkTearoffMenuItem", ("GtkMenu.MenuItem", "GMenu.menu_item");
  "GtkTextBuffer", ("GtkText.Buffer", "GText.buffer");
  "GtkTextChildAnchor", ("GtkText.ChildAnchor", "GText.child_anchor");
  "GtkTextTag", ("GtkText.Tag", "GText.tag");
  "GtkTextTagTable", ("GtkText.TagTable", "GText.tag_table");
  "GtkTextView", ("GtkText.View", "GText.view");
  "GtkToggleAction", ("GtkActionProps.ToggleAction", "GAction.toggle_action");
  "GtkToggleButton", ("GtkButton.ToggleButton", "GButton.toggle_button");
  "GtkToggleToolButton", ("GtkButton.ToggleToolButton", "GButton.toggle_tool_button");
  "GtkToolButton", ("GtkButton.ToolButton", "GButton.tool_button");
  "GtkToolItem", ("GtkButton.ToolItem", "GButton.tool_item");
  "GtkToolbar", ("GtkButton.Toolbar", "GButton.toolbar");
  "GtkTreeModel", ("GtkTree.TreeModel", "GTree.model");
  "GtkTreeModelFilter", ("GtkTree.TreeModelFilter", "GTree.model_filter");
  "GtkTreeModelSort", ("GtkTree.TreeModelSort", "GTree.model_sort");
  "GtkTreeSelection", ("GtkTree.TreeSelection", "GTree.selection");
  "GtkTreeSortable", ("GtkTree.TreeSortable", "GTree.tree_sortable");
  "GtkTreeStore", ("GtkTree.TreeStore", "GTree.tree_store");
  "GtkTreeView", ("GtkTree.TreeView", "GTree.view");
  "GtkTreeViewColumn", ("GtkTree.TreeViewColumn", "GTree.view_column");
  "GtkUIManager", ("GtkActionProps.UIManager", "GAction.ui_manager");
  "GtkVBox", ("GtkPack.Box", "GPack.box");
  "GtkVButtonBox", ("GtkPack.BBox", "GPack.button_box");
  "GtkVPaned", ("GtkPack.Paned", "GPack.paned");
  "GtkVScale", ("GtkRange.Scale", "GRange.scale");
  "GtkVScrollbar", ("GtkRange.Scrollbar", "GRange.range");
  "GtkVSeparator", ("GtkMisc.Separator", "GObj.widget_full");
  "GtkViewport", ("GtkBin.Viewport", "GBin.viewport");
  "GtkWidget", ("GtkBase.Widget", "GObj.widget_full");
  "GtkWindow", ("GtkWindow.Window", "GWindow.window");
  "PangoContext", ("Pango.Context", "GPango.context");
  "button", ("GtkButton.Button", "GButton.button");
] 

open Xml_lexer

let parse_header lexbuf =
  match token lexbuf with 
  | Tag ("interface",_,_) -> ()
  | _ -> failwith "no interface declaration" 

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
    winternal: bool;
    wchildren: wtree list;
    mutable wrapped: bool;
  }

exception Unsupported

(* map arbitrary strings to caml identifiers. Clashes may occur! *) 

let camlize s = match s with 
  | "" -> "_"
  |  s -> let s = String.uncapitalize_ascii s in
     let s = Bytes.unsafe_of_string s in
     for i = 0 to Bytes.length s - 1 do 
       match Bytes.get s i with
       | 'a'..'z'| 'A'..'Z' | '0'..'9' -> ()
       | _ -> Bytes.set s i '_'
     done;
     Bytes.unsafe_to_string s

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
  | [w'] -> w.wcamlname = w'.wcamlname && not w.winternal
  | _ -> false

let rec skip_to_endtag lexbuf =
 match token lexbuf with
  | Tag("object",_,_) ->
     (* CSC: if this can happen, then the code logic (coming from
        lablgtk2 code) needs to be rewritten completely. *)
     assert false
  | Tag(t,_,true) -> skip_to_endtag lexbuf
  | Tag(t,_,false) -> skip_to_endtag lexbuf ; skip_to_endtag lexbuf
  | Chars _ -> skip_to_endtag lexbuf
  | Endtag t -> ()
  | EOF -> assert false

let assoc_opt x l = try Some (List.assoc x l) with Not_found -> None

let rec parse_widget ~closed ~wclass ~wname ~internal lexbuf =
  let widgets = ref [] in
  while (not closed) && match token lexbuf with
  | Tag ("object", attrs, closed) ->
     widgets := parse_widget ~closed ~wclass:(assoc_opt "class" attrs)
                 ~internal ~wname:(assoc_opt "id" attrs) lexbuf
               @ !widgets;
     true
  | Tag ("child",attrs,true) -> assert false
  | Tag ("child",attrs,false) ->
      let is_internal =
	try List.assoc "internal-child" attrs <> "" with Not_found -> false in
      Stack.push is_internal internal;
      true
  | Endtag "child" -> ignore(Stack.pop internal); true
  | Tag (tag,_,closed) ->
      if not closed then skip_to_endtag lexbuf ; true
  | Endtag "object" ->
      false
  | Chars _ ->
      true
  | Endtag _ | EOF ->
      failwith "bad XML syntax"
  do () done;
  let internal = try Stack.top internal with _ -> false in
  match wclass,wname with
     Some wclass, Some wname ->
      [{ wclass = wclass; wname = wname; wcamlname = camlize wname;
         winternal = internal; wchildren = List.rev !widgets;
         wrapped = false }]
   | _,_ -> []

let rec flatten_tree w =
  let children = List.map ~f:flatten_tree w.wchildren in
  w :: List.flatten children

let output_widget w =
  try
    let (modul, clas) = List.assoc w.wclass !classes in
    w.wrapped <- true;
    
    begin match clas with
    (*| "GList.clist" ->
  	printf "    val %s : int %s =\n" w.wcamlname clas*)
    | "GWindow.dialog" ->
  	printf "    val %s : [`DELETE_EVENT] %s =\n" w.wcamlname clas
    | _ ->
        printf "    val %s =\n" w.wcamlname
    end;
  
    if !debug then 
      printf "      prerr_endline \"creating %s:%s\";\n" w.wclass w.wcamlname;
    printf "      new %s (%s.cast (builder#get_object \"%s\"))\n" clas modul w.wname;
    printf "    method %s = %s\n" w.wcamlname w.wcamlname
  with Not_found -> 
    warning (sprintf "Widget %s::%s is not supported" w.wname w.wclass)
;;

let roots = ref []
let embed = ref false
let output_classes = ref []

let output_wrapper ~file wtree =
  printf "class %s ?translation_domain () =\n" wtree.wcamlname ;
  output_classes := wtree.wcamlname :: !output_classes;
  printf " let builder = GBuilder.builder_new ?translation_domain () in\n";
  if !embed then
   printf " let _ = builder#add_objects_from_string data [\"%s\"] in\n"
    wtree.wname
  else
   printf " let _ = builder#add_objects_from_file \"%s\" [\"%s\"] in\n"
    file wtree.wname ;
  print_string "  object\n";
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
      if not (is_hidden w) then
          printf "      %s#misc#reparent parent;\n" w.wcamlname;
      printf "      toplevel#destroy ()\n";
  | _ -> ()
  end;
  printf "  end\n"

let parse_body ~file lexbuf =
  while match token lexbuf with
  | Tag("object", attrs, closed) ->
     (match
	parse_widget ~closed ~wclass:(assoc_opt "class" attrs)
	  ~internal:(Stack.create ())
	  ~wname:(assoc_opt "id" attrs) lexbuf 
      with
       | _::_::_ -> assert false
       | [] -> ()
       | [wtree] ->
          let rec output_roots wtree =
           if List.mem wtree.wname ~set:!roots then
            output_wrapper ~file wtree;
           List.iter ~f:output_roots wtree.wchildren
          in
          if !roots = [] then output_wrapper ~file wtree
          else output_roots wtree) ;
      true
  | Tag(tag, _, true) -> true
  | Endtag "interface" -> false
  | Tag(_, _, false) | Chars _ | EOF | Endtag _ -> failwith "bad XML syntax"
  do () done

let process ?(file="<stdin>") chan =
  let lexbuf, data =
    if !embed then begin
      let b = Buffer.create 1024 in
      let buf = String.create 1024 in
      while
        let len = input chan buf 0 1024 in
        Buffer.add_subbytes b buf 0 len;
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
  with Failure s ->
    eprintf "lablgladecc: in %s, before char %d, %s\n"
      file (Lexing.lexeme_start lexbuf) s

let output_test () =
  print_string "(* Test class definitions *)\n\n";
  print_string "let builder = GBuilder.builder_new ();;\n\n";
  print_string "class test () =\n  object\n";
  List.iter !classes ~f:
    begin fun (clas, _) ->
      output_widget
        {wname = "a"^clas; wcamlname = camlize ("a"^clas); winternal=false;
	 wclass = clas; wchildren = []; wrapped = true}
    end;
  print_string "  end\n\n";
  print_string "let _ = print_endline \"lablgladecc test finished\"\n"

let main () =
  let files = ref [] and test = ref false in
  Arg.parse
    [ "-test", Arg.Set test, " check lablgladecc (takes no input)";
      "-embed", Arg.Set embed, " embed input file into generated program";
      "-debug", Arg.Set debug, " add debug code";
      "-root", Arg.String (fun s -> roots := s :: !roots),
      "<widget>  generate only a wrapper for <widget> and its children";
      "-hide-default", Arg.Set hide_default_names, 
        " hide widgets with default names like 'label23'";
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
