return require("lazier") {
    "ziontee113/color-picker.nvim",
    -- keys = {
    --     "<leader>pc"
    -- },

    config = function()
        require("color-picker").setup()
        vim.keymap.set("n", "<leader>pc", "<cmd>PickColor<CR>")
    end
}
