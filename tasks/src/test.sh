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
cd "${BUILD_WORKSPACE_DIRECTORY:-$(dirname "$0")/..}" || exit 1

code=0

# shellcheck source=/dev/null
. "$(runfile misc_rules/tasks/sync-workspace-tests)"

printf "\\nrunning workspace tests in tests/workspaces/\\n\\n"

while read -r f; do
    name=$f
    name=${name#"tests/workspaces/"}
    name=${name%"/test"}
    echo "- $name"
    pushd "${f%test}" > /dev/null
    (cd ./tools )
    output=$(./test 2>&1)
    cmd_code=$?
    if [ $cmd_code -ne 0 ]
    then
        printf "\\n"
        printf "%s" "$output" | sed "s/^/  /"
        printf "\\n\\nexited with code %s\\n\\n" "$cmd_code"
        code=1
    fi
    popd > /dev/null
done < <(find tests/workspaces -name test -type f | sort)

printf "\\ntests complete\\n"

exit $code
