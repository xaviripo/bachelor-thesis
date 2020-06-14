## Setup

In order to be able to type check and compile Agda files, the Agda compiler should be set up.
Optionally, Agda offers what is known as the Emacs mode, which is an Emacs extension that makes Agda into an interactive proof assistant.
We will not worry about the Emacs extension in this work, but rather just on being able to compile Agda files via terminal.


### Using Docker

Installing Agda itself is not extremely difficult, even for users unfamiliar with Haskell or compilation processes in general.
For our particular purposes, though, there is an important blocking issue.
As our intention is to develop proofs in homotopy type theory, it is appropriate to try and work with the HoTT-Agda library developed by the Univalent Foundations Program researchers @brunerie_homotopy_nodate.
Unfortunately, the library has not been updated to work with the latest version of the Agda compiler.
If one wants to be able to develop on this library and, simultaneously, try newer features of the Agda compiler, they have to manage two (or more) parallel versions of Agda.
This is not very practical, as different versions of Agda require different versions of the Haskell compiler and its dependencies, and Agda needs configuration files which can differ depending on the particular libraries one wants to use.
Besides, one must then be careful not to update the Agda installation until the libraries' maintainers have adapted the code for the latest version.
Users who have worked with global package managers (e.g. Python, Cabal, tlmgr, and most operating system package managers) know how big of a hassle this can be.

With this in mind, a system has been developed to "encapsulate" each Agda and its dependencies in a per-project basis.
The system uses Docker images developed by Ting-gian Lua^[<https://hub.docker.com/r/banacorn/agda/>.], which instead of installing Agda on the host computer, run it inside a virtualized environment so the user can switch between different versions easily.
On top of that, a script has been implemented to manage libraries.

The sources and instructions for using such development can be found in the attachments.


### Local installation

If the reader still wants to install Agda on their computer, there are a few ways to do so.

The official project does not offer the precompiled binaries, but there are some platforms that distribute them.
For UNIX-like systems, one can look in their preferred package manager.
For Windows, a precompiled installer for the latest version exists at <http://homepage.divms.uiowa.edu/~astump/agda/>.
Nonetheless, these may be outdated and sometimes have setup issues.

A viable alternative is to compile Agda's compiler from source.
This is a resource-heavy task, so it is advised to try only on more powerful computers.
The official recommendation is to install through Haskell's Cabal, a toolchain for building and packaging Haskell programs.
Unfortunately, Caball generally works with a global package index^[It is possible to use a newer mode known as *sandboxes*. This posed technical issues with older Agda versions and so was not taken as the main route, but the reader is encouraged to consider the option.], and so installing Agda's dependencies might conflict with already installed Haskell packages, if there were any.

In order to do so one just has to install directly using the Cabal command line interface^[<https://agda.readthedocs.io/en/v2.6.1/getting-started/installation.html#installation-from-hackage>.], specifying the desired Agda version. For example, for version 2.5.3, one would use:

```sh
cabal install Agda-2.5.3
```

If that fails, it might be necessary to install the Alex and Happy packages (dependencies for parsing Agda code) beforehand:

```sh
cabal install alex
cabal install happy
```

A preferable method might be Haskell's Stack, which aims to solve a few issues that Cabal presents, lack of isolation being one of them.
For this, one has to download the required version of Agda from the repository^[<https://github.com/agda/agda/releases>.].
Then, inside the root folder, execute:

```sh
stack install --stack-yaml=<X>
```

Where `<X>`{.sh} stands for any of the `stack-*.yaml`{.sh} files in the root folder.
Stack will compile the binaries and copy them to `~/.local/bin`{.sh} (or the location shown by running `stack path --local-bin`{.sh}).
This location should be added to the PATH environment variable.

Then, one should be able to run Agda successfully:

```sh
agda --version
```

When installing via Stack, it is possible that Emacs mode does not work due to relative location issues.^[See the following issue: <https://github.com/commercialhaskell/stack/issues/848>.]

Finally, independently of whether Cabal or Stack was used, the dependencies need to be set up.
For each necessary library, the following steps have to be taken:

1. Download the library to some location where it can stay.
Most Agda libraries are available on GitHub.
It is very important to download a release of the library that is documented to work with the Agda version installed, otherwise things will fail.

2. Copy the absolute location of the `*.agda-lib`{.sh} file inside the library to the `libraries`{.sh} file.
This file should be placed in `~/.agda`{.sh}, or in `%appdata%\Agda`{.sh} in the case of Windows, and should contain one file location per line.

3. Write the library name, which can be found inside the `*.agda-lib`{.sh} file seen before, inside the `defaults`{.sh} file.
The `defaults`{.sh} file should be placed in the same location as `libraries`{.sh} and also admits one library name by line.
Setting the `defaults`{.sh} file is not strictly necessary, as one can use the `--library`{.sh} flag when running Agda to achieve the same result.

If everything has been done correctly, one should be able to check the installation of Agda:

```sh
agda --version
```

Running Agda is very simple.
One executes `agda`{.sh} followed by the name of the `*.agda`{.sh} file.
The default action of Agda when given a file is to type check it, if we want to compile it into an executable binary, we must also pass a `--compile`{.sh} flag.
This is because, in general, when using Agda for mathematics, the interesting part is usually just the type checking, due to the Curry-Howard correspondence.

If the values defined in the file are correctly typed, Agda will either display no output or just display a message stating that it is checking the file.
Either way, if there are no errors displayed, this means that the file type checks correctly and, therefore, that the proof it contains is correct.

Agda admits other flags, such as `--without-K`{.sh}, that will later be explained in detail.

The most important thing to have in mind is that, in order for Agda to properly recognize the modules we define, it must be run from the "root" directory of our project.
For instance, if we define a file `this/is/a/Test.agda`{.sh} with a root module `this.is.a.Test`{.agda}, then Agda must be executed from the directory that contains `this`{.sh} (e.g. `agda this/is/a/Test.agda`{.sh}), otherwise it will fail to find the file.
Modules are explained in further detail in @sec:agda_language_modules.
