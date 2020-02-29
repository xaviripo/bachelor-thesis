# Agda

This folder contains developments written in Agda.
In this file information about setting up the environment to work with Agda is
detailed.


## Installation

### Preliminaries

Agda is a dependently-typed functional programming language. Its main function
is as a proof assistant, this is, a software designed to aid mathematicians and
other technical workers in developing rigorous proofs.

To use Agda one needs to install the compiler. Although the compiler is capable
of generating executable binaries which can be run and have I/O effects, proof
development often involves only typechecking.

The Agda compiler is written in [Haskell](https://www.haskell.org) with the help
of a couple of libraries ([Alex](https://www.haskell.org/alex/) and
[Happy](https://www.haskell.org/happy/)). The packages are posted to
[Hackage](https://hackage.haskell.org/), the central Haskell package repository.

Aside from the compiler, Agda also offers an extension for the text editor
[GNU Emacs](https://www.gnu.org/software/emacs/), known as agda-mode, which
offers the *interactive* part of the proof development. Although this is
optional, it's very recommended to speed up working with Agda files.
agda-mode is also available for Atom via an
[extension](https://atom.io/packages/agda-mode).


### Agda and agda-mode

The official installation instructions can be found in
[the Agda documentation](https://agda.readthedocs.io/en/v2.6.0.1/getting-started/prerequisites.html). Be aware that the documentation
can be obsolete, so consider every step carefully.

TODO Mention local Cabal installs ("Nix-style") as an alternative to the
documentation-recommended global installs

The prerequisites listed on the Agda documentation are mostly Haskell packages.
As such, Cabal will take care of them when trying to install Agda and so you
shouldn't worry about them too much. Installing GHC and cabal-install should
be enough. To do this, follow the instructions for your platform in
[here](https://www.haskell.org/downloads/#minimal). Make sure to install one of
the supported versions of GHC, otherwise you risk cabal-install not finding the
appropriate version of the required dependencies.

Once GHC and cabal-install are set up, run the following commands listed in the
documentation. Remember to include the Cabal binaries (probably in
`~/.cabal/bin`) to your path. Running `agda-mode setup` is only necessary if
you want to use Emacs' agda-mode.


### Libraries

After installing and setting up Agda and agda-mode, you will probably want to
install some libraries.

For example, many Agda programs depend on the standard library. To install it,
following the instructions
[here](https://github.com/agda/agda-stdlib/blob/master/notes/installation-guide.md).


### Homotopy Type Theory

The working group on homotopy type theory wrote a [library](https://github.com/HoTT/HoTT-Agda)
for Agda. The installation instructions are available in the repositorty's
README.md file. Unfortunately, the library is not currently up to date and,
consequently, it isn't compatible with the latest version of Agda.

So, in order to use this library, one must downgrade their Agda installation.
This can cause further complications, as each version of Agda is only compatible
with a certain range of versions of GHC, the Haskell base package, and the Cabal
library, and older versions of these packages can be harder to find or not
supported by your operating system anymore.

Having different versions of GHC installed side by side is possible, but must
be handled with care.