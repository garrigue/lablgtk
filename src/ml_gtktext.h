
#define GtkTextMark_val(val) check_cast(GTK_TEXT_MARK,val)
#define Val_GtkTextMark(val) (Val_GObject((GObject*)val))
#define Val_GtkTextMark_new(val) (Val_GObject_new((GObject*)val))

        
#define GtkTextTag_val(val) check_cast(GTK_TEXT_TAG,val)
#define Val_GtkTextTag(val) (Val_GObject((GObject*)val))
#define Val_GtkTextTag_new(val) (Val_GObject_new((GObject*)val))

#define GtkTextTagTable_val(val) check_cast(GTK_TEXT_TAG_TABLE,val)
#define Val_GtkTextTagTable(val)  (Val_GObject((GObject*)val))
#define Val_GtkTextTagTable_new(val) (Val_GObject_new((GObject*)val))

#define GtkTextBuffer_val(val) check_cast(GTK_TEXT_BUFFER,val)
#define Val_GtkTextBuffer(val)  (Val_GObject((GObject*)val))
#define Val_GtkTextBuffer_new(val) (Val_GObject_new((GObject*)val))

#define GtkTextChildAnchor_val(val) check_cast(GTK_TEXT_CHILD_ANCHOR,val)
#define Val_GtkTextChildAnchor(val)  (Val_GObject((GObject*)val))
#define Val_GtkTextChildAnchor_new(val) (Val_GObject_new((GObject*)val))


/* "Lighter" version: allocate in the ocaml heap (see ml_gtktext.c 
   for other definitions. */
#define GtkTextIter_val(val) ((GtkTextIter*)MLPointer_val(val))
#define Val_GtkTextIter(it) (copy_memblock_indirected(it,sizeof(GtkTextIter)))
#define alloc_GtkTextIter() (alloc_memblock_indirected(sizeof(GtkTextIter))

#define GtkTextView_val(val) check_cast(GTK_TEXT_VIEW,val)


