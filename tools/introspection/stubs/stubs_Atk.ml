type -'a obj

module _RegistryClass = struct
  end
module _Registry = struct
  end
module _PropertyValues = struct
  end
module ValueIface = struct
  end
module UtilClass = struct
  end
module Util = struct
  end
module TextRectangle = struct
  end
module TextRange = struct
  end
module TextIface = struct
  end
module TableIface = struct
  end
module StreamableContentIface = struct
  end
module StateSetClass = struct
  end
module StateSet = struct
  external xor_sets: [>`atkstateset] obj -> [>`atkstateset] obj -> [<`atkstateset] obj = "ml_atk_state_set_xor_sets"
  external or_sets: [>`atkstateset] obj -> [>`atkstateset] obj -> [<`atkstateset] obj = "ml_atk_state_set_or_sets"
  external is_empty: [>`atkstateset] obj -> bool = "ml_atk_state_set_is_empty"
  external clear_states: [>`atkstateset] obj -> unit = "ml_atk_state_set_clear_states"
  external and_sets: [>`atkstateset] obj -> [>`atkstateset] obj -> [<`atkstateset] obj = "ml_atk_state_set_and_sets"
  end
module SocketClass = struct
  end
module Socket = struct
  external is_occupied: [>`atksocket] obj -> bool = "ml_atk_socket_is_occupied"
  external embed: [>`atksocket] obj -> string -> unit = "ml_atk_socket_embed"
  end
module SelectionIface = struct
  end
module RelationSetClass = struct
  end
module RelationSet = struct
  external remove: [>`atkrelationset] obj -> [>`atkrelation] obj -> unit = "ml_atk_relation_set_remove"
  external get_relation: [>`atkrelationset] obj -> int -> [<`atkrelation] obj = "ml_atk_relation_set_get_relation"
  external get_n_relations: [>`atkrelationset] obj -> int = "ml_atk_relation_set_get_n_relations"
  external add: [>`atkrelationset] obj -> [>`atkrelation] obj -> unit = "ml_atk_relation_set_add"
  end
module RelationClass = struct
  end
module Relation = struct
  external remove_target: [>`atkrelation] obj -> [>`atkobject] obj -> bool = "ml_atk_relation_remove_target"
  external add_target: [>`atkrelation] obj -> [>`atkobject] obj -> unit = "ml_atk_relation_add_target"
  end
module Registry = struct
  end
module Rectangle = struct
  end
module PlugClass = struct
  end
module Plug = struct
  external get_id: [>`atkplug] obj -> string = "ml_atk_plug_get_id"
  end
module ObjectFactoryClass = struct
  end
module ObjectFactory = struct
  external invalidate: [>`atkobjectfactory] obj -> unit = "ml_atk_object_factory_invalidate"
  external get_accessible_type: [>`atkobjectfactory] obj -> int = "ml_atk_object_factory_get_accessible_type"
  end
module ObjectClass = struct
  end
module Object = struct
  external set_parent: [>`atkobject] obj -> [>`atkobject] obj -> unit = "ml_atk_object_set_parent"
  external set_name: [>`atkobject] obj -> string -> unit = "ml_atk_object_set_name"
  external set_description: [>`atkobject] obj -> string -> unit = "ml_atk_object_set_description"
  external remove_property_change_handler: [>`atkobject] obj -> int -> unit = "ml_atk_object_remove_property_change_handler"
  external ref_state_set: [>`atkobject] obj -> [<`atkstateset] obj = "ml_atk_object_ref_state_set"
  external ref_relation_set: [>`atkobject] obj -> [<`atkrelationset] obj = "ml_atk_object_ref_relation_set"
  external ref_accessible_child: [>`atkobject] obj -> int -> [<`atkobject] obj = "ml_atk_object_ref_accessible_child"
  external notify_state_change: [>`atkobject] obj -> int64 -> bool -> unit = "ml_atk_object_notify_state_change"
  external get_parent: [>`atkobject] obj -> [<`atkobject] obj = "ml_atk_object_get_parent"
  external get_name: [>`atkobject] obj -> string = "ml_atk_object_get_name"
  external get_n_accessible_children: [>`atkobject] obj -> int = "ml_atk_object_get_n_accessible_children"
  external get_index_in_parent: [>`atkobject] obj -> int = "ml_atk_object_get_index_in_parent"
  external get_description: [>`atkobject] obj -> string = "ml_atk_object_get_description"
  end
module NoOpObjectFactoryClass = struct
  end
module NoOpObjectFactory = struct
  end
module NoOpObjectClass = struct
  end
module NoOpObject = struct
  end
module MiscClass = struct
  end
module Misc = struct
  external threads_leave: [>`atkmisc] obj -> unit = "ml_atk_misc_threads_leave"
  external threads_enter: [>`atkmisc] obj -> unit = "ml_atk_misc_threads_enter"
  external get_instance: unit -> [<`atkmisc] obj = "ml_atk_misc_get_instance"
  end
module KeyEventStruct = struct
  end
module Implementor = struct
  external ref_accessible: [>`atkimplementor] obj -> [<`atkobject] obj = "ml_atk_implementor_ref_accessible"
  end
module ImageIface = struct
  end
module HypertextIface = struct
  end
module HyperlinkImplIface = struct
  end
module HyperlinkClass = struct
  end
module Hyperlink = struct
  external is_valid: [>`atkhyperlink] obj -> bool = "ml_atk_hyperlink_is_valid"
  external is_inline: [>`atkhyperlink] obj -> bool = "ml_atk_hyperlink_is_inline"
  external get_uri: [>`atkhyperlink] obj -> int -> string = "ml_atk_hyperlink_get_uri"
  external get_start_index: [>`atkhyperlink] obj -> int = "ml_atk_hyperlink_get_start_index"
  external get_object: [>`atkhyperlink] obj -> int -> [<`atkobject] obj = "ml_atk_hyperlink_get_object"
  external get_n_anchors: [>`atkhyperlink] obj -> int = "ml_atk_hyperlink_get_n_anchors"
  external get_end_index: [>`atkhyperlink] obj -> int = "ml_atk_hyperlink_get_end_index"
  end
module GObjectAccessibleClass = struct
  end
module GObjectAccessible = struct
  end
module EditableTextIface = struct
  end
module DocumentIface = struct
  end
module ComponentIface = struct
  end
module Attribute = struct
  end
module ActionIface = struct
  end
(* Global functions *)
external remove_key_event_listener: int -> unit = "ml_atk_remove_key_event_listener"
external remove_global_event_listener: int -> unit = "ml_atk_remove_global_event_listener"
external remove_focus_tracker: int -> unit = "ml_atk_remove_focus_tracker"
external get_version: unit -> string = "ml_atk_get_version"
external get_toolkit_version: unit -> string = "ml_atk_get_toolkit_version"
external get_toolkit_name: unit -> string = "ml_atk_get_toolkit_name"
external get_root: unit -> [<`atkobject] obj = "ml_atk_get_root"
external get_focus_object: unit -> [<`atkobject] obj = "ml_atk_get_focus_object"
external focus_tracker_notify: [>`atkobject] obj -> unit = "ml_atk_focus_tracker_notify"
(* End of global functions *)

