/* $Id$ */

#include <stdio.h>
#include <gtk/gtk.h>

#include <caml/mlvalues.h>
#include <caml/alloc.h>
#include <caml/memory.h>
#include <caml/callback.h>
#include <caml/fail.h>
#include <caml/custom.h>

#include "wrappers.h"
#include "ml_glib.h"
#include "ml_gdk.h"
#include "ml_gtk.h"
#include "ml_gobject.h"
#include "ml_gdkpixbuf.h"
#include "gtk_tags.h"
#include "gdk_tags.h"

#define GtkTextMark_val(val) check_cast(GTK_TEXT_MARK,val)
#define Val_GtkTextMark(val) (Val_GObject((GObject*)val))
#define Val_GtkTextMark_new(val) (Val_GObject_new((GObject*)val))
value Val_GtkTextMark_func(gpointer val){
  return(Val_GtkTextMark(val));
}
static value Val_GtkTextMark_opt(GtkTextMark *mrk) {
  return Val_option(mrk, Val_GtkTextMark);
}
        
#define GtkTextTag_val(val) check_cast(GTK_TEXT_TAG,val)
#define Val_GtkTextTag(val) (Val_GObject((GObject*)val))
#define Val_GtkTextTag_new(val) (Val_GObject_new((GObject*)val))

#define GtkTextTagTable_val(val) check_cast(GTK_TEXT_TAG_TABLE,val)
#define Val_GtkTextTagTable(val)  (Val_GObject((GObject*)val))
#define Val_GtkTextTagTable_new(val) (Val_GObject_new((GObject*)val))

#define GtkTextBuffer_val(val) check_cast(GTK_TEXT_BUFFER,val)
#define Val_GtkTextBuffer(val)  (Val_GObject((GObject*)val))
#define Val_GtkTextBuffer_new(val) (Val_GObject_new((GObject*)val))

/* TextIter are not GObjects. They are stack allocated. */
/* This is the Custom_block version for latter...
static void text_iter_free (value v)
{
  gtk_text_iter_free((GtkTextIter*)v);
}
static struct custom_operations textiter_custom_operations =
  {"gtk_textiter/2.0/",text_iter_free,custom_compare_default,
   custom_hash_default,custom_serialize_default,custom_deserialize_default}
;
#define GtkTextIter_val(val) ((GtkTextIter*)Data_custom_val(val))

value Val_GtkTextIter_new(GtkTextIter* val){
  value res = alloc_custom(&textiter_custom_operations,1,1,2);
  Field(res,1)=(value)gtk_text_iter_copy(val);
  return(res);
}
*/

/* This is the classical version for lablgtk */
#define GtkTextIter_val(val) ((GtkTextIter*)Pointer_val(val))
Make_Val_final_pointer_ext(GtkTextIter, _mine,Ignore,gtk_text_iter_free,1)
value Val_GtkTextIter(GtkTextIter* it){
  return(Val_GtkTextIter_mine(gtk_text_iter_copy(it))); 
}


#define GtkTextView_val(val) check_cast(GTK_TEXT_VIEW,val)


/* gtktextmark */

ML_2(gtk_text_mark_set_visible, GtkTextMark_val, Bool_val, Unit)
ML_1(gtk_text_mark_get_visible, GtkTextMark_val, Val_bool)
ML_1(gtk_text_mark_get_deleted, GtkTextMark_val, Val_bool)
ML_1(gtk_text_mark_get_name, GtkTextMark_val, Val_string)
ML_1(gtk_text_mark_get_buffer, GtkTextMark_val, Val_GtkTextBuffer)
ML_1(gtk_text_mark_get_left_gravity, GtkTextMark_val, Val_bool)

/* gtktexttag */

ML_1(gtk_text_tag_new, String_val, Val_GtkTextTag_new)
ML_1(gtk_text_tag_get_priority, GtkTextTag_val, Val_int)
ML_2(gtk_text_tag_set_priority, GtkTextTag_val, Int_val, Unit)
ML_4(gtk_text_tag_event, GtkTextTag_val, GObject_val, GdkEvent_val, 
     GtkTextIter_val, Val_bool)

/* gtktexttagtable */

