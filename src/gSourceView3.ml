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

open Gaux
open GtkSourceView3
open SourceView3Enums
open Gobject
open Gtk
open GtkBase
open GtkSourceView3_types
open OgtkSourceView3Props
open GObj

let get_bool = function `BOOL x -> x | _ -> assert false
let bool x = `BOOL x
let get_uint = function `INT x -> x | _ -> assert false
let uint x = `INT x
let get_int = function `INT x -> x | _ -> assert false
let int x = `INT x
let get_gobject = function `OBJECT x -> x | _ -> assert false
let gobject x = `OBJECT (Some x)

let map_opt f = function
    None -> None
  | Some x -> Some (f x)

(** {2 GtkSourceTag} *)

type source_tag_property = [
  | `BACKGROUND of Gdk.color
  | `BOLD of bool
  | `FOREGROUND of Gdk.color
  | `ITALIC of bool
  | `STRIKETHROUGH of bool
  | `UNDERLINE of bool
]

let text_tag_property_of_source_tag_property = function
  | `BACKGROUND p -> `BACKGROUND_GDK p
  | `BOLD p -> `WEIGHT (if p then `BOLD else `NORMAL)
  | `FOREGROUND p -> `FOREGROUND_GDK p
  | `ITALIC p -> `STYLE (if p then `ITALIC else `NORMAL)
  | `STRIKETHROUGH p -> `STRIKETHROUGH p
  | `UNDERLINE p -> `UNDERLINE (if p then `SINGLE else `NONE)

