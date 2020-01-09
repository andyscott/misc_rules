load("@io_tweag_rules_nixpkgs//nixpkgs:repositories.bzl", "rules_nixpkgs_dependencies")
load("@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl", "nixpkgs_git_repository", "nixpkgs_package")

def workspace1():
    rules_nixpkgs_dependencies()

    nixpkgs_git_repository(
	name = "nixpkgs",
    	revision = "19.09",
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

    nixpkgs_package(
        name = "black",
        attribute_path = "python37Packages.black",
        repository = "@nixpkgs",
    )

    native.register_toolchains(
        "@misc_rules//toolchains/shellcheck:shellcheck_from_nixpkgs",
        "@misc_rules//toolchains/yamllint:yamllint_from_nixpkgs",
        "@misc_rules//toolchains/black:black_from_nixpkgs",
    )
