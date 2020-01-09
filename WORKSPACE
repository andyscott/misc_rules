workspace(name = "misc_rules")

load(":workspace0.bzl", "workspace0")

workspace0()

load(":workspace1.bzl", "workspace1")

workspace1()

load("@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl", "nixpkgs_package")

nixpkgs_package(
    name = "shellcheck",
    repository = "@nixpkgs",
)

nixpkgs_package(
    name = "yamllint",
    attribute_path = "python36Packages.yamllint",
    repository = "@nixpkgs",
)

register_toolchains(
    "@misc_rules//toolchains:shellcheck_from_nixpkgs",
    "@misc_rules//toolchains:yamllint_from_nixpkgs",
)
