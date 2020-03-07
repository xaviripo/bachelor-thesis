#!/usr/bin/env bash

# run.sh
# This file just invokes docker with the appropriate parameters to run Agda.

### Prelude
## Options
# Agda version. Default is the latest supported version for HoTT-Agda
VERSION="2.5.3"
# Space-separated libraries to be included. Give the names as stated INSIDE their
# .agda-lib files. The available libraries can be found in deps/libraries
LIBRARIES="src"
# Whether to clean the workspace (including deleting installed dependencies)
# before execution
CLEAN="no"

usage() {
    cat <<EOM
Usage: $0 [-c] [-v VERSION] [-l LIBRARY ...] FILE
-c --clean              Clean the dependencies before running (default: $CLEAN)
-v --version    VERSION Specify the Agda version to run (default: "$VERSION")
-l --library    LIBRARY Specify a library name to include; can be used multiple times (default: "$LIBRARIES")
                FILE    Agda file to typecheck.

EOM
    exit 1
}

## Argument parsing
# Horrible code I found on Stackoverflow to parse arguments in bash.
# Source: https://stackoverflow.com/a/29754866

    # saner programming env: these switches turn some bugs into errors
    set -o errexit -o pipefail -o noclobber -o nounset

    # -allow a command to fail with !’s side effect on errexit
    # -use return value from ${PIPESTATUS[0]}, because ! hosed $?
    ! getopt --test > /dev/null 
    if [[ ${PIPESTATUS[0]} -ne 4 ]]; then
        echo 'I’m sorry, `getopt --test` failed in this environment.'
        exit 1
    fi

    OPTIONS=hcv:l:
    LONGOPTS=help,clean,version:,library:

    # -regarding ! and PIPESTATUS see above
    # -temporarily store output to be able to check for errors
    # -activate quoting/enhanced mode (e.g. by writing out “--options”)
    # -pass arguments only via   -- "$@"   to separate them correctly
    ! PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@")
    if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
        # e.g. return value is 1
        #  then getopt has complained about wrong arguments to stdout
        exit 2
    fi
    # read getopt’s output this way to handle the quoting right:
    eval set -- "$PARSED"

    # now enjoy the options in order and nicely split until we see --
    while true; do
        case "$1" in
            -v|--version)
                VERSION="$2"
                shift 2
                ;;
            -l|--library)
                LIBRARIES="${LIBRARIES} $2"
                shift 2
                ;;
            -c|--clean)
                CLEAN="yes"
                shift 1
                ;;
            -h|--help)
                usage
                ;;
            --)
                shift
                break
                ;;
            *)
                echo $1
                echo "Programming error"
                exit 3
                ;;
        esac
    done

    # handle non-option arguments
    if [[ $# -ne 1 ]]; then
        usage
    fi

# End of horrible code.

### Variables
# Options for docker
DIRNAME="$( dirname $0 )"
ROOT="$( realpath $DIRNAME/.. )"
OPTIONS="-v $ROOT:$ROOT"
IMAGE="banacorn/agda"

# Options for Agda
FILE="$( realpath $1 )"
LIBRARIES_FILE="$ROOT/deps/libraries"
LIBRARIES_FULL=$(for lib in $LIBRARIES; do echo "--library $lib"; done)

### Running
# Clean if indicated
if [ "$CLEAN" = "yes" ]
then
    (cd $DIRNAME/..; make clean-agda)
fi

# Install dependencies if necessary
(cd $DIRNAME/..; make agda)

# Run docker
(set -x; # Print the command when executing it
docker run $OPTIONS $IMAGE:$VERSION \
agda $FILE --library-file=$LIBRARIES_FILE $LIBRARIES_FULL
)