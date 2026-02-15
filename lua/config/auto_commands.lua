-- Various auto commands for specific behaviours.

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
    -- @todo: these should be set globally
    vim.cmd("setlocal formatoptions-=o")
    vim.cmd("setlocal iskeyword-=_")
end)

-- centre buffer when opening
autocmd({ "BufWinEnter" }, function() vim.cmd("exe 'normal zz'") end)

-- useful abbreviations
autocmd({ "VimEnter" }, function()
    -- Inserts the date, e.g. '8 Dec 25'
    vim.cmd("iabbrev datenow <BS><C-r>=strftime('%e %b %y')<CR>")

    -- Inserts a header as a C comment, e.g.
    -- /* 
    --  * (C) Copyright 2025 Jamie Gibney. All rights reserved.
    --  *
    --  * File: src/gui/widgets/linear_slider.h
    --  * Created: 14:16 08 Dec 25
    --  * Author: Jamie Gibney
    --  */
    vim.cmd("iabbrev cheader /* <CR>(C) Copyright <C-r>=strftime('%Y')<CR> Jamie Gibney. All rights reserved.<CR><CR>File: <C-r>%<CR>Created: <C-r>=strftime('%H:%M %d %b %y')<CR><CR>Author: Jamie Gibney<CR>/")
    --  *
    --  */
end)

-- set comment highlights
autocmd({ "WinEnter" }, function()
    vim.fn.matchadd("BlueComment", [[\<TODO\>]])
    vim.fn.matchadd("YellowComment", [[\<NOTE\>]])
    vim.fn.matchadd("GreenUnderlinedComment", [[\<MARK\>]])
    vim.fn.matchadd("RedComment", [[\<IMPORTANT\>]])
    vim.fn.matchadd("YellowComment", "@[A-z]*")
    vim.fn.matchadd("BlueComment", [[@todo]])
    vim.fn.matchadd("PurpleComment", [[@cleanup]])
    vim.fn.matchadd("PurpleComment", [[@speed]])
    vim.fn.matchadd("YellowComment", [[@note]])
    vim.fn.matchadd("GreenUnderlinedComment", [[@mark]])
    vim.fn.matchadd("RedComment", [[@nocheckin]])
    vim.fn.matchadd("RedComment", [[@fixme]])
    vim.fn.matchadd("RedComment", [[@incomplete]])
    vim.fn.matchadd("RedComment", [[@important]])
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

autocmd({ "VimLeave" }, function()
    io.stdout:write("\027]111;;\027\\")
end)

local function toggle_ghostty_theme(light)
    local path = vim.fn.expand("$HOME/.config/ghostty/config")
    local f, _ = assert(io.open(path, "r"))

    local contents = f:read("*all")
    f:close()

    local len = contents:len()

    local _, j = string.find(contents, "#ENDTHEME\n")
    assert(j ~= nil)
    local remaining_config = string.sub(contents, j, len)

    local prefix

    if light then
        prefix = "#THEME\ntheme = Tomorrow\n#ENDTHEME"
    else
        prefix = "#THEME\ntheme = Tomorrow Night Bright\n#ENDTHEME"
    end

    f = assert(io.open(path, "w"))
    f:write(prefix .. remaining_config)
    f:close()
end

local function set_persistent_light_theme(light)
    local lock = vim.api.nvim_list_runtime_paths()[1] .. "/lua/config/themes/light_lock"
    local f, _ = io.open(lock, "r")

    if light and f == nil then
        f = assert(io.open(lock, "w+"))
        f:write("lock")
        f:flush()
        f:close()
    elseif not light and f ~= nil then
        os.remove(lock)
        f:close()
    end

    local unix = false

    local fh, _ = assert(io.popen("uname -o 2>/dev/null", "r"))
    if fh then
        unix = true
        fh:close()
    end

    if unix then
        toggle_ghostty_theme(light)
    end
end

vim.api.nvim_create_user_command("LightTheme", function()
    set_persistent_light_theme(true)
    require("config.themes.light").set_theme()
end, {})

vim.api.nvim_create_user_command("DarkTheme", function()
    set_persistent_light_theme(false)
    require("config.themes.dark").set_theme()
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
    -- local file_name = " %t"
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

autocmd({ "VimEnter", "BufWritePost", }, set_statusline)
