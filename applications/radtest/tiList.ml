
open Utils
open Property

open TiBase

class ticlist ~(widget : 'a GList.clist) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window ~columns =
  object
    val clist = widget
    inherit tiwidget ~name ~widget ~parent_tree ~pos
	~insert_evbox parent_window

    method private class_name = "GList.clist"

    initializer
      classe <- "clist";
      proplist <- proplist @
      [ "columns",
	new prop_int ~name:"columns" ~init:(string_of_int columns)
	             ~set:(fun _ -> true) ]


end

let new_clist ~name =
  let c = get_a_number "number of columns" 3 in
  let rtitles = ref [] in
  for i = c downto 1 do rtitles := ("column" ^(string_of_int i)):: !rtitles done;
  new ticlist ~name ~widget:(GList.clist ~columns:c ~titles: !rtitles ()) ~columns:c
    

