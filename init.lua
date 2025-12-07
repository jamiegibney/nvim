local function bootstrap(author, name, opts)
    opts = opts or {}
    local path = opts.dir or (vim.fn.stdpath("data") .. "/" .. name .. "/" .. name .. ".nvim")

    if not vim.uv.fs_stat(path) then
        local repo = "https://github.com/" .. author .. "/" .. name .. ".nvim"
        local out = vim.fn.system({
            "git",
            "clone",
            "--branch=" .. (opts.branch or "stable"),
            "--filter=blob:none",
            repo,
            path,
        })

        if vim.v.shell_error ~= 0 then
            print("Failed to clone " .. name .. ":", "Error")
            print(out)
            vim.fn.getchar()
            os.exit(1)
        end
    end

    vim.opt.runtimepath:prepend(path)
end

bootstrap("jake-stewart", "lazier")
bootstrap("folke", "lazy")

local function before_fn()
    vim.loader.enable()
    require("config.auto_commands")
    require("config.options")
    require("config.mappings")
end

local function after_fn()
    -- require("config.themes.dark")
    require("config.themes.light")

    vim.diagnostic.config({
        virtual_text = {
            spacing = 4,
            prefix = "⏺",
        },
        signs = false,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
    })

    vim.diagnostic.enable(false)

    vim.lsp.enable({ "clangd" })
    vim.lsp.enable({ "lua_ls" })
end

require("lazier").setup("config.plugins", {
    lazier = {
        before = before_fn,
        after  = after_fn
    },
    defaults = {
        lazy = false,
    },
    change_detection = {
        enabled = false,
    },
    performance = {
        cache = { enabled = true },
    },
})
