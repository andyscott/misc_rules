workspace(name = "misc_rules")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "io_tweag_rules_nixpkgs",
    strip_prefix = "rules_nixpkgs-adfe991ad7fd41fcdbeaeabf33ea061d9b435c97",
    urls = ["https://github.com/tweag/rules_nixpkgs/archive/adfe991ad7fd41fcdbeaeabf33ea061d9b435c97.tar.gz"],
)

load("@io_tweag_rules_nixpkgs//nixpkgs:repositories.bzl", "rules_nixpkgs_dependencies")

rules_nixpkgs_dependencies()

load("@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl", "nixpkgs_local_repository", "nixpkgs_package")

nixpkgs_local_repository(
    name = "nixpkgs",
    nix_file = "//3rdparty:nixpkgs.nix",
)

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
