load("@rules_adroit//rules/shellcheck:shellcheck.bzl", "shellcheck_test")

[
    shellcheck_test(
        name = "%s@shellcheck" % test_file,
        srcs = [test_file],
    )
    for test_file in glob(["workspaces/**/test"])
]
