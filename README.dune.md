This file describes the Dune setup for lablgtk and the release
instructions.

## Dune setup

Dune takes care of all the C-stub needed to compile lablgtk almost
automatically. The `src/dune` file is mostly self-describing.

### Packaging choices and C library version detection

The main choice we had to do is how to structure the OPAM packages. In
lablgtk2, there was a single package, however it would build different
binaries based on what it could detect. This was a bit fragile due to
lack of reproducible, thus in lablgtk3 each C library has its own OPAM
package.

We still depend on the `conf-packages`, but note however that the
build system does it own versioned C library check.

The discussion at the caml-list
https://sympa.inria.fr/sympa/arc/caml-list/2018-12/msg00017.html
provides some more insight on this choice.

The `dune_config` tool is a simple wrapper that can be used to query
`pkg-config` for flags and version checks.

### Auto-generation of files

The lablgtk3 build uses the `varcc` and `propcc` scripts to
auto-generate some files. The rules for such files are in
`dune-enum.sexp` and `dune-prop.sexp`. These files could be also
auto-generated in the future using Dune's promote mechanism.

## How to release a new version of lablgtk to OPAM

**Quick release instructions:** Run `git tag -a` + `dune-release`.

The preferred workflow to release a new set of OPAM packages is to use
`dune-release`.

### Format of the CHANGES.md file

`dune-release` will take each top-level markdown item as the changelog
for the current version, thus be aware of not introducing `#` markers.

### Detailed notes

The first (and most important) step is to tag the release and push it
to the main repository.

We recommend you do this manually. As `dune-release` uses `git
describe` to gather versioning information, your tag must be
annotated. Using `git tag -a` or `git tag -s` will do the job. Please
add the version changes to the tag annotation message.

You can also use `dune-release tag`, which will try to infer the
tag information from `CHANGES.md`, however the current heuristics
seem too fragile and the changes list may not be properly updated.

Once the tag is in place, calling `dune-release` will build, lint, run
the tests, create the opam package, upload the archives and
docs to the release page, and submit a pull request to the OPAM
repository.

Under the hood, `dune-release` executes the following 4 commands:

```
dune-release distrib       # Create the distribution archive
dune-release publish       # Publish it on the WWW with its documentation
dune-release opam pkg      # Create an opam package
dune-release opam submit   # Submit it to OCaml's opam repository
```

It is often useful to run the commands separately as to have better
control of the release process.

Note that you will need the proper permissions for the `publish` step,
including setting a Github access token, see `dune-release help
files` for more information.