(* Gtk.Color deactivated
let color_of_string s =
  Gdk.Color.alloc ~colormap: (Gdk.Color.get_system_colormap())
    (`NAME s)
*)

(** {2 GtkSourceStyleScheme} *)

class source_style_scheme (obj: GtkSourceView3_types.source_style_scheme obj) =
object(self)
  method as_source_style_scheme = obj
  method name = SourceStyleScheme.get_name obj
  method description = SourceStyleScheme.get_description obj
end


(** {2 GtkSourceStyleSchemeManager} *)

class source_style_scheme_manager
	(obj: GtkSourceView3_types.source_style_scheme_manager obj) =
  object(self)
    val obj = obj
    inherit source_style_scheme_manager_props

    method search_path =
      SourceStyleSchemeManager.get_search_path obj
    method set_search_path =
      SourceStyleSchemeManager.set_search_path obj
    method style_scheme_ids =
      SourceStyleSchemeManager.get_scheme_ids obj
    method style_scheme s =
      may_map (new source_style_scheme)
	(SourceStyleSchemeManager.get_scheme obj s)
  end

let source_style_scheme_manager ~default =
  let mgr =
    if default then SourceStyleSchemeManager.default ()
    else SourceStyleSchemeManager.new_ () in
  new source_style_scheme_manager mgr

(** {2 GtkSourceCompletionInfo} *)

class source_completion_info_signals
  (obj' : GtkSourceView3_types.source_completion_info obj) =
  object
    inherit GContainer.container_signals_impl obj'
    inherit source_completion_info_sigs
  end

class source_completion_info 
  (obj' : ([> GtkSourceView3_types.source_completion_info ] as 'a) obj) =
  object
    inherit GWindow.window obj'
    inherit source_completion_info_props
    method as_source_completion_info =
      (obj :> GtkSourceView3_types.source_completion_info obj)
    method widget =
      new GObj.widget (SourceCompletionInfo.get_widget obj)
    method set_widget (w : GObj.widget) =
      SourceCompletionInfo.set_widget obj w#as_widget
  end

(** {2 GtkSourceCompletionProposal} *)

class source_completion_proposal_signals
  (obj' : GtkSourceView3_types.source_completion_proposal obj) =
  object
    inherit ['a] gobject_signals (obj' : [> GtkSourceView3_types.source_completion_proposal ] obj)
    inherit source_completion_proposal_sigs
  end

class source_completion_proposal 
  (obj : GtkSourceView3_types.source_completion_proposal obj) =
  object
    val obj = obj
    method connect = new source_completion_proposal_signals obj
    method as_source_completion_proposal = obj
    inherit source_completion_proposal_props
  end

class source_completion_item
  (obj : GtkSourceView3_types.source_completion_proposal obj) =
  object
    inherit source_completion_proposal obj
    inherit source_completion_item_props
  end

let source_completion_item ?(label = "") ?(text = "") ?icon ?info () =
  new source_completion_item (SourceCompletionItem.new_ label text icon info)

let source_completion_item_with_markup ?(label = "") ?(text = "") ?icon ?info () =
  new source_completion_item (SourceCompletionItem.new_with_markup label text icon info)

let source_completion_item_from_stock ?(label = "") ?(text = "") ~stock ~info () =
  let stock = GtkStock.Item.lookup stock in
  let id = stock.GtkStock.stock_id in
  new source_completion_item (SourceCompletionItem.new_from_stock label text id info)

(** {2 GtkSourceCompletionProvider} *)

class source_completion_provider
  (obj' : GtkSourceView3_types.source_completion_provider obj) =
  object
    val obj = obj'
    method as_source_completion_provider = obj
    method icon = SourceCompletionProvider.get_icon obj
    method name = SourceCompletionProvider.get_name obj
    method populate (context : source_completion_context) =
      SourceCompletionProvider.populate obj context#as_source_completion_context
    method activation =
      SourceCompletionProvider.get_activation obj
    method matched (context : source_completion_context) =
      SourceCompletionProvider.match_ obj context#as_source_completion_context
    method info_widget (proposal : source_completion_proposal) =
      let widget = SourceCompletionProvider.get_info_widget obj proposal#as_source_completion_proposal in
      match widget with
      | None -> None
      | Some widget -> Some (new GObj.widget widget)
    method update_info (proposal : source_completion_proposal) (info : source_completion_info) =
      SourceCompletionProvider.update_info obj proposal#as_source_completion_proposal info#as_source_completion_info
    method start_iter (context : source_completion_context) (proposal : source_completion_proposal) =
      let iter = 
        SourceCompletionProvider.get_start_iter obj
          context#as_source_completion_context proposal#as_source_completion_proposal 
      in
      new GText.iter iter

    method activate_proposal (proposal : source_completion_proposal) (iter : GText.iter) =
      SourceCompletionProvider.activate_proposal obj proposal#as_source_completion_proposal iter#as_iter

    method interactive_delay =
      SourceCompletionProvider.get_interactive_delay obj 

    method priority =
      SourceCompletionProvider.get_priority obj 

  end

(** {2 GtkSourceCompletionContext} *)

and source_completion_context_signals
  (obj' : GtkSourceView3_types.source_completion_context obj) =
  object
    inherit ['a] gobject_signals (obj' : [> GtkSourceView3_types.source_completion_context ] obj)
    inherit source_completion_context_sigs
  end

and source_completion_context
  (obj' : GtkSourceView3_types.source_completion_context obj) =
  object
    val obj = obj'
    val iter_prop = {
      Gobject.name = "iter";
      conv = Gobject.Data.unsafe_pointer
    }
    inherit source_completion_context_props
    method as_source_completion_context = obj
    method activation = SourceCompletionContext.get_activation obj
    method add_proposals
      (provider : source_completion_provider) (proposals : source_completion_proposal list) b =
      let proposals = List.map (fun obj -> obj#as_source_completion_proposal) proposals in
      SourceCompletionContext.add_proposals obj
      provider#as_source_completion_provider proposals b
    method connect = new source_completion_context_signals obj'
    method iter =
      new GText.iter (Gobject.get iter_prop obj)

    method set_iter (iter : GText.iter) =
      Gobject.set iter_prop obj (iter#as_iter)
  end

class type custom_completion_provider =
  object
    method name : string
    method icon : GdkPixbuf.pixbuf option
    method populate : source_completion_context -> unit
    method matched : source_completion_context -> bool
    method activation : source_completion_activation_flags list
    method info_widget : source_completion_proposal -> GObj.widget option
    method update_info : source_completion_proposal -> source_completion_info -> unit
    method start_iter : source_completion_context -> source_completion_proposal -> GText.iter -> bool
    method activate_proposal : source_completion_proposal -> GText.iter -> bool
    method interactive_delay : int
    method priority : int
  end

let source_completion_provider (p : custom_completion_provider) : source_completion_provider =
  let of_context ctx = new source_completion_context ctx in
  let of_proposal prop = new source_completion_proposal prop in
  let of_info info = new source_completion_info info in
  let of_iter iter = new GText.iter iter in
  let as_opt_widget = function
  | None -> None
  | Some obj -> Some obj#as_widget
  in
  let completion_provider = {
    SourceCompletionProvider.provider_name = (fun () -> p#name);
    provider_icon = (fun () -> p#icon);
    provider_populate = (fun ctx -> p#populate (of_context ctx));
    provider_match = (fun ctx -> p#matched (of_context ctx));
    provider_activation = (fun () -> p#activation);
    provider_info_widget = (fun prop -> as_opt_widget (p#info_widget (of_proposal prop)));
    provider_update_info = (fun prop info -> p#update_info (of_proposal prop) (of_info info));
    provider_start_iter = (fun ctx prop iter -> p#start_iter (of_context ctx) (of_proposal prop) (of_iter iter));
    provider_activate_proposal = (fun prop iter -> p#activate_proposal (of_proposal prop) (of_iter iter));
    provider_interactive_delay = (fun () -> p#interactive_delay);
    provider_priority = (fun () -> p#priority);
  } in
  let obj = SourceCompletionProvider.new_ completion_provider in
  new source_completion_provider obj

(** {2 GtkSourceCompletion} *)

class source_completion_signals obj' =
object (self)
  inherit ['a] gobject_signals (obj' : [> GtkSourceView3_types.source_completion] obj)
  inherit source_completion_sigs
  method populate_context ~callback =
    let callback obj = callback (new source_completion_context obj) in
    self#connect SourceCompletion.S.populate_context ~callback
end

class source_completion
  (obj : GtkSourceView3_types.source_completion obj) =
  object
    val obj = obj
    inherit source_completion_props as super
    method as_source_completion = obj
    method connect = new source_completion_signals obj

    method create_context (iter : GText.iter) =
      let obj = SourceCompletion.create_context obj (iter#as_iter) in
      new source_completion_context obj

    method move_window (iter : GText.iter) =
      SourceCompletion.move_window obj (iter#as_iter)

    method show (prs : source_completion_provider list) (ctx : source_completion_context) =
      let prs = List.map (fun pr -> pr#as_source_completion_provider) prs in
      SourceCompletion.show obj prs ctx#as_source_completion_context

    method providers =
      let prs = SourceCompletion.get_providers obj in
      List.map (fun pr -> new source_completion_provider pr) prs

    method add_provider (pr : source_completion_provider) =
      SourceCompletion.add_provider obj (pr#as_source_completion_provider)

    method remove_provider (pr : source_completion_provider) =
      SourceCompletion.remove_provider obj (pr#as_source_completion_provider)

  end

(** {2 GtkSourceLanguage} *)

class source_language (obj: GtkSourceView3_types.source_language obj) =
object (self)
  method as_source_language = obj
  val obj = obj
  method misc = new gobject_ops obj

  method id = SourceLanguage.get_id obj
  method name = SourceLanguage.get_name obj
  method section = SourceLanguage.get_section obj
  method hidden = SourceLanguage.get_hidden obj

  method metadata s = SourceLanguage.metadata obj s
  method mime_types = SourceLanguage.mime_types obj
  method globs = SourceLanguage.globs obj
  method style_name s = SourceLanguage.style_name obj s
  method style_ids = SourceLanguage.style_ids obj
end

(** {2 GtkSourceLanguageManager} *)

class source_language_manager
  (obj: GtkSourceView3_types.source_language_manager obj) =
object (self)
  method get_oid = Gobject.get_oid obj
  method as_source_language_manager = obj

  method set_search_path p = SourceLanguageManager.set_search_path obj p
  method search_path = SourceLanguageManager.search_path obj
  method language_ids = SourceLanguageManager.language_ids obj

  method language id =
    may_map
      (new source_language)
      (SourceLanguageManager.language obj id )

  method guess_language ?filename ?content_type () =
    may_map
      (new source_language)
      (SourceLanguageManager.guess_language obj filename content_type)
end

let source_language_manager ~default =
  new source_language_manager
    (if default then SourceLanguageManager.default ()
     else SourceLanguageManager.create [])


(** {2 GtkSourceMark} *)

class source_mark  (obj: GtkSourceView3_types.source_mark obj) =
object (self)
  method coerce = (`MARK (GtkText.Mark.cast obj):GText.mark)
  method as_source_mark = obj
  val obj = obj
  inherit source_mark_props

  method next ?category () =
    may_map (fun m -> new source_mark m) (SourceMark.next obj category)
  method prev ?category () =
    may_map (fun m -> new source_mark m) (SourceMark.prev obj category)

end

let source_mark ?category () =
  new source_mark (SourceMark.create ?category [])

(** {2 GtkSourceMarkAttributes} *)

class source_mark_attributes (obj: GtkSourceView3_types.source_mark_attributes obj)
=
object (self)
  method as_source_mark_attributes = obj
  val obj = obj
  inherit source_mark_attributes_props
end

let source_mark_attributes () =
  let obj = SourceMarkAttributes.create [] in
  new source_mark_attributes obj

(** {2 GtkSourceUndoManager} *)

class source_undo_manager_signals obj' =
object (self)
  inherit ['a] gobject_signals (obj' : [> GtkSourceView3_types.source_undo_manager] obj)
  inherit source_undo_manager_sigs
end

class source_undo_manager
  (obj : GtkSourceView3_types.source_undo_manager obj) =
  object
    val obj = obj
    inherit source_undo_manager_props
    method as_source_undo_manager = obj
    method connect = new source_undo_manager_signals obj
  end

class type custom_undo_manager =
  object
    method can_undo : bool
    method can_redo : bool
    method undo : unit -> unit
    method redo : unit -> unit
    method begin_not_undoable_action : unit -> unit
    method end_not_undoable_action : unit -> unit
    method can_undo_changed : unit -> unit
    method can_redo_changed : unit -> unit
  end

let source_undo_manager (manager : custom_undo_manager) : source_undo_manager =
  let undo_manager = {
    SourceUndoManager.can_undo = (fun () -> manager#can_undo);
    can_redo = (fun () -> manager#can_redo);
    undo = manager#undo;
    redo = manager#redo;
    begin_not_undoable_action = manager#begin_not_undoable_action;
    end_not_undoable_action = manager#end_not_undoable_action;
    can_undo_changed = manager#can_undo_changed;
    can_redo_changed = manager#can_redo_changed;
  } in
  let obj = SourceUndoManager.new_ undo_manager in
  new source_undo_manager obj

(** {2 GtkSourceBuffer} *)

class source_buffer_signals obj' =
object
  inherit ['a] gobject_signals (obj' : [> GtkSourceView3_types.source_buffer] obj)
  inherit GText.buffer_signals_skel
  inherit source_buffer_sigs
end

and source_buffer (_obj: GtkSourceView3_types.source_buffer obj) =
object (self)
  inherit GText.buffer_skel _obj as text_buffer
  val obj = _obj
  method private obj = _obj
  inherit source_buffer_props
  method as_source_buffer = obj
  method connect = new source_buffer_signals obj
  method misc = new gobject_ops obj
  method language = may_map (new source_language) (get SourceBuffer.P.language obj)
  method set_language (l:source_language option) =
    set SourceBuffer.P.language obj
      (may_map (fun l -> l#as_source_language) l)

  method style_scheme =
    may_map (new source_style_scheme) (get SourceBuffer.P.style_scheme obj)
  method set_style_scheme (s:source_style_scheme option) =
      match s with
        None -> ()
      | Some scheme -> set SourceBuffer.P.style_scheme obj
          (Some scheme#as_source_style_scheme)

  method undo () = SourceBuffer.undo obj
  method redo () = SourceBuffer.redo obj
  method begin_not_undoable_action () =
    SourceBuffer.begin_not_undoable_action obj
  method end_not_undoable_action () =
    SourceBuffer.end_not_undoable_action obj

  method create_source_mark ?name ?category (iter:GText.iter) =
    new source_mark(SourceBuffer.create_source_mark obj name category iter#as_iter)

  method source_marks_at_line ?category line =
    List.map
      (fun mark -> new source_mark mark)
      (SourceBuffer.get_source_marks_at_line obj line category)

  method source_marks_at_iter ?category (iter:GText.iter) =
    List.map
      (fun mark -> new source_mark mark)
      (SourceBuffer.get_source_marks_at_iter obj iter#as_iter category)

  method remove_source_marks ?category ~(start:GText.iter) ~(stop:GText.iter) () =
    SourceBuffer.remove_source_marks obj start#as_iter stop#as_iter category

  method forward_iter_to_source_mark ?category (iter:GText.iter) =
    SourceBuffer.forward_iter_to_source_mark obj iter#as_iter category

  method backward_iter_to_source_mark ?category (iter:GText.iter) =
    SourceBuffer.backward_iter_to_source_mark obj iter#as_iter category

  method iter_has_context_class (iter:GText.iter) context_class =
    SourceBuffer.iter_has_context_class obj iter#as_iter context_class

  method iter_forward_to_context_class_toggle (iter:GText.iter) context_class =
    SourceBuffer.iter_forward_to_context_class_toggle obj iter#as_iter context_class

  method iter_backward_to_context_class_toggle (iter:GText.iter) context_class =
    SourceBuffer.iter_backward_to_context_class_toggle obj iter#as_iter context_class

  method ensure_highlight ~(start:GText.iter) ~(stop:GText.iter) =
    SourceBuffer.ensure_highlight obj start#as_iter stop#as_iter

  method set_undo_manager (manager : source_undo_manager) =
    let manager = manager#as_source_undo_manager in
    Gobject.set SourceBuffer.P.undo_manager obj manager

  method undo_manager =
    let manager = Gobject.get SourceBuffer.P.undo_manager obj in
    new source_undo_manager manager

end

let source_buffer ?(language:source_language option)
  ?(style_scheme:source_style_scheme option)
  ?(tag_table : GText.tag_table option) ?text ?(undo_manager : source_undo_manager option)  =
  let language =
    match language with
    | None -> None
    | Some source_language -> Some (source_language#as_source_language)
  in
  let style_scheme =
    match style_scheme with
    | None -> None
    | Some schm -> Some (schm#as_source_style_scheme)
  in
  let undo_manager =
    match undo_manager with
    | None -> None
    | Some manager -> Some (manager#as_source_undo_manager)
  in
  SourceBuffer.make_params [] ?language ?style_scheme ?undo_manager
    ~cont:(fun pl () ->
      let buf =
	match tag_table with
	  None ->
	    new source_buffer (SourceBuffer.create pl)
	| Some tt ->
	    let obj = SourceBuffer.new_ tt#as_tag_table in
	    Gobject.set_params (Gobject.try_cast obj "GtkSourceBuffer") pl;
	    new source_buffer obj
      in
      (match text with
      | None -> ()
      | Some text -> buf#set_text text);
      buf)

(** {2 GtkSourceView} *)

class source_view_signals obj' =
object
  inherit widget_signals_impl (obj' : [> GtkSourceView3_types.source_view] obj)
  inherit GText.view_signals obj'
  inherit source_view_sigs
end

class source_view (obj': GtkSourceView3_types.source_view obj) =
object (self)
  inherit GText.view_skel obj'
  inherit source_view_props

  val source_buf =
    let buf_obj =
      Gobject.try_cast (GtkText.View.get_buffer obj') "GtkSourceBuffer"
    in
    new source_buffer buf_obj
  method source_buffer = source_buf
  method connect = new source_view_signals obj'

  method set_cursor_color = SourceView.set_cursor_color obj
(*  method set_cursor_color_by_name s = SourceView.set_cursor_color obj (color_of_string s)*)

  method draw_spaces = SourceView.get_draw_spaces obj
  method set_draw_spaces flags = SourceView.set_draw_spaces obj flags

  method completion = new source_completion (SourceView.get_completion obj)

  method set_mark_attributes ~category (attrs: source_mark_attributes) priority =
    SourceView.set_mark_attributes
      obj ~category attrs#as_source_mark_attributes priority

  method get_mark_attributes ~category =
    match SourceView.get_mark_attributes obj category with
    | Some obj -> Some (new source_mark_attributes obj)
    | None -> None

  method get_mark_priority ~category = SourceView.get_mark_priority obj category

end

let source_view ?source_buffer ?draw_spaces =
  SourceView.make_params [] ~cont:(
    GtkText.View.make_params ~cont:(
      GContainer.pack_container ~create:(fun pl ->
        let obj =
          match source_buffer with
          | Some buf ->
              SourceView.new_with_buffer
                (Gobject.try_cast buf#as_buffer "GtkSourceBuffer")
          | None -> SourceView.new_ ()
        in
        Gobject.set_params (Gobject.try_cast obj "GtkSourceView") pl;
	may (SourceView.set_draw_spaces obj) draw_spaces;
        new source_view obj)))

(** {2 Misc} *)

(*
let iter_forward_search (iter:GText.iter) flags
    ~start ~stop ?limit str =
  let limit = map_opt (fun x -> x#as_iter) limit in
  match SourceViewMisc.iter_forward_search iter#as_iter str
      flags ~start: start#as_iter ~stop: stop#as_iter limit
  with
    None -> None
  | Some (it1,it2) -> Some (new GText.iter it1, new GText.iter it2)

let iter_backward_search (iter:GText.iter) flags
    ~start ~stop ?limit str =
  let limit = map_opt (fun x -> x#as_iter) limit in
  match SourceViewMisc.iter_backward_search iter#as_iter str
      flags ~start: start#as_iter ~stop: stop#as_iter limit
  with
    None -> None
  | Some (it1,it2) -> Some (new GText.iter it1, new GText.iter it2)
*)
