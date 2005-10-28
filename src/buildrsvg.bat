ocamlc -c rsvg.mli
ocamlc -a -o lablrsvg.cma rsvg.ml -cclib -llablrsvg -dllib -llablrsvg -cclib "librsvg-2.lib"
del rsvg.cmo