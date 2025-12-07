-- Powerful text alignment.

return {
    "junegunn/vim-easy-align",
    command = ":EasyAlign",

    config = function()
        vim.keymap.set({ "n", "v" }, "<leader>ea", "<Plug>(EasyAlign)")
    end
}
