-- Flexible utilities for surrounding text with delimiters.

return {
    "kylechui/nvim-surround",

    version = "^3.0.0",
    event = "VeryLazy",

    config = function()
        require("nvim-surround").setup({})
    end
}
