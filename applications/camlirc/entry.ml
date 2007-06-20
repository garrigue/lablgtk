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
(*      Benjamin Monate  <monate@lix.polytechnique.fr>                    *)
(*      Olivier Andrieu  <oandrieu@nerim.net>                             *)
(*      Jun Furuse       <Jun.Furuse@inria.fr>                            *)
(*      Hubert Fauque    <hubert.fauque@wanadoo.fr>                       *)
(*      Koji Kagawa      <kagawa@eng.kagawa-u.ac.jp>                      *)
(*                                                                        *)
(**************************************************************************)

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
