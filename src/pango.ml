module Font = struct
  type description
  external from_string : string -> description = 
      "ml_pango_font_description_from_string"
  external copy : description -> description = 
      "ml_pango_font_description_copy"
  external free : description -> unit = 
      "ml_pango_font_description_free"
end
