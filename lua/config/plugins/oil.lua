-- File explorer.

return {
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

                ["<leader>yp"] = { -- y[ank] p[ath]
                    desc = "Copy the current entry's file path to the system clipboard",
                    callback = function()
                        require("oil.actions").yank_entry.callback()
                        print("Copied \"" .. vim.fn.getreg(vim.v.register) .. "\" to the clipboard")
                    end,
                },
                ["<leader>yd"] = { -- y[ank] d[irectory]
                    desc = "Copy the current entry's parent directory path to the system clipboard",
                    callback = function()
                        local path = require("oil").get_current_dir()
                        vim.fn.setreg("+", path)
                        print("Copied \"" .. path .. "\" to the clipboard")
                    end,
                },
                ["<leader>yf"] = { -- y[ank] f[ilename]
                    desc = "Copy the current entry's file name to the system clipboard",
                    callback = function()
                        local entry = require("oil").get_cursor_entry()
                        vim.fn.setreg("+", entry.name)
                        print("Copied \"" .. entry.name .. "\" to the clipboard")
                    end,
                },
                -- ["<leader>oh"] = { -- o[pen] h[ere]
                --     desc = ""
                -- },
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
            float = {
                padding = 1,
                border = "single",
            },
            watch_for_changes = true,
            constrain_cursor = "name",
        })

        require("oil-git-status").setup({
        })
    end,
}
