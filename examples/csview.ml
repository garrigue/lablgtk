(* $Id$ *)

(* A simple CSV data viewer *)

type data =
    { fields : string list;
      titles : string list;
      data : string list list }

let mem_string ~char s =
  try
    for i = 0 to String.length s - 1 do
      if s.[i] = char then raise Exit
    done;
    false
  with Exit -> true

let rec until ~chars ?(buf = Buffer.create 80) s =
  match Stream.peek s with
    Some c ->
      if mem_string ~char:c chars then Buffer.contents buf else begin
        Buffer.add_char buf c;
        Stream.junk s;
        until ~chars ~buf s
      end
  | None ->
      if Buffer.length buf > 0 then raise (Stream.Error "until")
      else raise Stream.Failure

let rec ignores ?(chars = " \t") s =
  match Stream.peek s with
    Some c when mem_string ~char:c chars ->
      Stream.junk s; ignores ~chars s
  | _ -> ()

let parse_field = parser
    [< ''"'; f = until ~chars:"\""; ''"'; _ = ignores >] ->
      for i = 0 to String.length f - 1 do
        if f.[i] = '\031' then f.[i] <- '\n'
      done;
      f
  | [< f = until ~chars:",\n\r" >] -> f
  | [< >] -> ""

let comma = parser [< '','; _ = ignores >] -> ()

let rec parse_list ~item ~sep = parser
    [< i = item; s >] ->
      begin match s with parser
        [< _ = sep; l = parse_list ~item ~sep >] -> i :: l
      | [< >] -> [i]
      end
  | [< >] -> []

let parse_one = parse_list ~item:parse_field ~sep:comma

let lf = parser [< ''\n'|'\r'; _ = ignores ~chars:"\n\r"; _ = ignores >] -> ()

let parse_all = parse_list ~item:parse_one ~sep:lf

let read_file file =
  let ic = open_in file in
  let s = Stream.of_channel ic in
  let data = parse_all s in
  close_in ic;
  match data with
    ("i"::fields) :: ("T"::titles) :: data ->
      {fields=fields; titles=titles; data=List.map ~f:List.tl data}
  | titles :: data ->
      {fields=titles; titles=titles; data=data}
  | _ -> failwith "Insufficient data"

let print_string s =
  Format.print_char '"';
  for i = 0 to String.length s - 1 do
    match s.[i] with
      '\'' -> Format.print_char '\''
    | '"' -> Format.print_string "\\\""
    | '\160'..'\255' as c -> Format.print_char c
    | c -> Format.print_string (Char.escaped c)
  done;
  Format.print_char '"'  

(*
#install_printer print_string;;
*)

open GMain

let field_widths =
  [ "i", 0;
    "ATTR", 0;
    "NAME", 17;
    "NAPR", 8;
    "TEL1", 14;
    "ZIPC", 12;
    "ADR1", 40;
    "BRTH", 10;
    "RMRK", 20;
    "CHK1", 0;
    "CHK2", 0;
    "CHK3", 0;
    "CHK4", 0;
    "TIM1", 16;
    "TIM2", 16;
    "ALRM", 0;
    "ATTM", 0;
  ]

let main argv =
  if Array.length argv <> 2 then begin
    prerr_endline "Usage: csview <csv file>";
    exit 2
  end;
  let data = read_file argv.(1) in
  let w = GWindow.window () in
  w#misc#realize ();
  let style = w#misc#style in
  let font = Gdk.Font.load_fontset "-schumacher-clean-medium-r-normal--13-*-*-*-c-60-*,-mnkaname-fixed-*--12-*" in
  let w0 = Gdk.Font.char_width font '0' in
  style#set_font font;
  w#connect#destroy ~callback:Main.quit;
  let sw = GBin.scrolled_window ~width:600 ~height:300 ~packing:w#add () in
  let cl = GList.clist ~titles:data.titles ~packing:sw#add () in
  List.fold_left data.fields ~init:0 ~f:
    begin fun acc f ->
      let width = try List.assoc f field_widths with Not_found -> -1 in
      if width = 0 then
        cl#set_column ~visibility:false acc
      else begin
        if width > 0 then cl#set_column ~width:(width * w0) acc
        else cl#set_column ~auto_resize:true acc;
        if f = "NAPR" || f = "TIM1" || f = "CLAS" then
          cl#set_sort ~auto:true ~column:acc ();
        try
          let ali = GBin.alignment_cast (cl#column_widget acc) in
          let lbl = GMisc.label_cast (List.hd ali#children) in
          lbl#set_alignment ~x:0. ()
        with _ ->
          prerr_endline ("No column widget for field " ^ f)
      end;
      succ acc
    end;
  List.iter data.data
    ~f:(fun l -> if List.length l > 1 then ignore (cl#append l));
  w#show ();
  Main.main ()

let _ = main Sys.argv
