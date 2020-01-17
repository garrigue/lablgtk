.PHONY: build build-all nopromote opam clean

build:
	dune build

# This also builds examples
build-all:
	dune build @all

nopromote:
	dune build @all --ignore-promoted-rules

# We first pin lablgtk3 as to avoid problems with parallel make
OPAM_PKGS=lablgtk3 lablgtk3-sourceview3 lablgtk3-sourceview4 lablgtk3-gtkspell3
opam:
	for pkg in $(OPAM_PKGS) ; do \
		opam pin add $$pkg . --kind=path -y ; \
		opam install $$pkg ; \
	done

clean:
	dune clean
