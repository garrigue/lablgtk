include ../../config.make

PROGS=hello_world$(XE)

all: $(PROGS)

hello_world$(XE): hello_world.ml ../lablgtk.cmxa
	$(CAMLOPT) -o $@ -I ../stubs -I .. lablgtk.cmxa $<
