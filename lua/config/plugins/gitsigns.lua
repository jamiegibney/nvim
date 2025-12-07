return require("lazier") {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",

    config = function()
        require("gitsigns").setup({})

        -- d[i]f[f]
        vim.keymap.set("n", "<leader>df", function()
            vim.cmd("Gitsigns toggle_word_diff")
            vim.cmd("Gitsigns toggle_linehl")
            vim.cmd("Gitsigns toggle_deleted")
        end)
    end
}
