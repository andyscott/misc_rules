def _yamllint_test_implementation(ctx):
    yamllint_attr = ctx.toolchains["@misc_rules//rules/yamllint:toolchain_type"].yamllint
    yamllint_inputs, _, _ = ctx.resolve_command(tools = [yamllint_attr])
    yamllint = yamllint_inputs[0]
    args = ctx.actions.args()
    args.add_all(ctx.files.srcs)
    args.use_param_file("@%s", use_always = True)
    args_file = ctx.actions.declare_file("{}@yamllint.params".format(ctx.label.name))
    ctx.actions.write(args_file, args)
    ctx.actions.write(
        output = ctx.outputs.bin,
        content = "\n".join([
            "#!/usr/bin/env bash",
            "{yamllint} $(< {args_file})",
        ]).format(
            yamllint = yamllint.short_path,
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
            files = [yamllint, args_file] + ctx.files.srcs,
        ),
    )]

yamllint_test = rule(
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
        ),
    },
    outputs = {
        "bin": "%{name}-bin",
    },
    test = True,
    toolchains = ["@misc_rules//rules/yamllint:toolchain_type"],
    implementation = _yamllint_test_implementation,
)

def _yamllint_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        yamllint = ctx.attr.yamllint,
    )
    return [toolchain_info]

yamllint_toolchain = rule(
    attrs = {
        "yamllint": attr.label(
            cfg = "host",
            default = "@yamllint//:bin/yamllint",
            allow_files = True,
            executable = True,
        ),
    },
    implementation = _yamllint_toolchain_impl,
)
