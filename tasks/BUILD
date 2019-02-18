load("//rules/shellcheck:shell.bzl", "shell_binary")

shell_binary(
    name = "ci",
    srcs = ["src/ci.sh"],
    data = [
        ":lint",
    ],
    tags = ["manual"],
    deps = [
        "@bazel_tools//tools/bash/runfiles",
    ],
)

shell_binary(
    name = "lint",
    srcs = ["src/lint.sh"],
    tags = ["manual"],
    deps = [
        "@bazel_tools//tools/bash/runfiles",
    ],
)
