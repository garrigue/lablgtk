module Font = struct
type description
external from_string : string -> description = 
    "ml_pango_font_description_from_string"
end
