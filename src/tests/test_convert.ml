GtkMain.Main.init ();;

let isolatin1 = "AÈÈÁ‡ËÙ«¿…»Z"
let utf8 = "A√©√©√ß√†√®√¥√á√Ä√â√àZ"

let utf8' = Glib.Conversion.convert ~to_codeset:"ISO-10646/UTF-8/" 
	      ~from_codeset:"ISO-8859-1" isolatin1;;

let isolatin1'= Glib.Conversion.convert ~from_codeset:"ISO-10646/UTF-8/" 
		  ~to_codeset:"ISO-8859-1" utf8;;

Printf.printf "Latin 1:\"%s\" (is valid utf8 :%b)
UTF-8:\"%s\"(is valid utf8 :%b)\n" 
  isolatin1' (Utf8.validate isolatin1') utf8' (Utf8.validate utf8');;

let b,c = Glib.Conversion.get_charset () ;;

Printf.printf "Current charset is '%s' (is utf8:%b)\n" c b;; 
