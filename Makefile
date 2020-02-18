.PHONY: help release dev dev-all nopromote opam clean

help:
	@echo "Welcome to lablgtk Dune-based build system. Targets are"
	@echo ""
	@echo "  - release:   build lablgtk package in release mode"
	@echo "  - dev:       build in developer mode [requires extra dependencies]"
	@echo "  - dev-all:   build in developer mode [requires extra dependencies]"
	@echo "  - nopromote: dev build but without re-running camlp5 generation"
	@echo "  - opam:      internal, used in CI testing"
	@echo "  - clean:     clean build tree"
	@echo ""
	@echo "WARNING: Packagers should not use this makefile, but call dune"
	@echo "directly with the right options for their distribution, see README"

release:
	dune build -p lablgtk3

dev:
	dune build

# This also builds examples, will be the default once we set (lang dune 2.0)
dev-all:
	dune build @all

nopromote:
	dune build @all --ignore-promoted-rules

# We first pin lablgtk3 as to avoid problems with parallel make
opam:
	opam pin add lablgtk3 . --kind=path -y
	opam install lablgtk3
	opam pin add lablgtk3-sourceview3 . --kind=path -y
	opam install lablgtk3-sourceview3
	opam pin add lablgtk3-gtkspell3 . --kind=path -y
	opam install lablgtk3-gtkspell3

clean:
	dune clean