ML_0(gtk_text_tag_table_new, Val_GtkTextTagTable_new)
ML_1(gtk_text_tag_table_get_size, GtkTextTagTable_val, Int_val)

/* gtktextbuffer */

ML_1 (gtk_text_buffer_new,
      Option_val(arg1,GtkTextTagTable_val,NULL) Ignore, Val_GtkTextBuffer_new)

ML_1 (gtk_text_buffer_get_line_count,GtkTextBuffer_val,Val_int)

ML_1 (gtk_text_buffer_get_char_count,GtkTextBuffer_val,Val_int)

ML_1 (gtk_text_buffer_get_tag_table,GtkTextBuffer_val,Val_GtkTextTagTable)

ML_4 (gtk_text_buffer_insert,GtkTextBuffer_val,
      GtkTextIter_val, String_val,Int_val,Unit)

ML_3 (gtk_text_buffer_insert_at_cursor,GtkTextBuffer_val,
      String_val,Int_val,Unit)

ML_5 (gtk_text_buffer_insert_interactive,GtkTextBuffer_val,
      GtkTextIter_val, String_val,Int_val,Bool_val,Val_bool)

ML_4 (gtk_text_buffer_insert_interactive_at_cursor,GtkTextBuffer_val,
      String_val,Int_val,Bool_val,Val_bool)

ML_4 (gtk_text_buffer_insert_range,GtkTextBuffer_val,
      GtkTextIter_val, GtkTextIter_val,GtkTextIter_val,Unit)

ML_5 (gtk_text_buffer_insert_range_interactive,GtkTextBuffer_val,
      GtkTextIter_val, GtkTextIter_val,GtkTextIter_val,Bool_val,Val_bool)

ML_3 (gtk_text_buffer_delete,GtkTextBuffer_val,
      GtkTextIter_val, GtkTextIter_val,Unit)

ML_4 (gtk_text_buffer_delete_interactive,GtkTextBuffer_val,
      GtkTextIter_val, GtkTextIter_val,Bool_val,Val_bool)

ML_3 (gtk_text_buffer_set_text, GtkTextBuffer_val, String_val , Int_val, Unit)

ML_4 (gtk_text_buffer_get_text, GtkTextBuffer_val, 
      GtkTextIter_val,GtkTextIter_val,Bool_val,Val_string)

ML_4 (gtk_text_buffer_get_slice, GtkTextBuffer_val, 
      GtkTextIter_val,GtkTextIter_val,Bool_val,Val_string)

ML_3 (gtk_text_buffer_insert_pixbuf, GtkTextBuffer_val, 
      GtkTextIter_val,GdkPixbuf_val,Unit)

ML_4 (gtk_text_buffer_create_mark, GtkTextBuffer_val, 
      Option_val(arg2,String_val,NULL) Ignore,
      GtkTextIter_val,Bool_val,Val_GtkTextMark_new)

ML_2 (gtk_text_buffer_get_mark, GtkTextBuffer_val, 
      String_val,Val_GtkTextMark_opt)

ML_1 (gtk_text_buffer_get_insert, GtkTextBuffer_val, Val_GtkTextMark)

ML_1 (gtk_text_buffer_get_selection_bound, GtkTextBuffer_val, Val_GtkTextMark)

ML_3(gtk_text_buffer_move_mark, GtkTextBuffer_val, GtkTextMark_val, 
     GtkTextIter_val, Unit)

ML_3(gtk_text_buffer_move_mark_by_name, GtkTextBuffer_val, String_val, 
     GtkTextIter_val, Unit)

ML_2 (gtk_text_buffer_delete_mark, GtkTextBuffer_val, 
      GtkTextMark_val,Unit)

ML_2 (gtk_text_buffer_delete_mark_by_name, GtkTextBuffer_val, 
      String_val,Unit)

ML_2 (gtk_text_buffer_place_cursor, GtkTextBuffer_val, 
      GtkTextIter_val, Unit)

ML_4 (gtk_text_buffer_apply_tag, GtkTextBuffer_val, 
      GtkTextTag_val, GtkTextIter_val, GtkTextIter_val, Unit)

ML_4 (gtk_text_buffer_remove_tag, GtkTextBuffer_val, 
      GtkTextTag_val, GtkTextIter_val, GtkTextIter_val, Unit)

