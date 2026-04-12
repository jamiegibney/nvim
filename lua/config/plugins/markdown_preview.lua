-- Pretty markdown previews in the browser.

return {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    cmd   = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft    = { "markdown" },
    keys = {
        { "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>" },
    },

    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end,
}
