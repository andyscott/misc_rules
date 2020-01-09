load("//rules/shellcheck:shellcheck.bzl", "shellcheck_toolchain")

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
    shellcheck = "@misc_rules//toolchains/shellcheck:_host_path_shellcheck",
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
    shellcheck = "@misc_rules//toolchains/shellcheck:_shellcheck_path_shellcheck",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "shellcheck_from_shellcheck_path",
    toolchain = ":_shellcheck_from_shellcheck_path",
    toolchain_type = "@misc_rules//rules/shellcheck:toolchain_type",
    visibility = ["//visibility:public"],
)
