(* $Id$ *)
class message_entry_signals ~(message: string GUtil.signal)=
  object
    inherit GUtil.ml_signals [message#disconnect]
    method message = message#connect ~after
  end

class message_entry ~(handler:Message_handler.irc_message_handler)
    ~(channels:Channelview.channels) ?packing ?show () =
  let e = GEdit.entry ?packing ?show ()
  and message = new GUtil.signal ()
  in
  let _ = e#connect#activate 
      ~callback:(fun () -> message#call e#text; e#set_text "")
  in
  object
    val handler = handler
    val channels = channels
    method message = message
    method connect = new message_entry_signals ~message
  end
