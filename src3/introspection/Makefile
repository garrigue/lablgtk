OCAMLC=ocamlc
OPT=-g -dtypes
INCLUDES= -I `ocamlfind query xml-light`
LIBS=xml-light.cma str.cma

extract_stubs: extract_prototype.ml
	$(OCAMLC) $(OPT) $(INCLUDES) $(LIBS) -o $@ $^

GIRDIR=/opt/local/share/gir-1.0

all: stubs/lablgtk3

extract: extract_stubs
	./extract_stubs $(GIRDIR)/Gtk-3.0.gir > LOG

stubs/stubs_Gtk.ml: extract_stubs
	$(MAKE) extract

stubs/lablgtk3: stubs/stubs_Gtk.ml
	cd stubs ; \
	ocamlc -I ../../ -c tags_*.ml; \
	ocamlc -I ../../ -i stubs_Gtk.ml > stubs_Gtk.mli; \
	ocamlc  -I ../../ -c stubs_Gtk.mli; \
	ocamlc -I ../../ -c stubs_Gtk.ml; \
	ocamlc -c -ccopt '`pkg-config --cflags gtk+-3.0`' ml_stubs_Gtk.c; \
	ocamlmktop -verbose -ccopt "`pkg-config --cflags --libs gtk+-3.0`" -I ../../ -I . ../../wrappers.o  ../../ml_gvaluecaml.o ../../ml_glib.o ../../ml_gpointer.o ../../ml_gobject.o ml_stubs_Gtk.o -cclib -lgtk-3 ../../gaux.cmo ../../gpointer.cmo ../../gobject.cmo ../../gtkObject.cmo ../../gtkSignal.cmo ../../gtk.cmo tags_*.cmo stubs_Gtk.ml -custom -o lablgtk3

test: stubs/lablgtk3
	./stubs/lablgtk3 -I stubs -I .. hello_world.ml

clean:
	rm -f extract_stubs *.annot extract_prototype.cm* ml_stubs.c stubs.ml \
	  stubs/*
	$(MAKE) -C xml-light clean

xml-light/xml-light.cma:
	$(MAKE) -C xml-light