ML_4 (gtk_text_buffer_apply_tag_by_name, GtkTextBuffer_val, 
      String_val, GtkTextIter_val, GtkTextIter_val, Unit)

ML_4 (gtk_text_buffer_remove_tag_by_name, GtkTextBuffer_val, 
      String_val, GtkTextIter_val, GtkTextIter_val, Unit)

ML_3 (gtk_text_buffer_remove_all_tags, GtkTextBuffer_val, 
      GtkTextIter_val, GtkTextIter_val, Unit)

ML_2_name (ml_gtk_text_buffer_create_tag_0,gtk_text_buffer_create_tag,
	   GtkTextBuffer_val, 
	   Split(Option_val(arg2,String_val,NULL),
		 Id,
		 NULL Ignore),
	   Val_GtkTextTag_new)

CAMLprim value  ml_gtk_text_buffer_create_tag_1
(value arg1, value arg2, value arg3) 
{ return
    (Val_GtkTextTag_new
     (gtk_text_buffer_create_tag
      (GtkTextBuffer_val(arg1),Option_val(arg2,String_val,NULL),
       String_val(arg3),NULL)));};

CAMLprim value  ml_gtk_text_buffer_create_tag_2
(value arg1, value arg2, value arg3, value arg4) 
{ return
    (Val_GtkTextTag_new
     (gtk_text_buffer_create_tag
      (GtkTextBuffer_val(arg1),Option_val(arg2,String_val,NULL),
       String_val(arg3),String_val(arg4),NULL)));};


CAMLprim value ml_gtk_text_buffer_get_iter_at_line_offset(value tb, 
							  value l,
							  value c)
{
  CAMLparam3(tb,l,c);
  GtkTextIter res;
  gtk_text_buffer_get_iter_at_line_offset(GtkTextBuffer_val(tb),
					  &res,
					  Int_val(l),
					  Int_val(c));
  CAMLreturn(Val_GtkTextIter(&res));
}

CAMLprim value ml_gtk_text_buffer_get_iter_at_offset(value tb, value l)
{
  CAMLparam2(tb,l);
  GtkTextIter res;
  gtk_text_buffer_get_iter_at_offset(GtkTextBuffer_val(tb),
				     &res,
				     Int_val(l));
  CAMLreturn(Val_GtkTextIter(&res));
}

CAMLprim value ml_gtk_text_buffer_get_iter_at_line(value tb, value l)
{
  CAMLparam2(tb,l);
  GtkTextIter res;
  gtk_text_buffer_get_iter_at_line(GtkTextBuffer_val(tb),
				   &res,
				   Int_val(l));
  CAMLreturn(Val_GtkTextIter(&res));
}

CAMLprim value ml_gtk_text_buffer_get_iter_at_line_index(value tb, 
							 value l,
							 value c)
{
  CAMLparam3(tb,l,c);
  GtkTextIter res;
  gtk_text_buffer_get_iter_at_line_offset(GtkTextBuffer_val(tb),
					  &res,
					  Int_val(l),
					  Int_val(c));
  CAMLreturn(Val_GtkTextIter(&res));
}


CAMLprim value ml_gtk_text_buffer_get_iter_at_mark(value tb, value l)
{
  CAMLparam2(tb,l);
  GtkTextIter res;
  gtk_text_buffer_get_iter_at_mark(GtkTextBuffer_val(tb),
				   &res,
				   GtkTextMark_val(l));
  CAMLreturn(Val_GtkTextIter(&res));
}

CAMLprim value ml_gtk_text_buffer_get_start_iter(value tb)
{
  CAMLparam1(tb);
  GtkTextIter res;
  gtk_text_buffer_get_start_iter(GtkTextBuffer_val(tb), &res);
  CAMLreturn(Val_GtkTextIter(&res));
}

CAMLprim value ml_gtk_text_buffer_get_end_iter(value tb)
{
  CAMLparam1(tb);
  GtkTextIter res;
  gtk_text_buffer_get_end_iter(GtkTextBuffer_val(tb), &res);
  CAMLreturn(Val_GtkTextIter(&res));
}

