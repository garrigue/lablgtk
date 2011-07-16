
OCAMLC=ocamlc
OPT=-g -dtypes
INCLUDES= -I xml-light xml-light.cma 
extract_stubs: extract_prototype.ml xml-light/xml-light.cma
	$(OCAMLC) $(OPT) $(INCLUDES) -o $@ $^

test: extract_stubs
	./extract_stubs /usr/share/gir-1.0/Gtk-2.0.gir > LOG

check: test
	cd stubs ; ocamlc -c -ccopt '`pkg-config --cflags gtk+-2.0`' ml_stubs_Gtk.c 2> ERRORS

clean:
	rm -f extract_stubs *.annot extract_prototype.cm* ml_stubs.c stubs.ml
	$(MAKE) -C xml-light clean

xml-light/xml-light.cma:
	$(MAKE) -C xml-light

