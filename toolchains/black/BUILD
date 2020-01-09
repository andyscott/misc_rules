load("//rules/black:black.bzl", "black_toolchain")

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
    black = "@misc_rules//toolchains/black:_black_path_black",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "black_from_black_path",
    toolchain = ":_black_from_black_path",
    toolchain_type = "@misc_rules//rules/black:toolchain_type",
    visibility = ["//visibility:public"],
)
