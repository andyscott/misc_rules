#!/usr/bin/env bash

# --- begin bash runfile prelude --
if [[ -e "${TEST_SRCDIR:-}" ]]; then
    function runfile() {
        echo "$TEST_SRCDIR/$1"
    }
elif [[ -f "$0.runfiles_manifest" ]]; then
    __runfiles_manifest_file="$0.runfiles_manifest"
    export __runfiles_manifest_file
    function runfile() {
        grep -m1 "^$1 " "$__runfiles_manifest_file" | cut -d ' ' -f 2-
    }
else
    echo "please run this script through bazel"
    exit 1
fi
export -f runfile
# --- end bash runfile prelude --

set -euo pipefail

cd "${BUILD_WORKSPACE_DIRECTORY:-$(dirname "$0")/..}"
printf "syncing test workspaces\\n\\n"
while read -r f; do
    fd=$(dirname "$f")
    pushd "$fd" > /dev/null

    N=$(echo "$f" | awk -F'/+' '{print NF-1}')
    rel=$(printf "%${N}s" | sed 's/ /..\//g')

    echo "- set local repo path to $rel"
    escaped_rel=$(echo "$rel" | sed 's/\//\\\//g')
    sed -i.bak "s/^\\( *path *= *\"\\).*\\(\",\\{0,1\\}\\)$/\\1${escaped_rel}\\2/" WORKSPACE
    rm WORKSPACE.bak

    rm -f .bazelrc
    ln -s "${rel}".bazelrc .bazelrc
    echo "- link $fd/.bazelrc -> ${rel}.bazelrc"

    mkdir -p tools
    rm -f ./tools/bazel
    cd ./tools
    ln -s "${rel}../tools/bazel" bazel
    echo "- link $fd/tools/bazel -> ${rel}../tools/bazel"

    popd > /dev/null
done < <(find tests/workspaces -name WORKSPACE -type f | sort)
printf "\\ndone\\n"
