(* $Id$ *)

(* �����¹Ԥ�������LANG=ja_JP.EUC�ʤɤȻ��ꤷ�ʤ���Фʤ�ʤ� *)

(* cut-and-paste ���б����Ƥ��ޤ�����edit�Ϥ��ޤ������ޤ��� *)

open GMain

let window = GWindow.window ()
let box = GPack.vbox packing: window#add ()
let text = GEdit.text editable: true packing: box#add ()
let font = Gdk.Font.load_fontset
    "-*-fixed-medium-r-normal--24-*-c-120-iso8859-1, \
     -*-fixed-medium-r-normal--24-*-jisx0208.1983-0, \
     -*-fixed-medium-r-normal--24-*-jisx0201.1976-0"
let button = GButton.button label: "��λ" packing: box#add ()
let label = GMisc.label text:"����ˤϱƶ����ʤ�" packing: box#add ()

let _ =
  window#connect#destroy callback:Main.quit;
  text#misc#realize ();
  text#insert "����ˤ���" :font;
  let style = button#misc#style#copy in
  button#misc#set_style style;
  style#set_font font;
  style#set_bg [`NORMAL,`NAME "green"; `PRELIGHT,`NAME "red"];
  button#connect#clicked callback:Main.quit

let _ =
  window#show ();
  Main.main ()
