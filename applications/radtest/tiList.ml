
open Utils
open Property

open TiBase

class ticlist ~(widget : 'a GList.clist) ~name ~parent_tree ~pos
    ?(insert_evbox=true) parent_window ~columns ~titles =
  object(self)
    val clist = widget
    inherit tiwidget ~name ~widget ~parent_tree ~pos
	~insert_evbox parent_window as widget

    val param = parent_window#add_param

    method private class_name = "GList.clist"

    method private get_mandatory_props = [ "columns" ]

    method remove_me_without_undo () =
      parent_window#remove_param param;
      widget#remove_me_without_undo ()

    method emit_init_code formatter ~packing =
      Format.fprintf formatter 
	"@ @[<hv 2>let (%s : '%c GList.clist) =@ @[<hov 2>GList.clist"
	name param;
      List.iter self#get_mandatory_props ~f:
	begin fun name ->
	  Format.fprintf formatter "@ ~%s:%s" name
	    (List.assoc name proplist)#code
	end;
      let packing = self#get_packing packing in
      if packing <> "" then Format.fprintf formatter "@ %s" packing;
      self#emit_prop_code formatter;
      Format.fprintf formatter "@ ()@ in@]@]"


    initializer
      classe <- "clist";
      proplist <- proplist @
      [ "columns",
	new prop_int ~name:"columns" ~init:(string_of_int columns)
	  ~set:(fun _ -> true);
	"titles",
	new prop_clist_titles ~name:"titles" ~init:(String.concat ~sep:" " titles)
	  ~set:(fun v ->
	    let v = Array.of_list v in
	    for i = 0 to Array.length v - 1 do
	      clist#set_column_title i v.(i)
	    done;
	    true)
      ]
end

let new_clist ~name ?(listprop = []) =
  let c, lp = match listprop with
  | [] -> (get_a_number "number of columns" 3), []
  | ("columns", n)::tl -> (int_of_string n), tl
  | _ -> failwith "new_clist"
  in
  let rtitles = ref [] in
  for i = c downto 1 do rtitles := ("column" ^(string_of_int i)):: !rtitles done;
  new ticlist ~name ~widget:(GList.clist ~columns:c ~titles: !rtitles ()) ~columns:c ~titles: !rtitles
    

