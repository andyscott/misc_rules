load("//rules/shellcheck:shellcheck.bzl", "shellcheck_toolchain")
load("//rules/yamllint:yamllint.bzl", "yamllint_toolchain")
load("//rules/black:black.bzl", "black_toolchain")

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

# shellcheck from a SHELLCHECK_PATH env var pointing to
# the shellcheck binary

genrule(
    name = "_shellcheck_path_shellcheck_script",
    outs = ["shellcheck_path_shellcheck.sh"],
    cmd = "\n".join([
        "cat <<'EOF' > $@",
        "#!/usr/bin/env bash",
	"if [ -z $${SHELLCHECK_PATH+x} ]; then",
	"  echo \"SHELLCHECK_PATH must be set!\"",
	"  exit 1",
	"else",
        "  eval \"$$SHELLCHECK_PATH\" \"\$$@\"",
	"fi",
        "EOF",
    ]),
)

sh_binary(
    name = "_shellcheck_path_shellcheck",
    srcs = [":_shellcheck_path_shellcheck_script"],
    visibility = ["//visibility:public"],
)

shellcheck_toolchain(
    name = "_shellcheck_from_shellcheck_path",
    shellcheck = "@misc_rules//toolchains:_shellcheck_path_shellcheck",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "shellcheck_from_shellcheck_path",
    toolchain = ":_shellcheck_from_shellcheck_path",
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

# black

black_toolchain(
    name = "_black_from_nixpkgs",
    black = "@black//:bin/black",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "black_from_nixpkgs",
    toolchain = ":_black_from_nixpkgs",
    toolchain_type = "@misc_rules//rules/black:toolchain_type",
    visibility = ["//visibility:public"],
)

genrule(
    name = "_black_path_black_script",
    outs = ["black_path_black.sh"],
    cmd = "\n".join([
        "cat <<'EOF' > $@",
        "#!/usr/bin/env bash",
	"if [ -z $${BLACK_PATH+x} ]; then",
	"  echo \"BLACK_PATH must be set!\"",
	"  exit 1",
	"else",
        "  eval \"$$BLACK_PATH\" \"\$$@\"",
	"fi",
        "EOF",
    ]),
)

sh_binary(
    name = "_black_path_black",
    srcs = [":_black_path_black_script"],
    visibility = ["//visibility:public"],
)

black_toolchain(
    name = "_black_from_black_path",
    black = "@misc_rules//toolchains:_black_path_black",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "black_from_black_path",
    toolchain = ":_black_from_black_path",
    toolchain_type = "@misc_rules//rules/black:toolchain_type",
    visibility = ["//visibility:public"],
)
