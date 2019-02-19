load("//rules/shellcheck:shell.bzl", "shell_binary")

shell_binary(
    name = "ci",
    srcs = ["src/ci.sh"],
    data = [
        ":build",
        ":lint",
        ":test",
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

shell_binary(
    name = "build",
    srcs = ["src/build.sh"],
    tags = ["manual"],
    deps = [
        "@bazel_tools//tools/bash/runfiles",
    ],
)

shell_binary(
    name = "test",
    srcs = ["src/test.sh"],
    data = [
        ":sync-workspace-tests",
    ],
    tags = ["manual"],
    deps = [
        "@bazel_tools//tools/bash/runfiles",
    ],
)

shell_binary(
    name = "sync-workspace-tests",
    srcs = ["src/sync-workspace-tests.sh"],
    tags = ["manual"],
    deps = [
        "@bazel_tools//tools/bash/runfiles",
    ],
)
