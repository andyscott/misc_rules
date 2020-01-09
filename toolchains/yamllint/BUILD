load("//rules/yamllint:yamllint.bzl", "yamllint_toolchain")

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
