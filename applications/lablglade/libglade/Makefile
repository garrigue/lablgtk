GLADETOPDIR = /usr/local/src/glade-0.4.1
GLADEDIR = $(GLADETOPDIR)/glade
LABLGTKDIR = ../../..
CAMLINCLUDE = /usr/local/lib/ocaml

INCLUDES = -I$(GLADETOPDIR)/intl -I$(CAMLINCLUDE) -I$(LABLGTKDIR) 
DEFS = -DHAVE_CONFIG_H -I. -I$(GLADEDIR) -I$(GLADETOPDIR)
CPPFLAGS = 
LDFLAGS = 
CC = gcc
RANLIB = ranlib
VERSION = 0.4.1

include ../config.make

glade_AOBJECTS =  debug.o editor.o gbwidget.o glade.o glade_clipboard.o \
	glade_gtk10lib.o glade_gtk11lib.o glade_keys_dialog.o \
	glade_menu_editor.o glade_newcomp_dialog.o glade_palette.o \
	glade_palette_button.o glade_project.o glade_project_options.o \
	glade_project_view.o gtkfontsel.o keys.o load.o \
	palette.o property.o save.o source.o source_os2.o styles.o \
	tree.o utils.o

CFLAGS = -g -O2 -I/usr/X11R6/include -I/usr/local/lib/glib/include -I/usr/local/include -Wall
COMPILE = $(CC) $(DEFS) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS)

all: libglade.a

libglade.a: $(glade_AOBJECTS) glade_project_window.o 
	@rm -f libglade.a
	ar rc $@ $(glade_AOBJECTS) glade_project_window.o
	$(RANLIB) $@

.DEFAULT:
	ln -s $(GLADEDIR)/$<

.c.o:
	$(COMPILE) -c $<

glade_project_window.o: glade_project_window.c glade_project_window.h

clean:
	rm -f *.o *.a

ctest.o: ctest.c
	cc -c -I. -I$(GLADEDIR) -I/usr/X11R6/include -I/usr/local/lib/glib/include -I/usr/local/include  $<

ctest: ctest.o libglade.a
	cc -o $@ ctest.o libglade.a $(GLADEDIR)/gbwidgets/libgbwidgets.a $(GTKLIBS)
