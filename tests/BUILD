load("@rules_adroit//rules/shellcheck:shellcheck.bzl", "shellcheck_test")

test_files = [
    file for file in
    glob(["workspaces/**/test"])
    if "/bazel-" not in file
]
[
    shellcheck_test(
        name = "%s@shellcheck" % test_file,
        srcs = [test_file],
        visibility = ["//visibility:public"],
    )
    for test_file in test_files
]
