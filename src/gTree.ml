(* $Id$ *)

open StdLabels
open Gaux
open Gtk
open GtkBase
open GtkTree
open GObj
open GContainer

class tree_item_signals obj = object
  inherit item_signals obj
  method expand = GtkSignal.connect obj ~sgn:TreeItem.Signals.expand ~after
  method collapse = GtkSignal.connect obj ~sgn:TreeItem.Signals.collapse ~after
end

class tree_item obj = object
  inherit container obj
  method event = new GObj.event_ops obj
  method as_item : Gtk.tree_item obj = obj
  method connect = new tree_item_signals obj
  method set_subtree (w : tree) = TreeItem.set_subtree obj w#as_tree
  method remove_subtree () = TreeItem.remove_subtree obj
  method expand () = TreeItem.expand obj
  method collapse () = TreeItem.collapse obj
  method subtree =
    try Some(new tree (TreeItem.subtree obj)) with Gpointer.Null -> None
end

and tree_signals obj = object
  inherit container_signals obj
  method selection_changed =
    GtkSignal.connect obj ~sgn:Tree.Signals.selection_changed ~after
  method select_child ~callback =
    GtkSignal.connect obj ~sgn:Tree.Signals.select_child ~after
      ~callback:(fun w -> callback (new tree_item (TreeItem.cast w))) 
  method unselect_child ~callback =
    GtkSignal.connect obj ~sgn:Tree.Signals.unselect_child ~after
      ~callback:(fun w -> callback (new tree_item (TreeItem.cast w))) 
end

