-- lua_ls config from nvim-lspconfig.

return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = {
        ".emmyrc.json",
        ".luarc.json",
        ".luarc.jsonc",
        ".luacheckrc",
        ".stylua.toml",
        "stylua.toml",
        "selene.toml",
        "selene.yml",
        ".git",
    },
    settings = {
        Lua = {
            -- this fixes the "unknown global 'vim'" issue.
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            diagnostics = {
                disable = { "missing-fields" },
            },
            codeLens = { enable = true },
            hint = { enable = true, semicolon = "Disable" },
        },
    },
}