CAMLprim value ml_gtk_text_buffer_get_bounds(value tb)
{
  CAMLparam1(tb);
  CAMLlocal1(res);
  GtkTextIter res1,res2;
  gtk_text_buffer_get_bounds(GtkTextBuffer_val(tb), &res1, &res2);

  res = alloc_tuple(2);
  Store_field(res,0,Val_GtkTextIter(&res1));
  Store_field(res,1,Val_GtkTextIter(&res2));

  CAMLreturn(res);
}

ML_1 (gtk_text_buffer_get_modified, GtkTextBuffer_val, Val_bool)

ML_2 (gtk_text_buffer_set_modified, GtkTextBuffer_val, Bool_val, Unit)

ML_3 (gtk_text_buffer_delete_selection, GtkTextBuffer_val, 
      Bool_val, Bool_val, Val_bool)

CAMLprim value ml_gtk_text_buffer_get_selection_bounds(value tb)
{
  CAMLparam1(tb);
  CAMLlocal2(res,couple);
  GtkTextIter res1,res2;
  int e;
  e=gtk_text_buffer_get_selection_bounds(GtkTextBuffer_val(tb), &res1, &res2);
  
  if (e) res = Val_unit; 
  else {
    couple = alloc_tuple(2);
    Store_field(res,0,Val_GtkTextIter(&res1));
    Store_field(res,1,Val_GtkTextIter(&res2));
    res = ml_some(couple);
      };

  CAMLreturn(res);
}

ML_1(gtk_text_buffer_begin_user_action,GtkTextBuffer_val,Unit)

ML_1(gtk_text_buffer_end_user_action,GtkTextBuffer_val,Unit)


/* gtktextview.h */

ML_0 (gtk_text_view_new, Val_GtkWidget_sink)

ML_1 (gtk_text_view_new_with_buffer, GtkTextBuffer_val, Val_GtkWidget_sink)

ML_2 (gtk_text_view_set_buffer, GtkTextView_val, GtkTextBuffer_val, Unit)
ML_1 (gtk_text_view_get_buffer, GtkTextView_val, Val_GtkTextBuffer_new)

ML_6(gtk_text_view_scroll_to_mark, GtkTextView_val, GtkTextMark_val,
     Float_val, Bool_val, Float_val,Float_val, Unit)
ML_bc6(ml_gtk_text_view_scroll_to_mark)

ML_6(gtk_text_view_scroll_to_iter, GtkTextView_val, GtkTextIter_val,
     Float_val, Bool_val, Float_val,Float_val, Val_bool)
ML_bc6(ml_gtk_text_view_scroll_to_iter)

ML_2(gtk_text_view_scroll_mark_onscreen, GtkTextView_val, GtkTextMark_val,Unit)

ML_2(gtk_text_view_move_mark_onscreen, GtkTextView_val, GtkTextMark_val,
     Val_bool)

ML_1(gtk_text_view_place_cursor_onscreen, GtkTextView_val, Val_bool)

CAMLprim value ml_gtk_text_view_get_visible_rect (value tv)
{
    GdkRectangle res;
    gtk_text_view_get_visible_rect(GtkTextView_val(tv), &res);
    return Val_copy(res);
}

CAMLprim value ml_gtk_text_view_get_iter_location (value tv, value ti)
{
    GdkRectangle res;
    gtk_text_view_get_iter_location(GtkTextView_val(tv),GtkTextIter_val(ti),
				    &res);
    return Val_copy(res);
}

CAMLprim value ml_gtk_text_view_get_line_at_y (value tv, value y)
{
  CAMLparam2(tv,y);
  CAMLlocal1(res);
  GtkTextIter res1;
  int res2;
  gtk_text_view_get_line_at_y(GtkTextView_val(tv),&res1,
				    Int_val(y),&res2);
  res = alloc_tuple(2);
  Store_field(res,0,Val_GtkTextIter(&res1));
  Store_field(res,1,Val_int(res2));

  CAMLreturn(res);
}


CAMLprim value ml_gtk_text_view_get_line_yrange (value tv, value ti)
{
  CAMLparam2(tv,ti);
  CAMLlocal1(res);
  int y,h;
  
  gtk_text_view_get_line_yrange(GtkTextView_val(tv),
				GtkTextIter_val(ti),
				&y,&h);
  res = alloc_tuple(2);
  Store_field(res,0,Val_int(y));
  Store_field(res,1,Val_int(h));
  CAMLreturn(res);
}

