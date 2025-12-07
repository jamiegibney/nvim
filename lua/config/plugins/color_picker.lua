return {
    "ziontee113/color-picker.nvim",

    config = function()
        require("color-picker").setup()
        vim.keymap.set("n", "<leader>pc", "<cmd>PickColor<CR>")
    end
}
