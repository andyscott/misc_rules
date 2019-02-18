load(":shellcheck.bzl", "shellcheck_test")

def shell_binary(**kwargs):
    native.sh_binary(**kwargs)
    shellcheck_test(
        name = "%s@shellcheck" % kwargs["name"],
        srcs = kwargs["srcs"],
    )

def shell_library(**kwargs):
    native.sh_library(**kwargs)
    shellcheck_test(
        name = "%s@shellcheck" % kwargs["name"],
        srcs = kwargs["srcs"],
    )

def shell_test(**kwargs):
    native.sh_test(**kwargs)
    shellcheck_test(
        name = "%s@shellcheck" % kwargs["name"],
        srcs = kwargs["srcs"],
    )
