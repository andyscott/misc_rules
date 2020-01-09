load("@io_tweag_rules_nixpkgs//nixpkgs:repositories.bzl", "rules_nixpkgs_dependencies")
load("@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl", "nixpkgs_git_repository")

def workspace1():
    rules_nixpkgs_dependencies()

    nixpkgs_git_repository(
	name = "nixpkgs",
    	revision = "19.09",
    )