-- Key remaps.
-- NOTE that some key remaps are in plugin files, which allows the lazy loading to use those keymaps as loading triggers.

vim.g.mapleader = " "

local function map(mode, keys, func)
    vim.keymap.set(mode, keys, func)
end

-- MARK: normal mode mappings

-- centre the buffer on bit motions
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- clear highlights when pressing Esc in normal mode
map("n", "<Esc>", ":noh<CR>")

-- linewise comment
map("n", "<leader>/", ":norm gcc<CR>")

-- f[ile] s[ystem]
map("n", "<leader>fs", ":Oil<CR>")
-- map("n", "<leader>fs", ":Fyler<CR>")
-- p[revious] f[ile]
map("n", "<leader>pf", "<C-^>")

-- move current line up and down
map("n", "<C-p>", "V:move '<-2<CR>gv=gv<Esc>")
map("n", "<C-n>", "V:move '>+1<CR>gv=gv<Esc>")

-- insert semicolon at the end of the current line
map("n", "<C-CR>", "A;<Esc>")

-- copy the whole buffer
map("n", "<leader>%", "<cmd>%y<CR>")

-- s[plit] v[ertical]
map("n", "<leader>sv", "<C-w>v<C-w>l")
-- s[plit] h[orizontal]
map("n", "<leader>sh", "<C-w>s<C-w>j")

-- nicer split resizing
map("n", "<C-->", "4<C-w>-")
map("n", "<C-=>", "4<C-w>+")
map("n", "<C-A-->", "4<C-w><")
map("n", "<C-A-=>", "4<C-w>>")

-- close all buffers but the current
map("n", "<leader><leader>", "<C-w>o")

-- r[eplace] a[ll]
map("n", "<leader>ra", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- e[xpand] b[races]
map("n", "<leader>eb", "_f{a<CR><CR><Esc>")

-- c[omment] s[eparator]
map("n", "<leader>cs", "o<Esc>O*** *** *** *** *** <Esc>:norm gcc<CR>_yiW$p")

-- o[pen] h[ere]
map("n", "<leader>oh", "<cmd>!open .<CR>")

-- h[ex]d[ump]
map("n", "<leader>hd", "<cmd>%!xxd -b -d -c 8<CR>")

-- sp[elling]
map("n", "<leader>sp", function()
    vim.cmd("set spell!")

    if vim.opt.spell:get() then
        print("Spell-checking enabled");
    else
        print("Spell-checking disabled");
    end
end)

-- unmap Ctrl-C in insert
map("i", "<C-c>", "")
-- append semicolon and switch to normal mode
map("i", "<C-CR>", "<Esc>A;<Esc>")
-- open a new line above the cursor
map("i", "<C-o>", "<Esc>O")

-- allow visual block edits to apply across multiple lines
-- map({ "i", "v", "c", "s" }, "<Esc>", "<Esc>")

-- move selected block and auto-indent
map("v", "<C-p>", ":move '<-2<CR>gv=gv")
map("v", "<C-n>", ":move '>+1<CR>gv=gv")

-- linewise comment
map("v", "<leader>/", "<Esc>:norm gvgc<CR>")

-- allow Ctrl-A to go to the start of the line in command mode
map("c", "<C-a>", "<Home>")
-- allow Ctrl-E to go to the end of the line in command mode
map("c", "<C-e>", "<End>")

-- retain contents of register after pasting into a selection
map("x", "<leader>p", [["_dP]])

-- MARK: LSP

-- c[ode] a[ction]
map("n", "<leader>ca", function()
    vim.lsp.buf.code_action()
end)

-- i[nformation]
map("n", "<leader>i", function()
    vim.lsp.buf.hover()
end)

-- r[e]n[ame]
map("n", "<leader>rn", function()
    vim.lsp.buf.rename()
end)

-- f[or]m[at]
map("v", "<leader>fm", function()
    vim.lsp.buf.format({
        async = true,
        range = {
            ["start"] = vim.api.nvim_buf_get_mark(0, "<"),
            ["end"]   = vim.api.nvim_buf_get_mark(0, ">"),
        },
    })
end)

-- g[oto] d[efinition]
map("n", "gd", function()
    vim.lsp.buf.definition()
end)

-- h[elp]
map("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
end)

-- d[iag]n[ostics]
map("n", "<leader>dn", function()
    vim.diagnostic.open_float({
        source = true,
    })
end)

-- previous diagnostic
map("n", "<C-[>", function()
    vim.diagnostic.jump({
        count = -1,
        on_jump = function(_)
            vim.diagnostic.open_float({
                source = true
            })
        end
    })
end)

-- next diagnostic
map("n", "<C-]>", function()
    vim.diagnostic.jump({
        count = 1,
        on_jump = function(_)
            vim.diagnostic.open_float({
                source = true
            })
        end
    })
end)

-- MARK: some more complex mappings

-- t[oggle] d[iagnostics]
map("n", "<leader>td", function()
    if not vim.diagnostic.is_enabled() then
        print("Diagnostics enabled")
        vim.diagnostic.enable(true)
    else
        print("Diagnostics disabled")
        vim.diagnostic.enable(false)
    end
end)

-- r[ead]m[e]
map("n", "<leader>rm", function()
    local function open(name)
        vim.cmd("edit " .. name)
        print("Opened README")
    end

    -- search for different common variations of READMEs first
    if #vim.fs.find({ "README.md" }, { type = "file" }) >= 1 then
        open("README.md")
    elseif #vim.fs.find("README", { type = "file" }) >= 1 then
        open("README")
    elseif #vim.fs.find("readme.md", { type = "file" }) >= 1 then
        open("readme.md")
    elseif #vim.fs.find("readme", { type = "file" }) >= 1 then
        open("readme")
    else
        -- if none found, just create README.md
        vim.cmd("edit README.md")
        print("No README found; created README.md")
    end
end)

-- g[it]i[gnore]
map("n", "<leader>gi", function()
    if #vim.fs.find({ ".gitignore" }, { type = "file" }) >= 1 then
        print("Opened gitignore")
    else
        print("No .gitignore found; created new .gitignore file")
    end

    vim.cmd("edit .gitignore")
end)
