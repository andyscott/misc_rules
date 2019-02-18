workspace(name = "rules_adroit")

load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "io_tweag_rules_nixpkgs",
    commit = "40b5a9f23abca57f364c93245c7451206ef1a855",
    remote = "git://github.com/tweag/rules_nixpkgs",
)

load(
    "@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl",
    "nixpkgs_local_repository",
    "nixpkgs_package",
)

nixpkgs_local_repository(
    name = "rules_adroit_nixpkgs",
    nix_file = "//3rdparty:nixpkgs.nix",
)

nixpkgs_package(
    name = "shellcheck",
    repository = "@rules_adroit_nixpkgs",
)

register_toolchains(
    "@rules_adroit//toolchains:shellcheck_from_nixpkgs",
    # must set bazel option: --test_env=PATH
    #"@rules_adroit//toolchains:shellcheck_from_host_path",
)
