/* $Id$ */

#define PangoFontDescription_val(val) ((PangoFontDescription*)Pointer_val(val))
value Val_PangoFontDescription(PangoFontDescription* it);

value ml_PangoStyle_Val (value val);

#define Val_PangoLanguage Val_pointer
#define PangoLanguage_val Pointer_val

#define PangoContext_val(val) check_cast(PANGO_CONTEXT,val)
#define Val_PangoContext Val_GAnyObject
#define Val_PangoContext_new Val_GAnyObject_new

#define PangoFont_val(val) check_cast(PANGO_FONT, val)
#define Val_PangoFont Val_GAnyObject

#define PangoFontMetrics_val(val) ((PangoFontMetrics*)Pointer_val(val))
