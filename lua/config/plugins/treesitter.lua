return require("lazier") {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "VeryLazy",

        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "c", "cpp", "objc",
                    "wgsl", "glsl", "hlsl",

                    "c_sharp",
                    "rust",

                    "lua",
                    "vim", "vimdoc",

                    "comment", "toml", "json", "xml"
                },

                auto_install = true,

                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = true,
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        config = function()
            require("treesitter-context").setup({
                max_lines = 5,
            })
        end,
    },
}
