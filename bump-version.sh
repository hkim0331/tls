#!/bin/sh
#
# origin: ${utils}/src/bump-version.sh
#
# bump-vesion script for clojure projects.
# confused using macos's /usr/bin/sed. so gsed.
#
# CAUSION
# The POSIX standard regular expressions does not support back-references.
# Back-references are considered as an "extended" faciliy.
# This script, bump-version.sh, uses the extended function.
# So, gnu-sed on macOS.

if [ -z "$1" ]; then
    echo "usage: $0 <version>"
    exit
fi

# using extended regular expressions in this script, so,
if [ -x "${HOMEBREW_PREFIX}/bin/gsed" ]; then
    SED="${HOMEBREW_PREFIX}/bin/gsed -E"
else
    SED="/usr/bin/sed -E"
fi

# ${SED} -i "s/version .*$/version $1/" src/todo-index.html
# ${SED} -i "s/version .*$/version $1/" src/todo-create.html
# ${SED} -i "s/version .*$/version $1/" src/todo-detail.html
