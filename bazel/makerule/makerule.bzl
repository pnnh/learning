def _makerule_impl(ctx):
    output = ctx.actions.declare_directory("dist")

    ctx.actions.run(
        outputs = [output],
        inputs = ctx.files.srcs,
        executable = "touch",
        arguments = [output.path+"/abc.txt"],
    )

    return [DefaultInfo(
        files = depset([output]),
    )]

makerule = rule(
    implementation = _makerule_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = True),
    },
)
