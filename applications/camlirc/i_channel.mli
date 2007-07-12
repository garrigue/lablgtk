(**************************************************************************)
(*     Lablgtk - Applications                                             *)
(*                                                                        *)
(*    * You are free to do anything you want with this code as long       *)
(*      as it is for personal use.                                        *)
(*                                                                        *)
(*    * Redistribution can only be "as is".  Binary distribution          *)
(*      and bug fixes are allowed, but you cannot extensively             *)
(*      modify the code without asking the authors.                       *)
(*                                                                        *)
(*    The authors may choose to remove any of the above                   *)
(*    restrictions on a per request basis.                                *)
(*                                                                        *)
(*    Authors:                                                            *)
(*      Jacques Garrigue <garrigue@kurims.kyoto-u.ac.jp>                  *)
(*      Benjamin Monate  <Benjamin.Monate@free.fr>                        *)
(*      Olivier Andrieu  <oandrieu@nerim.net>                             *)
(*      Jun Furuse       <Jun.Furuse@inria.fr>                            *)
(*      Hubert Fauque    <hubert.fauque@wanadoo.fr>                       *)
(*      Koji Kagawa      <kagawa@eng.kagawa-u.ac.jp>                      *)
(*                                                                        *)
(**************************************************************************)

class i_channel_signals :
  object ('a)
    val after : bool
    val mutable disconnectors : (GtkSignal.id -> bool) list
    method after : 'a
    method disconnect : GtkSignal.id -> unit
    method part : callback:(string -> unit) -> GtkSignal.id
    method privmsg : callback:((string * string) -> unit) -> GtkSignal.id
  end

class i_channel :
  object
    val channelname : string
    val part : string GUtil.signal
    val privmsg : (string * string) GUtil.signal
    val obj : Gtk.widget Gtk.obj
    method as_widget : Gtk.widget Gtk.obj
    method channelname : string
    method coerce : GObj.widget
    method connect : i_channel_signals
    method destroy : unit -> unit
    method drag : GObj.drag_ops
    method get_id : int
    method misc : GObj.misc_ops
    method my_message : string -> unit
    method initialize : unit -> unit
    method part_command : unit -> unit
    method topic_command : unit -> unit
    method ctcp_command : unit -> unit
    method part : string GUtil.signal
  end

class i_channel_factory :
    object 
      method module_name : string
      method new_channel_object :
	  handler:Message_handler.irc_message_handler -> 
	    channel_name:string -> server:Server.server_info ->
	      ?packing:(GObj.widget -> unit) -> ?show:bool -> unit -> i_channel
    end

