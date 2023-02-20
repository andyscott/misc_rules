# misc_rules

Rules for miscellaneous system tools, linters, etc.

## Usage

You'll need to first load the rules in your WORKSPACE file.

``` python
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

git_repository(
    name = "misc_rules",
    commit = "<<pick-a-commit-sha>>",
    remote = "git://github.com/andyscott/misc_rules",
)
```

Next, follow the configuration for any tools/rules you want to use.

## Shellcheck

First, register a shellcheck toolchain.

**Prebuilt via rules_nixpkgs:**

```python
nixpkgs_package(
    name = "shellcheck",
    repository = "@nixpkgs",
)
register_toolchains(
    "@misc_rules//toolchains/shellcheck:shellcheck_from_nixpkgs",
)
```

**Prebuilt from system path:**

``` python
register_toolchains(
    "@misc_rules//toolchains/shellcheck:shellcheck_from_host_path",
)
```

*Note: You must set bazel option `--test_env=PATH` in your .bazelrc.*


---


Now you can shellcheck your scripts!

``` python
load("@misc_rules//rules/shellcheck:shellcheck.bzl", "shellcheck_test")

shellcheck_test(
    name = "myscript@shellcheck",
    srcs = [
        "myscript.sh",
    ],
)
```

There's also a series of macros that delegate to Bazel's `sh_**` rules.

``` python
load("//rules/shellcheck:shell.bzl", "shell_binary")

shell_binary(
    name = "ci",
    srcs = ["src/ci.sh"],
    data = [
        ":lint",
    ],
    tags = ["manual"],
    deps = [
        "@bazel_tools//tools/bash/runfiles",
    ],
)

shell_binary(
    name = "lint",
    srcs = ["src/lint.sh"],
    tags = ["manual"],
    deps = [
        "@bazel_tools//tools/bash/runfiles",
    ],
)
```

This macro gives you the usual targets as well as additional
`@shellcheck` suffixed targets for running shellcheck.

## Yamllint

First, register a yamllint toolchain.

**Prebuilt via rules_nixpkgs:**

```python
nixpkgs_package(
    name = "yamllint",
    attribute_path = "python36Packages.yamllint",
    repository = "@nixpkgs",
)
register_toolchains(
    "@misc_rules//toolchains/yamllint:yamllint_from_nixpkgs",
)
```

---


Now you can yamllint your scripts!

``` python
load("@misc_rules//rules/yamllint:yamllint.bzl", "yamllint_test")

yamllint_test(
    name = "my_config@yamllint",
    srcs = [
        "my_config.yaml",
    ],
)
```
