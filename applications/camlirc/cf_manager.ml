(* $Id$ *)

class channel_factory_manager =
  object
    val mutable channel_factory_table : 
	(string * I_channel.i_channel_factory) list = []
    method get_key = List.map (fun (s,_) -> s) channel_factory_table
    method get_constructor s = 
      (List.assoc s channel_factory_table)#new_channel_object
    method add_channel_factory f =
      channel_factory_table <- (f#module_name, f)::channel_factory_table
  end
    
let channel_factory_manager = new channel_factory_manager
