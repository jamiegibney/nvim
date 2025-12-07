return require("lazier") {
    "stevearc/oil.nvim",

    dependencies = {
        "refractalize/oil-git-status.nvim",
    },

    lazy = false,

    config = function()
        require("oil").setup({
            default_file_explorer = true,
            skip_confirm_for_simple_edits = false,
            delete_to_trash = true,
            columns = {
                "icon",
            },
            keymaps = {
                ["<C-r>"] = { "actions.refresh" },
                ["<C-y>"] = { "actions.preview" },
                ["<BS>"]  = { "actions.parent" },

                ["<C-h>"] = false,
                ["<C-p>"] = false,
                ["<C-l>"] = false,
                ["<C-c>"] = false,
            },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _)
                    return (name == ".DS_Store" or name == ".git" or name == ".idea")
                end,
                natural_order = true,
            },
            win_options = {
                signcolumn = "yes",
                numberwidth = 6,
            },
            confirmation = {
                border = "rounded",
            },
            progress = {
                border = "rounded",
            },
            -- git = {
            --     add = function(_) return true end,
            --     mv  = function(_) return true end,
            --     rm  = function(_) return true end,
            -- },
            float = {
                padding = 1,
                border = "single",
            },
            watch_for_changes = true,
            constrain_cursor = "name",
        })

        require("oil-git-status").setup({})
    end,
}
