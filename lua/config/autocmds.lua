local function autocmd(event, cb, pattern)
    local pat = pattern or "*"
    vim.api.nvim_create_autocmd(event, {
        pattern = pat,
        callback = cb,
    })
end

-- treat .sc files as GLSL shaders
autocmd({ "BufEnter" }, function()
    vim.bo.filetype = "glsl"
    vim.opt.shiftwidth = 4
end, "*.sc")

-- don't open a new comment comment with 'o'
-- and don't consider '_' as part of a word, but rather a boundary
autocmd({ "BufEnter" }, function()
    vim.cmd("setlocal formatoptions-=o")
    vim.cmd("setlocal iskeyword-=_")
end)

-- centre buffer when opening
autocmd({ "BufWinEnter" }, function() vim.cmd("exe 'normal zz'") end)

-- set comment highlights
autocmd({ "BufRead", "BufWrite" }, function()
    vim.api.nvim_set_hl(0, "@ibl.indent.char.1", { fg = "#2a2a2a" })
    vim.api.nvim_set_hl(0, "@ibl.scope.char.1", { fg = "#444444" })
    vim.fn.matchadd("NOTEComment", [[\<NOTE\>]])
    vim.fn.matchadd("MARKComment", [[\<MARK\>]])
    vim.fn.matchadd("IMPORTANTComment", [[\<IMPORTANT\>]])
    vim.fn.matchadd("NocheckinComment", [[\<nocheckin\>]])
end)

-- flash when yanking text
autocmd({ "TextYankPost" }, function()
    vim.cmd("silent! lua vim.highlight.on_yank { higroup = 'IncSearch', timeout = 55 }")
end)

-- set local options for C/C++
autocmd({ "BufWinEnter" }, function()
    vim.cmd("setlocal textwidth=90")
    vim.cmd("setlocal commentstring=//\\ %s")
end, { "*.hpp", "*.cpp", "*.h", "*.c", "*.m", "*.mm", })

-- set terminal background based on theme
autocmd({ "Colorscheme" }, function()
    local bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
    io.stdout:write(("\027]11;#%06x\027\\"):format(bg))
end)
autocmd({ "VimLeave" }, function()
    io.stdout:write("\027]111;;\027\\")
end)

vim.api.nvim_create_user_command("LightTheme", function()
    require("config.themes.light").set_theme()
end, {})

vim.api.nvim_create_user_command("DarkTheme", function()
    require("config.theme.dark").set_dark_theme()
end, {})

local function set_statusline()
    -- vim.api.nvim_set_hl(0, "SLWarn", { bold = true, fg = "#d9aa0d", bg = "#ededed" })
    -- vim.api.nvim_set_hl(0, "SLError", { bold = true, fg = "#d95716", bg = "#ededed" })
    vim.api.nvim_set_hl(0, "SLWarn", { link = "DiagnosticWarn" })
    vim.api.nvim_set_hl(0, "SLError", { link = "DiagnosticError" })

    local set_color_1 = "%#StatusLineNC#"
    local set_color_2 = "%#StatusLineNC#"
    local set_color_3 = "%#StatusLineNC#"

    local file_dir = "/%f"
    local file_name = " %t"
    local modified_read_only = "%m%r"
    local align_right = "%="

    local line_col = "%l:%c"
    local percentage = "%p%% (%L lines)"
    local file_type = "%y"

    local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    local errs = ""
    if num_errors == 1 then
        errs = num_errors .. " error   "
    elseif num_errors > 1 then
        errs = num_errors .. " errors   "
    end

    local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    local warns = ""
    if num_warnings == 1 then
        warns = num_warnings .. " warn   "
    elseif num_warnings > 1 then
        warns = num_warnings .. " warns   "
    end

    local set_color_error = ""
    if num_errors >= 1 then set_color_error = "%#SLError#" else set_color_error = set_color_3 end
    local set_color_warning = "%#SLWarn#"
    if num_warnings >= 1 then set_color_warning = "%#SLWarn#" else set_color_warning = set_color_3 end

    vim.opt.statusline = string.format(
        "%s%s %s%s%s%s%s%s%s%s %s   %s%s ",
        set_color_1,
        file_dir,
        modified_read_only,
        align_right,
        set_color_warning,
        warns,
        set_color_error,
        errs,
        set_color_2,
        line_col,
        percentage,
        set_color_3,
        file_type
    )
end

autocmd({ "VimEnter", "InsertLeave", "InsertEnter", "BufWrite", "TextChanged", }, set_statusline)
