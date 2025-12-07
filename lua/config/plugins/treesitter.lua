return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufWrite",

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
                    enable = {},
                    disable = {
                        "c", "cpp",
                    },

                    additional_vim_regex_highlighting = true,
                },
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "BufWrite",
        config = function()
            require("treesitter-context").setup({
                max_lines = 5,
            })
        end,
    },
}