CAMLprim value ml_gtk_text_view_get_iter_at_location (value tv, 
						      value x,
						      value y)
{
  CAMLparam3(tv,x,y);
  GtkTextIter res;
  gtk_text_view_get_iter_at_location(GtkTextView_val(tv),&res,
				    Int_val(x),Int_val(y));
  CAMLreturn(Val_GtkTextIter(&res));
}

CAMLprim value ml_gtk_text_view_buffer_to_window_coords (value tv, 
							 value tt,
							 value x,
							 value y)
{
  CAMLparam4(tv,tt,x,y);
  CAMLlocal1(res);
  int bx,by = 0;

  gtk_text_view_buffer_to_window_coords(GtkTextView_val(tv),
					(GtkTextWindowType)tt,
					Int_val(x),Int_val(y),
					&bx,&by);

  res = alloc_tuple(2);
  Store_field(res,0,Val_int(bx));
  Store_field(res,1,Val_int(by));
  CAMLreturn(res);
}

CAMLprim value ml_gtk_text_view_window_to_buffer_coords (value tv, 
							 value tt,
							 value x,
							 value y)
{
  CAMLparam4(tv,tt,x,y);
  CAMLlocal1(res);
  int bx,by = 0;
  gtk_text_view_window_to_buffer_coords(GtkTextView_val(tv),
					Text_window_type_val(tt),
					Int_val(x),Int_val(y),
					&bx,&by);

  res = alloc_tuple(2);
  Store_field(res,0,Val_int(bx));
  Store_field(res,1,Val_int(by));
  CAMLreturn(res);
}

CAMLprim value ml_gtk_text_view_get_window (value tv, value tt)
{
  CAMLparam2(tv,tt);
  CAMLlocal1(res);
  GdkWindow* tmp;
  tmp = gtk_text_view_get_window(GtkTextView_val(tv), Text_window_type_val(tt));
  res = Val_option(tmp,Val_GdkWindow);
  CAMLreturn(res);
}

ML_2(gtk_text_view_get_window_type,GtkTextView_val,GdkWindow_val,
     Val_text_window_type)

ML_3(gtk_text_view_set_border_window_size,GtkTextView_val,
     Text_window_type_val,Int_val, Unit)

ML_2(gtk_text_view_get_border_window_size,GtkTextView_val,
     Text_window_type_val,Val_int)

ML_2(gtk_text_view_forward_display_line,GtkTextView_val,
     GtkTextIter_val,Val_bool)

ML_2(gtk_text_view_backward_display_line,GtkTextView_val,
     GtkTextIter_val,Val_bool)

ML_2(gtk_text_view_forward_display_line_end,GtkTextView_val,
     GtkTextIter_val,Val_bool)

ML_2(gtk_text_view_backward_display_line_start,GtkTextView_val,
     GtkTextIter_val,Val_bool)

ML_2(gtk_text_view_starts_display_line,GtkTextView_val,
     GtkTextIter_val,Val_bool)


ML_3(gtk_text_view_move_visually,GtkTextView_val,
     GtkTextIter_val,Int_val,Val_bool)

ML_5(gtk_text_view_add_child_in_window,GtkTextView_val,
     GtkWidget_val,Text_window_type_val,Int_val,Int_val,
     Unit)

ML_4(gtk_text_view_move_child,GtkTextView_val,
     GtkWidget_val,Int_val,Int_val,
     Unit)

ML_2(gtk_text_view_set_wrap_mode,GtkTextView_val, Wrap_mode_val,Unit)

ML_1(gtk_text_view_get_wrap_mode,GtkTextView_val, Val_wrap_mode)

ML_2(gtk_text_view_set_editable,GtkTextView_val, Bool_val,Unit)

ML_1(gtk_text_view_get_editable,GtkTextView_val, Val_bool)

ML_2(gtk_text_view_set_cursor_visible,GtkTextView_val, Bool_val,Unit)

ML_1(gtk_text_view_get_cursor_visible,GtkTextView_val, Val_bool)

