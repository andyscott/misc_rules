def _shellcheck_test_implementation(ctx):
    shellcheck_attr = ctx.toolchains["@rules_adroit//rules/shellcheck:toolchain_type"].shellcheck
    shellcheck_inputs, _, _ = ctx.resolve_command(tools = [shellcheck_attr])
    shellcheck = shellcheck_inputs[0]
    args = ctx.actions.args()
    args.add_all(ctx.files.srcs)
    args.use_param_file("@%s", use_always = True)
    args_file = ctx.actions.declare_file("{}@shellcheck.params".format(ctx.label.name))
    ctx.actions.write(args_file, args)
    ctx.actions.write(
        output = ctx.outputs.bin,
        content = "\n".join([
            "#!/usr/bin/env bash",
            "{shellcheck} $(< {args_file})",
        ]).format(
            shellcheck = shellcheck.short_path,
            args_file = args_file.short_path,
        ),
        is_executable = True,
    )
    return [DefaultInfo(
        executable = ctx.outputs.bin,
        files = depset(),
        runfiles = ctx.runfiles(
            collect_data = True,
            collect_default = True,
            files = [shellcheck, args_file] + ctx.files.srcs,
        ),
    )]

shellcheck_test = rule(
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
        ),
    },
    outputs = {
        "bin": "%{name}-bin",
    },
    test = True,
    toolchains = ["@rules_adroit//rules/shellcheck:toolchain_type"],
    implementation = _shellcheck_test_implementation,
)

def _shellcheck_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        shellcheck = ctx.attr.shellcheck,
    )
    return [toolchain_info]

shellcheck_toolchain = rule(
    attrs = {
        "shellcheck": attr.label(
            cfg = "host",
            default = "@shellcheck//:bin/shellcheck",
            allow_files = True,
            executable = True,
        ),
    },
    implementation = _shellcheck_toolchain_impl,
)
