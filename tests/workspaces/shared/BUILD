package(default_visibility = ["//visibility:public"])

load("@misc_rules//rules/shellcheck:shellcheck.bzl", "shellcheck_test")
load("@misc_rules//rules/yamllint:yamllint.bzl", "yamllint_test")
load("@misc_rules//rules/black:black.bzl", "black_test")

shellcheck_test(
    name = "shellcheck_test",
    srcs = [
        "input.sh",
    ],
)

yamllint_test(
    name = "yamllint_test",
    srcs = [
        "input.yaml",
    ],
)

black_test(
    name = "black_test",
    srcs = [
        "input_0.py",
    ],
)

black_test(
    name = "black_test_config_a",
    srcs = [
        "input_1.py",
    ],
    config = "pyproject_10.toml",
)

black_test(
    name = "black_test_config_b",
    srcs = [
        "input_1.py",
    ],
    config = "pyproject_100.toml",
)
