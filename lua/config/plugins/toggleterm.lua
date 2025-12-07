return require("lazier") {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = { "<C-Space>", },

    config = function()
        require("toggleterm").setup({
            size = 60,
            winbar = { enabled = false, },

            hide_numbers = true,
            shade_terminals = false,

            autochdir = false,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,

            -- close_on_exit = false,
            auto_scroll = false,

            open_mapping = "<C-Space>",
            shell = "fish",
        })
    end
}
