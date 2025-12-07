return require("lazier") {
    "A7Lavinraj/fyler.nvim",
    enabled = false,

    branch = "stable",
    lazy = false,
    opts = {
        integrations = {
            icon = "nvim_web_devicons",
        },
        views = {
            finder = {
                close_on_select = true,
                confirm_simple  = false,
                default_explorer = true,
                delete_to_trash = true,
                git_status = {
                    enabled = true,
                },
                follow_current_file = true,
                watcher = {
                    enabled = true,
                },
                mappings = {
                    ["<BS>"] = "GotoParent",
                    ["-"]    = "CollapseAll",
                },
                win = {
                    buf_opts = {
                        shiftwidth = 4,
                    },
                    win_opts = {
                        cursorline = true,
                        number = true,
                        relativenumber = true,
                        signcolumn = "yes",
                    },
                },
            },
        },
    },
}