ML_2(gtk_text_view_set_pixels_above_lines,GtkTextView_val, Int_val,Unit)

ML_1(gtk_text_view_get_pixels_above_lines,GtkTextView_val, Val_int)

ML_2(gtk_text_view_set_pixels_below_lines,GtkTextView_val, Int_val,Unit)

ML_1(gtk_text_view_get_pixels_below_lines,GtkTextView_val, Val_int)

ML_2(gtk_text_view_set_pixels_inside_wrap,GtkTextView_val, Int_val,Unit)

ML_1(gtk_text_view_get_pixels_inside_wrap,GtkTextView_val, Val_int)

ML_2(gtk_text_view_set_justification,GtkTextView_val, Justification_val,Unit)

ML_1(gtk_text_view_get_justification,GtkTextView_val, Val_justification)

ML_2(gtk_text_view_set_left_margin,GtkTextView_val, Int_val,Unit)

ML_1(gtk_text_view_get_left_margin,GtkTextView_val, Val_int)

ML_2(gtk_text_view_set_right_margin,GtkTextView_val, Int_val,Unit)

ML_1(gtk_text_view_get_right_margin,GtkTextView_val, Val_int)

ML_2(gtk_text_view_set_indent,GtkTextView_val, Int_val,Unit)

ML_1(gtk_text_view_get_indent,GtkTextView_val, Val_int)


/* gtktextiter */

ML_1 (gtk_text_iter_get_buffer, GtkTextIter_val, Val_GtkTextBuffer)
ML_1 (gtk_text_iter_get_offset, GtkTextIter_val, Val_int)
ML_1 (gtk_text_iter_get_line, GtkTextIter_val, Val_int)
ML_1 (gtk_text_iter_get_line_offset, GtkTextIter_val, Val_int)
ML_1 (gtk_text_iter_get_line_index, GtkTextIter_val, Val_int)
ML_1 (gtk_text_iter_get_visible_line_index, GtkTextIter_val, Val_int)
ML_1 (gtk_text_iter_get_visible_line_offset, GtkTextIter_val, Val_int)

     // CHECK THIS WITH CHAR <-> GUNICHAR
ML_1 (gtk_text_iter_get_char, GtkTextIter_val, Val_char)

ML_2 (gtk_text_iter_get_slice, GtkTextIter_val, GtkTextIter_val, Val_string)
ML_2 (gtk_text_iter_get_text, GtkTextIter_val, GtkTextIter_val, Val_string)

ML_2 (gtk_text_iter_get_visible_slice, GtkTextIter_val,
      GtkTextIter_val, Val_string)
ML_2 (gtk_text_iter_get_visible_text, GtkTextIter_val,
      GtkTextIter_val, Val_string)
ML_1 (gtk_text_iter_get_pixbuf, GtkTextIter_val, Val_GdkPixbuf)

value ml_gtk_text_iter_get_marks(value ti){
  CAMLparam1(ti);
  CAMLreturn(Val_GSList(gtk_text_iter_get_marks(GtkTextIter_val(ti)),
			Val_GtkTextMark_func));
    }

value ml_gtk_text_iter_get_toggled_tags(value ti, value b){
  CAMLparam2(ti,b);
  CAMLreturn(Val_GSList(gtk_text_iter_get_toggled_tags
			(GtkTextIter_val(ti),Bool_val(b)),
			Val_GtkTextMark_func));
    }

ML_2 (gtk_text_iter_begins_tag,GtkTextIter_val,
      Option_val(arg2,GtkTextTag_val,NULL) Ignore, Val_bool)

ML_2 (gtk_text_iter_ends_tag,GtkTextIter_val,
      Option_val(arg2,GtkTextTag_val,NULL) Ignore, Val_bool)

ML_2 (gtk_text_iter_toggles_tag,GtkTextIter_val,
      Option_val(arg2,GtkTextTag_val,NULL) Ignore, Val_bool)

ML_2 (gtk_text_iter_has_tag,GtkTextIter_val,
      GtkTextTag_val, Val_bool)

value ml_gtk_text_iter_get_tags(value ti){
  CAMLparam1(ti);
  CAMLreturn(Val_GSList(gtk_text_iter_get_tags
			(GtkTextIter_val(ti)),
			Val_GtkTextMark_func));
    }

