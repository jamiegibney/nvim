return {
    "numToStr/FTerm.nvim",
    lazy = false,
    config = function()
        require("FTerm").setup({
            dimensions = {
                x      = 0.5,
                y      = 0.5,
                width  = 0.9,
                height = 0.9,
            },
        })

        vim.keymap.set("n", "<C-Space>", "<CMD>lua require('FTerm').toggle()<CR>")
        vim.keymap.set("t", "<C-Space>", "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>")
    end,
}
