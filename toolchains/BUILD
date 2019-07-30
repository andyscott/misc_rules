load("//rules/shellcheck:shellcheck.bzl", "shellcheck_toolchain")
load("//rules/yamllint:yamllint.bzl", "yamllint_toolchain")

# shellcheck

shellcheck_toolchain(
    name = "_shellcheck_from_nixpkgs",
    shellcheck = "@shellcheck//:bin/shellcheck",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "shellcheck_from_nixpkgs",
    toolchain = ":_shellcheck_from_nixpkgs",
    toolchain_type = "@misc_rules//rules/shellcheck:toolchain_type",
    visibility = ["//visibility:public"],
)

genrule(
    name = "_host_path_shellcheck_script",
    outs = ["host_path_shellcheck.sh"],
    cmd = "\n".join([
        "cat << EOF > $@",
        "#!/usr/bin/env bash",
        "eval shellcheck \"\$$@\"",
        "EOF",
    ]),
)

sh_binary(
    name = "_host_path_shellcheck",
    srcs = [":_host_path_shellcheck_script"],
    visibility = ["//visibility:public"],
)

shellcheck_toolchain(
    name = "_shellcheck_from_host_path",
    shellcheck = "@misc_rules//toolchains:_host_path_shellcheck",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "shellcheck_from_host_path",
    toolchain = ":_shellcheck_from_host_path",
    toolchain_type = "@misc_rules//rules/shellcheck:toolchain_type",
    visibility = ["//visibility:public"],
)

# yamllint

yamllint_toolchain(
    name = "_yamllint_from_nixpkgs",
    yamllint = "@yamllint//:bin/yamllint",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "yamllint_from_nixpkgs",
    toolchain = ":_yamllint_from_nixpkgs",
    toolchain_type = "@misc_rules//rules/yamllint:toolchain_type",
    visibility = ["//visibility:public"],
)
