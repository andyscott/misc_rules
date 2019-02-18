load("//rules/shellcheck:shellcheck.bzl", "shellcheck_toolchain")

shellcheck_toolchain(
    name = "_shellcheck_from_nixpkgs",
    shellcheck = "@shellcheck//:bin/shellcheck",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "shellcheck_from_nixpkgs",
    toolchain = ":_shellcheck_from_nixpkgs",
    toolchain_type = "@rules_adroit//rules/shellcheck:toolchain_type",
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
    shellcheck = "@rules_adroit//toolchains:_host_path_shellcheck",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "shellcheck_from_host_path",
    toolchain = ":_shellcheck_from_host_path",
    toolchain_type = "@rules_adroit//rules/shellcheck:toolchain_type",
    visibility = ["//visibility:public"],
)
