-- Auto-completion for LSP and other sources.

return {
    "saghen/blink.cmp",
    event = "InsertEnter",

    build = "cargo build --release",

    opts = {
        keymap = {
            preset = "none",
            ["<C-y>"] = { "select_and_accept" },
            ["<C-l>"] = {
                function(cmp)
                    cmp.show_and_insert({ providers = { "lsp" } })
                end
            },
            ["<C-p>"] = {
                "select_prev",
                function(cmp)
                    cmp.show_and_insert({ providers = { "path" } })
                end
            },
            ["<C-n>"] = {
                "select_next",
                function(cmp)
                    cmp.show_and_insert({ providers = { "buffer", "omni" } })
                end
            },
            ["<C-e>"] = { "cancel" },
            ["<C-f>"] = { "snippet_forward" },
        },
        completion = {
            list = {
                max_items = 80,
            },
            menu = {
                auto_show = false,
            },
        },
        sources = {
            default = { "lsp", "buffer", "path", "omni" },
            per_filetype = {
                md  = { "buffer", "path" },
                txt = { "buffer", "path" },
                dap = {},
            },
        },
        fuzzy = {
            implementation = "prefer_rust",
            frecency = {
                enabled = true,
            },
            use_proximity = true,
            sorts = { "exact", "score", "sort_text" },
        },
    },
}
