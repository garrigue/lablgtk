#include <libgnomeui/libgnomeui.h>

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>

#include "wrappers.h"
#include "ml_gobject.h"
#include "ml_gdk.h"
#include "ml_gtk.h"
#include "ml_gdkpixbuf.h"

#include "gnomeui_tags.h"
#include "gnomeui_tags.c"

#define GnomeDruid_val(val)              check_cast(GNOME_DRUID,val)
#define GnomeDruidPage_val(val)          check_cast(GNOME_DRUID_PAGE,val)
#define GnomeDruidPageEdge_val(val)      check_cast(GNOME_DRUID_PAGE_EDGE,val)
#define GnomeDruidPageStandard_val(val)  check_cast(GNOME_DRUID_PAGE_STANDARD,val)

/* gnome-druid.h */
ML_0(gnome_druid_new, Val_GtkWidget_sink)
ML_5(gnome_druid_set_buttons_sensitive, GnomeDruid_val, Bool_val, Bool_val, Bool_val, Bool_val, Unit)

ML_2(gnome_druid_prepend_page, GnomeDruid_val, GnomeDruidPage_val, Unit)
ML_3(gnome_druid_insert_page, GnomeDruid_val, GnomeDruidPage_val, GnomeDruidPage_val, Unit)
ML_2(gnome_druid_append_page, GnomeDruid_val, GnomeDruidPage_val, Unit)
ML_2(gnome_druid_set_page, GnomeDruid_val, GnomeDruidPage_val, Unit)

/* gnome-druid-page-edge.h */
#define GdkPixbuf_option_val(v) Option_val(v,GdkPixbuf_val,NULL)
ML_7(gnome_druid_page_edge_new_with_vals, Edge_position_val, Bool_val, \
     String_option_val, String_option_val, \
     GdkPixbuf_option_val, GdkPixbuf_option_val, GdkPixbuf_option_val, Val_GtkWidget_sink)
ML_bc7(ml_gnome_druid_page_edge_new_with_vals)

ML_2(gnome_druid_page_edge_set_bg_color, GnomeDruidPageEdge_val, GdkColor_val, Unit)
ML_2(gnome_druid_page_edge_set_textbox_color, GnomeDruidPageEdge_val, GdkColor_val, Unit)
ML_2(gnome_druid_page_edge_set_logo_bg_color, GnomeDruidPageEdge_val, GdkColor_val, Unit)
ML_2(gnome_druid_page_edge_set_title_color, GnomeDruidPageEdge_val, GdkColor_val, Unit)
ML_2(gnome_druid_page_edge_set_text_color, GnomeDruidPageEdge_val, GdkColor_val, Unit)
ML_2(gnome_druid_page_edge_set_text, GnomeDruidPageEdge_val, String_val, Unit)
ML_2(gnome_druid_page_edge_set_title, GnomeDruidPageEdge_val, String_val, Unit)
ML_2(gnome_druid_page_edge_set_logo, GnomeDruidPageEdge_val, GdkPixbuf_val, Unit)
ML_2(gnome_druid_page_edge_set_watermark, GnomeDruidPageEdge_val, GdkPixbuf_val, Unit)
ML_2(gnome_druid_page_edge_set_top_watermark, GnomeDruidPageEdge_val, GdkPixbuf_val, Unit)

/* gnome-druid-page-standard.h */
Make_Extractor(gnome_druid_page_standard, GnomeDruidPageStandard_val, vbox, Val_GtkWidget)
ML_0(gnome_druid_page_standard_new, Val_GtkWidget_sink)
ML_2(gnome_druid_page_standard_set_contents_background, GnomeDruidPageStandard_val, GdkColor_val, Unit)
ML_4(gnome_druid_page_standard_append_item, GnomeDruidPageStandard_val, String_option_val, GtkWidget_val, String_option_val, Unit)
