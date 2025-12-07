return require("lazier") {
    "nvim-telescope/telescope.nvim",

    dependencies = {
        { "nvim-lua/plenary.nvim", },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
        }
    },

    keys = {
        { "<leader>ff", "<cmd>Telescope find_files<CR>" },
        { "<leader>fw", "<cmd>Telescope live_grep<CR>" },
        { "<leader>fo", "<cmd>Telescope oldfiles<CR>" },
        { "<leader>gr", "<cmd>Telescope lsp_references<CR>" },
        { "<leader>tr", "<cmd>Telescope resume<CR>" },
        { "<leader>bu", "<cmd>Telescope buffers<CR>" },
        { "<leader>su", "<cmd>Telescope spell_suggest<CR>" },
    },

    config = function()
        local actions = require("telescope.actions")

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "TelescopeResults",
            callback = function(ctx)
                vim.api.nvim_buf_call(ctx.buf, function()
                    vim.fn.matchadd("TelescopePwd", "[A-Za-z/…].*/")
                    vim.api.nvim_set_hl(0, "TelescopePwd", { fg = "#999999" })
                end)
            end,
        })

        require("telescope").setup({
            extensions = {
                fzf = {
                    override_generic_sorter = true,
                    override_file_sorter = true,
                },
                history = {
                    limit = 500,
                },
                wrap_result = true,
            },
            defaults = {
                prompt_title = false,
                dynamic_preview_title = true,
                result_title = false,

                path_display = function(_, path)
                    local get_status = require("telescope.state").get_status
                    local truncate = require("plenary.strings").truncate

                    local truncate_len = 2
                    local status = get_status(vim.api.nvim_get_current_buf())
                    local len = vim.api.nvim_win_get_width(status.results_win) - status.picker.selection_caret:len() - 2
                    local path_len = len - truncate_len

                    local truncated = truncate(path, path_len, nil, -1)

                    return " " .. truncated
                end,

                mappings = {
                    i = { ["<Esc>"] = actions.close },
                },

                prompt_prefix = "> ",
                selection_caret = "  ",
                entry_prefix = "  ",

                selection_strategy = "reset",
                sorting_strategy = "descending",

                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        width  = 0.80,
                        height = 0.90,
                        preview_width = 0.35,
                        prompt_position = "bottom",
                    },
                    vertical = {
                        mirror = false,
                        prompt_position = "bottom",
                    },
                    cursor = {
                        width  = 0.30,
                        height = 0.30,
                        preview_width = 0.60,
                    },
                },

                winblend = 0,
                color_devicons = true,
                borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                file_ignore_patterns = { "node_modules" },
                set_env = { ["COLORTERM"] = "truecolor" },
            },
            pickers = {
                find_files = {
                    previewer = false,
                    hidden = false,
                },
                oldfiles = {
                    previewer = false,
                },
                spell_suggest = {
                    layout_strategy = "cursor",
                },
            },
        })

        require("telescope").load_extension("fzf")
    end,
}
