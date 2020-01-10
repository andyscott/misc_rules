def _black_test_implementation(ctx):
    optional_inputs = []
    black_attr = ctx.toolchains["@misc_rules//rules/black:toolchain_type"].black
    black_inputs, _, _ = ctx.resolve_command(tools = [black_attr])
    black = black_inputs[0]
    args = ctx.actions.args()
    args.add("--check")
    if ctx.attr.config:
        args.add("--config", ctx.file.config)
        optional_inputs.append(ctx.file.config)
    args.add_all(ctx.files.srcs)
    args.use_param_file("@%s", use_always = True)
    args_file = ctx.actions.declare_file("{}@black.params".format(ctx.label.name))
    ctx.actions.write(args_file, args)
    ctx.actions.write(
        output = ctx.outputs.bin,
        content = "\n".join([
            "#!/usr/bin/env bash",
            "{black} $(< {args_file})",
        ]).format(
            black = black.short_path,
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
            files = [black, args_file] + ctx.files.srcs + optional_inputs,
        ),
    )]

black_test = rule(
    attrs = {
        "srcs": attr.label_list(
            allow_files = True,
        ),
        "config": attr.label(
            allow_single_file = True,
        ),
    },
    outputs = {
        "bin": "%{name}-bin",
    },
    test = True,
    toolchains = ["@misc_rules//rules/black:toolchain_type"],
    implementation = _black_test_implementation,
)

def _black_toolchain_impl(ctx):
    toolchain_info = platform_common.ToolchainInfo(
        black = ctx.attr.black,
    )
    return [toolchain_info]

black_toolchain = rule(
    attrs = {
        "black": attr.label(
            cfg = "host",
            default = "@black//:bin/black",
            allow_files = True,
            executable = True,
        ),
    },
    implementation = _black_toolchain_impl,
)