ML_2 (gtk_text_iter_editable,GtkTextIter_val,
      Bool_val, Val_bool)

ML_2 (gtk_text_iter_can_insert,GtkTextIter_val,
      Bool_val, Val_bool)

ML_1 (gtk_text_iter_starts_word, GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_ends_word, GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_inside_word,GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_starts_line,GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_ends_line,GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_starts_sentence,GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_ends_sentence,GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_inside_sentence,GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_is_cursor_position,GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_get_chars_in_line, GtkTextIter_val, Val_int)

ML_1 (gtk_text_iter_get_bytes_in_line, GtkTextIter_val, Val_int)

ML_1 (gtk_text_iter_is_end,GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_is_start,GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_forward_char,GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_backward_char,GtkTextIter_val, Val_bool)

ML_2 (gtk_text_iter_forward_chars,GtkTextIter_val, Int_val, Val_bool)

ML_2 (gtk_text_iter_backward_chars,GtkTextIter_val, Int_val, Val_bool)

ML_1 (gtk_text_iter_forward_line,GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_backward_line,GtkTextIter_val, Val_bool)

ML_2 (gtk_text_iter_forward_lines,GtkTextIter_val, Int_val, Val_bool)

ML_2 (gtk_text_iter_backward_lines,GtkTextIter_val, Int_val, Val_bool)

ML_1 (gtk_text_iter_forward_word_end,GtkTextIter_val, Val_bool)

ML_2 (gtk_text_iter_forward_word_ends,GtkTextIter_val, Int_val, Val_bool)

ML_1 (gtk_text_iter_backward_word_start,GtkTextIter_val, Val_bool)

ML_2 (gtk_text_iter_backward_word_starts,GtkTextIter_val, Int_val, Val_bool)

ML_1 (gtk_text_iter_forward_cursor_position,GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_backward_cursor_position,GtkTextIter_val, Val_bool)

ML_2 (gtk_text_iter_forward_cursor_positions, GtkTextIter_val,
      Int_val, Val_bool)

ML_2 (gtk_text_iter_backward_cursor_positions, GtkTextIter_val, 
      Int_val, Val_bool)

ML_1 (gtk_text_iter_forward_sentence_end, GtkTextIter_val, Val_bool)

ML_1 (gtk_text_iter_backward_sentence_start, GtkTextIter_val, Val_bool)

ML_2 (gtk_text_iter_forward_sentence_ends, GtkTextIter_val,
      Int_val, Val_bool)

ML_2 (gtk_text_iter_backward_sentence_starts, GtkTextIter_val,
      Int_val, Val_bool)

ML_2 (gtk_text_iter_set_offset, GtkTextIter_val, Int_val, Unit)
ML_2 (gtk_text_iter_set_line, GtkTextIter_val, Int_val, Unit)
ML_2 (gtk_text_iter_set_line_offset, GtkTextIter_val, Int_val, Unit)
ML_2 (gtk_text_iter_set_line_index, GtkTextIter_val, Int_val, Unit)
ML_2 (gtk_text_iter_set_visible_line_index, GtkTextIter_val, Int_val, Unit)
ML_2 (gtk_text_iter_set_visible_line_offset, GtkTextIter_val, Int_val, Unit)


ML_1 (gtk_text_iter_forward_to_end, GtkTextIter_val, Unit)
ML_1 (gtk_text_iter_forward_to_line_end, GtkTextIter_val, Val_bool)
ML_2 (gtk_text_iter_forward_to_tag_toggle, GtkTextIter_val, GtkTextTag_val,
      Val_bool)
ML_2 (gtk_text_iter_backward_to_tag_toggle, GtkTextIter_val, GtkTextTag_val,
      Val_bool)
     

ML_2 (gtk_text_iter_equal, GtkTextIter_val, GtkTextIter_val, Val_bool)
ML_2 (gtk_text_iter_compare, GtkTextIter_val, GtkTextIter_val, Val_int)
ML_3 (gtk_text_iter_in_range, GtkTextIter_val, GtkTextIter_val,
      GtkTextIter_val, Val_int)
ML_2 (gtk_text_iter_order, GtkTextIter_val, GtkTextIter_val, Unit)
