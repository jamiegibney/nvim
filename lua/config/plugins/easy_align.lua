-- Powerful text alignment.

return {
    "junegunn/vim-easy-align",
    lazy = false,

    config = function()
       vim.keymap.set({ "n", "v" }, "<leader>ea", "<Plug>(EasyAlign)")
    end
}
