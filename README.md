# rules_adroit

Rules for miscellaneous system tools, linters, etc.

## Usage

You'll need to first load the rules in your WORKSPACE file.

``` python
git_repository(
    name = "rules_adroit",
    commit = "<<pick-a-commit-sha>>",
    remote = "git://github.com/andyscott/rules_adroit",
)
```

Next, follow the configuration for any tools/rules you want to use.

## Shellcheck

First, register a shellcheck toolchain.

**Prebuilt via rules_nixpkgs:**

```python
nixpkgs_package(
    name = "shellcheck",
    repository = "@your_nixpkgs_repo",
)
register_toolchains(
    "@rules_adroit//toolchains:shellcheck_from_nixpkgs",
)
```

**Prebuilt from system path:**

``` python
register_toolchains(
    "@rules_adroit//toolchains:shellcheck_from_host_path",
)
```

*Note: You must set bazel option `--test_env=PATH` in your .bazelrc.*


---


Now you can shellcheck your scripts!

``` python
load("@rules_adroit//rules/shellcheck:shellcheck.bzl", "shellcheck_test")

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
