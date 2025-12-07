-- Fast buffer switching.

return {
    "theprimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    config = function()
        local hp = require("harpoon")
        hp:setup({
            setting = {
                save_on_toggle = true,
            }
        })

        -- h[arpoon]
        vim.keymap.set("n", "<C-h>", function()
            hp.ui:toggle_quick_menu(hp:list(), {
                title = "",
                border = "rounded",
                ui_width_ratio = 0.4,
                height_in_lines = 12,
            })
        end)

        -- a[dd] f[ile]
        vim.keymap.set("n", "<leader>af", function()
            hp:list():append()
            print("Added to Harpoon")
        end)

        vim.keymap.set("n", "<C-j>", function() hp:list():select(1) end)
        vim.keymap.set("n", "<C-k>", function() hp:list():select(2) end)
        vim.keymap.set("n", "<C-l>", function() hp:list():select(3) end)
        vim.keymap.set("n", "<C-;>", function() hp:list():select(4) end)
        vim.keymap.set("n", "<C-'>", function() hp:list():select(5) end)
        vim.keymap.set("n", "<C-m>", function() hp:list():select(6) end)
        vim.keymap.set("n", "<C-,>", function() hp:list():select(7) end)
        vim.keymap.set("n", "<C-.>", function() hp:list():select(8) end)
        vim.keymap.set("n", "<C-/>", function() hp:list():select(9) end)
    end
}
