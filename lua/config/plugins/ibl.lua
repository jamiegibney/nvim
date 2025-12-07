return require("lazier") {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufEnter",

    config = function()
        require("ibl").setup({
            scope = {
                enabled = false,
            },
            whitespace = {
                remove_blankline_trail = false,
            },
            indent = {
                char = "▏",
            },
        })
    end
}
