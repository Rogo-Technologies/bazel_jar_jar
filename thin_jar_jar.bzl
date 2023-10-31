load("//:jar_jar_aspect.bzl", "ShadedJars", "jar_jar_aspect", "merge_shaded_jars_info")

def _thin_jar_jar_impl(ctx):
    aspect_info = merge_shaded_jars_info(
        [dep[ShadedJars] for dep in ctx.attr.deps],
    )
    all_java = aspect_info.java_info

    return [
        all_java,
        DefaultInfo(files = aspect_info.output_files),
    ]

thin_jar_jar = rule(
    implementation = _thin_jar_jar_impl,
    attrs = {
        "deps": attr.label_list(aspects = [jar_jar_aspect]),
    },
    provides = [DefaultInfo, JavaInfo],
)