and tree obj = object (self)
  inherit [tree_item] item_container obj
  method event = new GObj.event_ops obj
  method as_tree = (obj :> Gtk.tree obj)
  method insert w ~pos = Tree.insert obj w#as_item ~pos
  method connect = new tree_signals obj
  method clear_items = Tree.clear_items obj
  method select_item = Tree.select_item obj
  method unselect_item = Tree.unselect_item obj
  method child_position (w : tree_item) = Tree.child_position obj w#as_item
  method remove_items items =
    Tree.remove_items obj
      (List.map ~f:(fun (t : tree_item) -> t#as_item) items)
  method set_selection_mode = Tree.set_selection_mode obj
  method set_view_mode = Tree.set_view_mode obj
  method set_view_lines = Tree.set_view_lines obj
  method selection =
    List.map ~f:(fun w -> self#wrap (w :> Gtk.widget obj)) (Tree.selection obj)
  method private wrap w =
    new tree_item (TreeItem.cast w)
end

let tree_item ?label ?border_width ?width ?height ?packing ?show () =
  let w = TreeItem.create ?label () in
  Container.set w ?border_width ?width ?height;
  let self = new tree_item w in
  may packing ~f:(fun f -> (f self : unit));
  if show <> Some false then self#misc#show ();
  self

let tree ?selection_mode ?view_mode ?view_lines
    ?border_width ?width ?height ?packing ?show () =
  let w = Tree.create () in
  Tree.set w ?selection_mode ?view_mode ?view_lines;
  Container.set w ?border_width ?width ?height;
  pack_return (new tree w) ~packing ~show


module Data = struct
type kind =
    [ `BOOLEAN
    | `CHAR
    | `UCHAR
    | `INT
    | `UINT
    | `LONG
    | `ULONG
    | `INT64
    | `UINT64
    | `ENUM
    | `FLAGS
    | `FLOAT
    | `DOUBLE
    | `STRING
    | `POINTER
    | `BOXED
    | `OBJECT ]

type 'a conv =
    { kind: kind;
      proj: (Gobject.data_get -> 'a);
      inj: ('a -> unit Gobject.data_set) }
let boolean =
  { kind = `BOOLEAN;
    proj = (function `BOOL b -> b | _ -> failwith "GTree.get_bool");
    inj = (fun b -> `BOOL b) }
let char =
  { kind = `CHAR;
    proj = (function `CHAR c -> c | _ -> failwith "GTree.get_char");
    inj = (fun c -> `CHAR c) }
let uchar = {char with kind = `UCHAR}
let int =
  { kind = `INT;
    proj = (function `INT c -> c | _ -> failwith "GTree.get_int");
    inj = (fun c -> `INT c) }
let uint = {int with kind = `UINT}
let long = {int with kind = `LONG}
let ulong = {int with kind = `ULONG}
let enum = {int with kind = `ENUM}
let flags = {int with kind = `FLAGS}
let int64 =
  { kind = `INT64;
    proj = (function `INT64 c -> c | _ -> failwith "GTree.get_int64");
    inj = (fun c -> `INT64 c) }
let uint64 = {int64 with kind = `UINT64}
let float =
  { kind = `FLOAT;
    proj = (function `FLOAT c -> c | _ -> failwith "GTree.get_float");
    inj = (fun c -> `FLOAT c) }
let double = {float with kind = `DOUBLE}
let string =
  { kind = `STRING;
    proj = (function `STRING (Some s) -> s | `STRING None -> ""
           | _ -> failwith "GTree.get_string");
    inj = (fun s -> `STRING (Some s)) }
let string_option =
  { kind = `STRING;
    proj = (function `STRING c -> c | _ -> failwith "GTree.get_string");
    inj = (fun c -> `STRING c) }
let pointer =
  { kind = `POINTER;
    proj = (function `POINTER c -> c | _ -> failwith "GTree.get_pointer");
    inj = (fun c -> `POINTER c) }
let boxed = {pointer with kind = `BOXED}
let gobject =
  { kind = `OBJECT;
    proj = (function `OBJECT c -> may_map ~f:Gobject.unsafe_cast c
            | _ -> failwith "GTree.get_object");
    inj = (fun c -> `OBJECT (may_map ~f:Gobject.unsafe_cast c)) }

let of_value kind v =
  kind.proj (Gobject.Value.get v)
let to_value kind x =
  let v =
    Gobject.Value.create
      (Gobject.Type.of_fundamental (kind.kind :> Gobject.fundamental_type)) in
  Gobject.Value.set v (kind.inj x);
  v
end

type 'a column =
    {index: int; conv: 'a Data.conv; creator: int}

class column_list = object (self)
  val mutable index = 0
  val mutable kinds = []
  val mutable locked = false
  method kinds = List.rev kinds
  method add : 'a. 'a Data.conv -> 'a column = fun conv ->
    if locked then failwith "GTree.column_list#add";
    let n = index in
    kinds <- conv.Data.kind :: kinds;
    index <- index + 1;
    {index = n; conv = conv; creator = Oo.id self}
  method id = Oo.id self
  method lock () = locked <- true
end

class model obj ~id = object (self)
  val obj = obj
  val id : int = id
  method as_model = (obj :> tree_model obj)
  method coerce = (self :> model)
  method get : 'a. row:tree_iter -> column:'a column -> 'a =
    fun ~row ~column ->
      if column.creator <> id then invalid_arg "GTree.model#get: bad column";
      let v =
        Gobject.Value.create
          (Gobject.Type.of_fundamental
             (column.conv.Data.kind :> Gobject.fundamental_type)) in
      TreeModel.get_value obj ~row ~column:column.index v;
      Data.of_value column.conv v
end

class tree_store obj ~id = object
  inherit model obj ~id
  method set : 'a. row:tree_iter -> column:'a column -> 'a -> unit =
    fun ~row ~column data ->
      if column.creator <> id then
        invalid_arg "GTree.tree_store#set: bad column";
      TreeStore.set_value obj ~row ~column:column.index
        (Data.to_value column.conv data)
  method remove = TreeStore.remove obj
  method insert = TreeStore.insert obj
  method insert_before = TreeStore.insert_before obj
  method insert_after = TreeStore.insert_after obj
  method append = TreeStore.append obj
  method prepend = TreeStore.prepend obj
  method is_ancestor = TreeStore.is_ancestor obj
  method iter_depth = TreeStore.iter_depth obj
  method clear () = TreeStore.clear obj
  method iter_is_valid = TreeStore.iter_is_valid obj
  method swap = TreeStore.swap obj
  method move_before = TreeStore.move_before obj
  method move_after = TreeStore.move_after obj
end

let tree_store (cols : column_list) =
  cols#lock ();
  let types =
    List.map Gobject.Type.of_fundamental
      (cols#kinds :> Gobject.fundamental_type list) in
  new tree_store (TreeStore.create (Array.of_list types)) ~id:cols#id

class list_store obj ~id = object
  inherit model obj ~id
  method set : 'a. row:tree_iter -> column:'a column -> 'a -> unit =
    fun ~row ~column data ->
      if column.creator <> id then
        invalid_arg "GTree.list_store#set: bad column";
      ListStore.set_value obj ~row ~column:column.index
        (Data.to_value column.conv data)
  method remove = ListStore.remove obj
  method insert = ListStore.insert obj
  method insert_before = ListStore.insert_before obj
  method insert_after = ListStore.insert_after obj
  method append = ListStore.append obj
  method prepend = ListStore.prepend obj
  method clear () = ListStore.clear obj
  method iter_is_valid = ListStore.iter_is_valid obj
  method swap = ListStore.swap obj
  method move_before = ListStore.move_before obj
  method move_after = ListStore.move_after obj
end

let list_store (cols : column_list) =
  cols#lock ();
  let types =
    List.map Gobject.Type.of_fundamental
      (cols#kinds :> Gobject.fundamental_type list) in
  new list_store (ListStore.create (Array.of_list types)) ~id:cols#id

(*
open GTree.Data;;
let cols = new GTree.column_list ;;
let title = cols#add string;;
let author = cols#add string;;
let checked = cols#add boolean;;
let store = new GTree.tree_store cols;;
*)

class view_column (obj : tree_view_column obj) = object
  inherit GObj.gtkobj obj
  method as_column = obj
  method pack : 'a. ?expand:_ -> ?from:_ -> ([>`cellrenderer] as 'a) obj -> _ =
    TreeViewColumn.pack obj
  method add_attribute :
    'a 'b. ([>`cellrenderer] as 'a) obj -> string -> 'b column -> unit
    = fun crr attr col -> TreeViewColumn.add_attribute obj crr attr col.index
  method set_title = TreeViewColumn.set_title obj
end
let view_column ?title ?renderer () =
  let w = new view_column (TreeViewColumn.create ()) in
  may title ~f:w#set_title;
  may renderer ~f:
    begin fun (crr, l) ->
      w#pack crr;
      List.iter l ~f:(fun (attr,col) -> w#add_attribute crr attr col)
    end;
  w

class view obj = object
  inherit GContainer.container obj
  method append_column (col : view_column) =
    TreeView.append_column obj col#as_column
end
let view ?model ?border_width ?width ?height ?packing ?show () =
  let model = may_map ~f:(fun (model : #model) -> model#as_model) model in
  let w = TreeView.create ?model () in
  Container.set w ?border_width ?width ?height;
  pack_return (new view w) ~packing ~show

let cell_renderer_text = CellRendererText.create
