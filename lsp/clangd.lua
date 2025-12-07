-- clangd config from nvim-lspconfig.

return {
    cmd = {
        "/Users/jamiegibney/Documents/dev/probe/clangd/clangd_snapshot_20251130/bin/clangd",
        -- NOTE: playing around with nightly clangd for some nicer
        -- documentation features. Specifically, clangd 22 can format comments
        -- as Markdown in LSP-hover documentation, which I much prefer.
        -- Otherwise this would be:
        -- "/Library/Developer/CommandLineTools/usr/bin/clangd",
        "--background-index",
        "--clang-tidy",
        "--cross-file-rename",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = {
        ".clangd",
        ".clang-tidy",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        "configure.ac",
        ".git",
    },
    capabilities = {
        textDocument = {
            completion = {
                editsNearCursor = true,
            },
        },
        offsetEncoding = { "utf-8", "utf-16" },
    },
    on_init = function(client, init_result)
        if init_result.offsetEncoding then
            client.offset_encoding = init_result.offsetEncoding
        end
    end,
    -- on_attach = function(client, bufnr)
    -- end,
}
