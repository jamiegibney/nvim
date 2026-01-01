function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

vim.keymap.set("n", "<leader>hg", ":Inspect<CR>")

vim.g.indent_blankline_use_treesitter = true
vim.cmd "autocmd BufRead,BufNewFile * syn match Braces /[{}]/"

local api = vim.api

method_color = "#0070a0"

local links = {
    ["@lsp.type.namespace"]                  = "@namespace",
    ["@lsp.type.type"]                       = "@type",
    ["@lsp.type.class"]                      = "@type",
    ["@lsp.type.enum"]                       = "@type",
    ["@lsp.type.interface"]                  = "@type",
    ["@lsp.type.struct"]                     = "@type",
    ["@lsp.type.parameter"]                  = "@parameter",
    ["@lsp.type.property"]                   = "@property",
    ["@lsp.type.function"]                   = "@function",
    ["@lsp.type.method"]                     = "@method",
    ["@lsp.type.macro"]                      = "@macro",
    ["@lsp.type.decorator"]                  = "@function",
    ["@lsp.mod.defaultLibrary"]              = "@function.builtin",
    ["@lsp.mod.readonly"]                    = "@constant",
    ["@lsp.typemod.function.defaultLibrary"] = "@function.builtin",
    ["@lsp.typemod.variable.defaultLibrary"] = "@variable.builtin",
    ["@lsp.typemod.variable.readonly"]       = "@constant",
}

local function set_glsl_highlights()
    api.nvim_set_hl(0, "@type.builtin.glsl", { link = "Statement", })
    api.nvim_set_hl(0, "@type.glsl", { link = "Statement", })
    api.nvim_set_hl(0, "@variable.builtin.glsl", { link = "Special", })
    api.nvim_set_hl(0, "@function.call.glsl", { fg = "#00ab9c", })
    api.nvim_set_hl(0, "@function.glsl", { fg = "#0070a0", bold = true })
end

-- * -- C highlight -- * --
local function set_c_highlights()
    api.nvim_set_hl(0, "@lsp.type.macro.c", { link = "@macro" })
    api.nvim_set_hl(0, "@lsp.type.function.c", { fg = "#00ab9c" })
    api.nvim_set_hl(0, "@lsp.type.type.c", { link = "cType" })
    api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.c", { link = "@lsp.typemod.const.constant.rust" })
    api.nvim_set_hl(0, "@lsp.typemod.property.readonly.c", { link = "@lsp.typemod.const.constant.rust" })
    api.nvim_set_hl(0, "@lsp.typemod.variable.fileScope.c", { fg = "#000000", bold = true, })
    api.nvim_set_hl(0, "cNumbers", { link = "cNumber" })
end

-- * -- C++ highlights -- * --
local function set_cpp_highlights()
    local cpp_class_purple = "#8023c0"
    api.nvim_set_hl(0, "@lsp.typemod.class.defaultLibrary.cpp", { link = "DiagnosticHint", })
    api.nvim_set_hl(0, "@lsp.typemod.function.defaultLibrary.cpp", { fg = "#00ab9c", })
    api.nvim_set_hl(0, "@lsp.mod.defaultLibrary.cpp", { link = "none" })
    api.nvim_set_hl(0, "@lsp.type.namespace.cpp", { link = "none" })
    api.nvim_set_hl(0, "@type.builtin.cpp", { link = "rustKeyword", })
    api.nvim_set_hl(0, "cppConstant", { fg = "#0033b3", bg = "#f0f4ff", })
    api.nvim_set_hl(0, "cppType", { link = "rustKeyword", })
    api.nvim_set_hl(0, "cppTypedef", { link = "cType", })
    api.nvim_set_hl(0, "cppStructure", { link = "cType", })
    api.nvim_set_hl(0, "cppString", { fg = "#0a8521", italic = true, })
    api.nvim_set_hl(0, "cppString", { fg = "#0a8521", italic = true, })
    api.nvim_set_hl(0, "cppRawString", { link = "cppString", })
    api.nvim_set_hl(0, "cppRawStringDelimiter", { link = "cppString", })
    api.nvim_set_hl(0, "cppCharacter", { link = "cString", })
    api.nvim_set_hl(0, "cppEnum", { link = "cType", })
    api.nvim_set_hl(0, "cppSpecialCharacter", { link = "@lsp.type.formatSpecifier.rust" })
    api.nvim_set_hl(0, "cppSpecial", { link = "@lsp.type.formatSpecifier.rust" })
    api.nvim_set_hl(0, "cppModifier", { link = "cppType" })
    api.nvim_set_hl(0, "cppOperator", { link = "ctype", })
    api.nvim_set_hl(0, "cStorageClass", { link = "ctype", })
    api.nvim_set_hl(0, "cppStorageClass", { link = "cStorageClass", })
    -- api.nvim_set_hl(0, "cInclude", { fg = "#af9800", italic = true, })
    api.nvim_set_hl(0, "cInclude", { fg = "#b9a000", italic = true, })
    api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.cpp", { link = "@lsp.typemod.const.constant.rust" })
    api.nvim_set_hl(0, "@lsp.typemod.variable.static.cpp", { bold = true, underline = true, })
    api.nvim_set_hl(0, "@lsp.type.operator.cpp", { link = "" })
    api.nvim_set_hl(0, "@lsp.type.variable.cpp", { fg = "#000000", })
    api.nvim_set_hl(0, "@lsp.type.function.cpp", { fg = "#0070a0", })
    api.nvim_set_hl(0, "@lsp.type.namespace.cpp", { fg = "#9c9c9c", })
    api.nvim_set_hl(0, "@lsp.typemod.typeParameter.classScope.cpp", { fg = cpp_class_purple, bold = true })
    api.nvim_set_hl(0, "@lsp.typemod.typeParameter.functionScope.cpp", { fg = cpp_class_purple, bold = true })
    api.nvim_set_hl(0, "@lsp.typemod.operator.userDefined.cpp", { link = "DiagnosticHint" })

    api.nvim_set_hl(0, "@lsp.typemod.class.classScope.cpp", { link = "Normal" })
    api.nvim_set_hl(0, "@lsp.typemod.class.abstract.cpp", { link = "@lsp.type.interface.rust" })
    api.nvim_set_hl(0, "@lsp.typemod.property.classScope.cpp", { link = "@lsp.type.property" })
    api.nvim_set_hl(0, "@lsp.typemod.property.readonly.cpp", { link = "@lsp.typemod.const.constant.rust" })


    api.nvim_set_hl(0, "@lsp.type.modifier.cpp", { fg = "#0033b3", })

    -- api.nvim_set_hl(0, "@lsp.type.class.cpp", { fg = cpp_class_purple, })
    api.nvim_set_hl(0, "@lsp.typemod.class.declaration.cpp", { link = "DiagnosticHint" })
    api.nvim_set_hl(0, "@lsp.typemod.class.fileScope.cpp", { link = "DiagnosticHint" })
    api.nvim_set_hl(0, "@lsp.typemod.variable.globalScope.cpp", { bold = true, })
    api.nvim_set_hl(0, "@lsp.typemod.class.definition.cpp", { link = "DiagnosticHint" })
    api.nvim_set_hl(0, "@lsp.typemod.class.constructorOrDestructor.cpp", { link = "DiagnosticHint" })
    api.nvim_set_hl(0, "@lsp.typemod.class.classScope.cpp", { link = "DiagnosticHint" })
    -- api.nvim_set_hl(0, "@lsp.mod.classScope.cpp", { link = "@lsp.type.function.cpp" })
    api.nvim_set_hl(0, "@lsp.mod.deduced.cpp", { link = "rustKeyword" })
    api.nvim_set_hl(0, "@lsp.type.macro.cpp", { link = "@macro" })
    api.nvim_set_hl(0, "@lsp.type.method.cpp", { fg = method_color })
    api.nvim_set_hl(0, "@lsp.typemod.method.classScope.cpp", { fg = method_color })
    api.nvim_set_hl(0, "@lsp.typemod.type.defaultLibrary.cpp", { link = "rustKeyword" })
    api.nvim_set_hl(0, "@lsp.typemod.type.defaultLibrary.cpp", { link = "rustKeyword" })
    api.nvim_set_hl(0, "@lsp.typemod.parameter.functionScope.cpp", { sp = "#d4d4d4", underline = true, })
    api.nvim_set_hl(0, "@lsp.typemod.method.definition.cpp", { link = "@lsp.typemod.function.declaration" })
    api.nvim_set_hl(0, "@lsp.type.type.cpp", { link = "DiagnosticHint" })
    api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary.cpp", { italic = false, })

    api.nvim_set_hl(0, "@lsp.typemod.method.defaultLibrary.cpp", { fg = method_color, })
    api.nvim_set_hl(0, "@lsp.typemod.method.defaultLibrary.cpp", { fg = method_color, })
    api.nvim_set_hl(0, "@lsp.type.function.cpp", { fg = "#00ab9c", })
    api.nvim_set_hl(0, "@lsp.typemod.type.deduced.cpp", { link = "Statement", })
end

local function set_objcpp_highlights()
    local objcpp_class_purple = "#8023c0"
    api.nvim_set_hl(0, "@lsp.typemod.class.defaultLibrary.objcpp", { link = "DiagnosticHint", })
    api.nvim_set_hl(0, "@lsp.typemod.function.defaultLibrary.objcpp", { fg = "#00ab9c", })
    api.nvim_set_hl(0, "@lsp.mod.defaultLibrary.objcpp", { link = "none" })
    api.nvim_set_hl(0, "@lsp.type.namespace.objcpp", { link = "none" })
    api.nvim_set_hl(0, "@type.builtin.objcpp", { link = "rustKeyword", })
    -- api.nvim_set_hl(0, "objcppConstant", { fg = "#0033b3", bg = "#f0f4ff", })
    -- api.nvim_set_hl(0, "objcppType", { link = "rustKeyword", })
    -- api.nvim_set_hl(0, "objcppTypedef", { link = "cType", })
    -- api.nvim_set_hl(0, "objcppStructure", { link = "cType", })
    -- api.nvim_set_hl(0, "objcppString", { fg = "#0a8521", italic = true, })
    -- api.nvim_set_hl(0, "objcppString", { fg = "#0a8521", italic = true, })
    -- api.nvim_set_hl(0, "objcppRawString", { link = "objcppString", })
    -- api.nvim_set_hl(0, "objcppRawStringDelimiter", { link = "objcppString", })
    -- api.nvim_set_hl(0, "objcppCharacter", { link = "cString", })
    -- api.nvim_set_hl(0, "objcppEnum", { link = "cType", })
    -- api.nvim_set_hl(0, "objcppSpecialCharacter", { link = "@lsp.type.formatSpecifier.rust" })
    -- api.nvim_set_hl(0, "objcppSpecial", { link = "@lsp.type.formatSpecifier.rust" })
    -- api.nvim_set_hl(0, "objcppModifier", { link = "objcppType" })
    -- api.nvim_set_hl(0, "objcppOperator", { link = "ctype", })
    api.nvim_set_hl(0, "cStorageClass", { link = "ctype", })
    -- api.nvim_set_hl(0, "objcppStorageClass", { link = "cStorageClass", })
    -- api.nvim_set_hl(0, "cInclude", { fg = "#af9800", italic = true, })
    api.nvim_set_hl(0, "cInclude", { fg = "#b9a000", italic = true, })
    api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.objcpp", { link = "@lsp.typemod.const.constant.rust" })
    api.nvim_set_hl(0, "@lsp.typemod.variable.static.objcpp", { bold = true, underline = true, })
    api.nvim_set_hl(0, "@lsp.type.operator.objcpp", { link = "" })
    api.nvim_set_hl(0, "@lsp.type.variable.objcpp", { fg = "#000000", })
    api.nvim_set_hl(0, "@lsp.type.function.objcpp", { fg = "#0070a0", })
    api.nvim_set_hl(0, "@lsp.type.namespace.objcpp", { fg = "#9c9c9c", })
    api.nvim_set_hl(0, "@lsp.typemod.typeParameter.classScope.objcpp", { fg = objcpp_class_purple, bold = true })
    api.nvim_set_hl(0, "@lsp.typemod.typeParameter.functionScope.objcpp", { fg = objcpp_class_purple, bold = true })
    api.nvim_set_hl(0, "@lsp.typemod.operator.userDefined.objcpp", { link = "DiagnosticOk" })

    api.nvim_set_hl(0, "@lsp.typemod.class.classScope.objcpp", { link = "Normal" })
    api.nvim_set_hl(0, "@lsp.typemod.class.abstract.objcpp", { link = "@lsp.type.interface.rust" })
    api.nvim_set_hl(0, "@lsp.typemod.property.classScope.objcpp", { link = "@lsp.type.property" })
    api.nvim_set_hl(0, "@lsp.typemod.property.readonly.objcpp", { link = "@lsp.typemod.const.constant.rust" })


    -- api.nvim_set_hl(0, "@lsp.type.class.objcpp", { fg = objcpp_class_purple, })
    api.nvim_set_hl(0, "@lsp.typemod.class.declaration.objcpp", { link = "DiagnosticHint" })
    api.nvim_set_hl(0, "@lsp.typemod.class.fileScope.objcpp", { link = "DiagnosticHint" })
    -- api.nvim_set_hl(0, "@lsp.typemod.class.globalScope.objcpp", { link = "DiagnosticHint" })
    api.nvim_set_hl(0, "@lsp.typemod.class.definition.objcpp", { link = "DiagnosticHint" })
    api.nvim_set_hl(0, "@lsp.typemod.class.constructorOrDestructor.objcpp", { link = "DiagnosticHint" })
    api.nvim_set_hl(0, "@lsp.typemod.class.classScope.objcpp", { link = "DiagnosticHint" })
    -- api.nvim_set_hl(0, "@lsp.mod.classScope.objcpp", { link = "@lsp.type.function.objcpp" })
    api.nvim_set_hl(0, "@lsp.mod.deduced.objcpp", { link = "rustKeyword" })
    api.nvim_set_hl(0, "@lsp.type.macro.objcpp", { link = "@macro" })
    api.nvim_set_hl(0, "@lsp.type.method.objcpp", { fg = method_color })
    api.nvim_set_hl(0, "@lsp.typemod.method.classScope.objcpp", { fg = method_color })
    api.nvim_set_hl(0, "@lsp.typemod.type.defaultLibrary.objcpp", { link = "rustKeyword" })
    api.nvim_set_hl(0, "@lsp.typemod.type.defaultLibrary.objcpp", { link = "rustKeyword" })
    api.nvim_set_hl(0, "@lsp.typemod.parameter.functionScope.objcpp", { sp = "#d4d4d4", underline = true, })
    api.nvim_set_hl(0, "@lsp.typemod.method.definition.objcpp", { link = "@lsp.typemod.function.declaration" })
    api.nvim_set_hl(0, "@lsp.type.type.objcpp", { link = "DiagnosticHint" })
    api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary.objcpp", { italic = false, })

    api.nvim_set_hl(0, "@lsp.typemod.method.defaultLibrary.objcpp", { fg = method_color, })
    api.nvim_set_hl(0, "@lsp.typemod.method.defaultLibrary.objcpp", { fg = method_color, })
    api.nvim_set_hl(0, "@lsp.type.function.objcpp", { fg = "#00ab9c", })
    api.nvim_set_hl(0, "@lsp.typemod.type.deduced.objcpp", { link = "Statement", })

    api.nvim_set_hl(0, "cTodo", { link = "Todo", })
end

-- C# highlights
local function set_cs_highlights()
    api.nvim_set_hl(0, "@attribute.c_sharp", { fg = "#af9800" })
    api.nvim_set_hl(0, "@comment.documentation.c_sharp", { link = "Comment" })
    api.nvim_set_hl(0, "@type.c_sharp", { link = "Normal" })
    api.nvim_set_hl(0, "@type.builtin.c_sharp", { link = "Statement" })
    api.nvim_set_hl(0, "@function.method.c_sharp", { link = "@lsp.typemod.function.declaration" })
    api.nvim_set_hl(0, "@function.method.call.c_sharp", { fg = "#00ab9c", })
    api.nvim_set_hl(0, "@variable.member.c_sharp", { link = "@lsp.type.property" })
    api.nvim_set_hl(0, "@variable.builtin.c_sharp", { fg = "#0033b3", italic = true })
    api.nvim_set_hl(0, "@variable.c_sharp", { link = "Normal" })
end

local function set_highlights()
    for newgroup, oldgroup in pairs(links) do
        api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true, })
    end

    api.nvim_set_hl(0, "TelescopeBorder", { fg = "#cccccc", })
    api.nvim_set_hl(0, "TelescopeResultsVariable", { fg = "#a215a0", bold = true, })
    api.nvim_set_hl(0, "TelescopeMatching", { fg = "#a215a0", bold = true, })

    api.nvim_set_hl(0, "@keyword.function.wgsl", { link = "Keyword" })
    api.nvim_set_hl(0, "@punctuation.bracket.wgsl", { fg = "#9c9c9c" })
    api.nvim_set_hl(0, "@type.wgsl", { link = "Keyword" })

    -- general highlights
    api.nvim_set_hl(0, "Normal", { fg = "#000000", --[[ bg = "#ffffff", ]] })
    api.nvim_set_hl(0, "Whitespace", { fg = "#000000", --[[ bg = "#ffffff", ]] })
    api.nvim_set_hl(0, "NormalNC", { link = "Normal", })
    api.nvim_set_hl(0, "Todo", { fg = "#008dde", italic = true, bold = true, bg = "#c0ddef", })
    api.nvim_set_hl(0, "LineNr", { fg = "#adadad" })
    api.nvim_set_hl(0, "CursorLine", { bg = "#f5f5f5", })
    api.nvim_set_hl(0, "CursorLineNr", { fg = "#7a7a7a", })
    api.nvim_set_hl(0, "ColorColumn", { link = "CursorLine", })
    api.nvim_set_hl(0, "Search", { bg = "#baceff", })
    api.nvim_set_hl(0, "CurSearch", { bg = "#baceff", })
    api.nvim_set_hl(0, "IncSearch", { bg = "#f0a8d2", })
    api.nvim_set_hl(0, "Folded", { bg = "#eeeeee", })
    api.nvim_set_hl(0, "Visual", { bg = "#a6d2ff", })
    api.nvim_set_hl(0, "Comment", { fg = "#9c9c9c", italic = true })
    api.nvim_set_hl(0, "Special", { link = "@lsp.type.property" })
    api.nvim_set_hl(0, "Title", { link = "Special" })

    api.nvim_set_hl(0, "SpellLocal", { sp = "#bc5c00", undercurl = true, })
    api.nvim_set_hl(0, "SpellBad", { link = "SpellLocal", })

    api.nvim_set_hl(0, "StatusLine", { bg = "#ededed", fg = "none" })
    api.nvim_set_hl(0, "StatusLineNC", { bg = "#eeeeee", fg = "none" })
    api.nvim_set_hl(0, "WinBar", { fg = "#000000", bg = "none" })
    api.nvim_set_hl(0, "WinBarNC", { fg = "#000000", bg = "none" })
    api.nvim_set_hl(0, "WinSeparator", { fg = "#bbbbbb", bg = "none" })
    api.nvim_set_hl(0, "FloatBorder", { link = "WinBar" })
    api.nvim_set_hl(0, "NormalFloat", { bg = "#f7f7f7", fg = "none" })
    api.nvim_set_hl(0, "VertSplit", { link = "LineNr", })
    api.nvim_set_hl(0, "PMenuSel", { bg = "#a6d2ff", fg = "#000000" })
    api.nvim_set_hl(0, "PMenuMatch", { link = "Special" })
    api.nvim_set_hl(0, "PMenuMatchSel", { bg = "#a6d2ff", fg = "#000000" })
    api.nvim_set_hl(0, "PMenu", { link = "NormalFloat", })
    api.nvim_set_hl(0, "IndentBlanklineChar", { fg = "#dddddd", })
    api.nvim_set_hl(0, "IndentBlanklineContextChar", { link = "DiagnosticHint", })

    api.nvim_set_hl(0, "@comment.documentation", { link = "Comment", })
    api.nvim_set_hl(0, "@lsp.mod.GlobalScope", { link = "none", })

    api.nvim_set_hl(0, "TreesitterContext", { link = "CursorLine" })

    -- diagnostic colours
    api.nvim_set_hl(0, "DiagnosticError", { fg = "#d95716", })
    api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#d9aa0d", })
    api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#cccccc", })
    api.nvim_set_hl(0, "DiagnosticHint", { fg = "#6a959f", })
    api.nvim_set_hl(0, "DiagnosticUnderlineError", { sp = "#d95716", undercurl = true, })
    api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { sp = "#d9aa0d", undercurl = true, })
    api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { sp = "#cccccc", undercurl = true, })
    api.nvim_set_hl(0, "DiagnosticUnderlineHint", { sp = "#6a959f", undercurl = true, })
    api.nvim_set_hl(0, "DiagnosticDeprecated", { link = "ErrorMsg" })

    api.nvim_set_hl(0, "Operator", { fg = "#000000", })
    api.nvim_set_hl(0, "Delimiter", { fg = "#000000", })
    api.nvim_set_hl(0, "@punctuation.delimiter", { link = "Delimiter" })
    api.nvim_set_hl(0, "rustFoldBraces", { fg = "#6a959f", })
    api.nvim_set_hl(0, "rustCommentLineDoc", { link = "Comment", })
    api.nvim_set_hl(0, "rustBoxPlacementBalance", { fg = "#6a959f", })
    api.nvim_set_hl(0, "rustIdentifier", { fg = "#000000", })
    api.nvim_set_hl(0, "Identifier", { fg = "#000000", })
    api.nvim_set_hl(0, "MatchParen", { fg = "#000000", bg = "#93d9d9", })
    api.nvim_set_hl(0, "Statement", { fg = "#0033b3", })
    api.nvim_set_hl(0, "rustStorage", { fg = "#0033b3", })
    api.nvim_set_hl(0, "rustSigil", { fg = "#000000", })
    api.nvim_set_hl(0, "rustKeyword", { fg = "#0033b3", })
    api.nvim_set_hl(0, "rustAssert", { link = "@macro", })
    api.nvim_set_hl(0, "rustQuestionMark", { link = "rustKeyword", })

    -- literals
    api.nvim_set_hl(0, "String", { fg = "#0f8f21", italic = true, })
    api.nvim_set_hl(0, "Character", { link = "String", })
    -- api.nvim_set_hl(0, "rustLifetime", { fg = "#20999d", italic = true, })
    api.nvim_set_hl(0, "rustLifetime", { fg = "#00ab9c" })
    api.nvim_set_hl(0, "@storageclass.lifetime.rust", { link = "rustLifetime" })
    api.nvim_set_hl(0, "rustEscape", { fg = "#0033b3", })
    api.nvim_set_hl(0, "Number", { fg = "#1750eb", })
    api.nvim_set_hl(0, "rustFloat", { fg = "#1750eb", })
    --

    api.nvim_set_hl(0, "Boolean", { fg = "#0033b3", })
    api.nvim_set_hl(0, "Type", { link = "Normal" })
    api.nvim_set_hl(0, "@type", { fg = "#000000", })
    -- what do these actually do?
    api.nvim_set_hl(0, "Constant", {})

    api.nvim_set_hl(0, "PreProc", { fg = "#b9a000", })
    api.nvim_set_hl(0, "rustModPath", { fg = "#0033b3", })

    api.nvim_set_hl(0, "Function", {})

    api.nvim_set_hl(0, "@comment.todo.comment", { link = "Todo" })
    api.nvim_set_hl(0, "@comment.note.comment", { fg = "#d9aa0d", bold = true })
    api.nvim_set_hl(0, "@comment.error.comment", { fg = "#d95716", bold = true })
    api.nvim_set_hl(0, "@string.special.url.comment", { fg = "#70abe9", italic = true, underline = true })

    api.nvim_set_hl(0, "@lsp.typemod.constParameter.constant.rust", {
        link = "@lsp.typemod.const.constant.rust"
    })
    api.nvim_set_hl(0, "@lsp.typemod.const.documentation.rust", {
        link = "@lsp.typemod.const.constant.rust"
    })
    api.nvim_set_hl(0, "@keyword.import.rust", { link = "Statement" })
    api.nvim_set_hl(0, "@character.special.rust", { link = "Normal" })
    api.nvim_set_hl(0, "@lsp.type.typeParameter", { fg = "#20999d", })
    api.nvim_set_hl(0, "@lsp.type.property", { fg = "#a215a0" })
    api.nvim_set_hl(0, "@lsp.type.enumMember", { fg = "#a215a0", italic = true, })
    api.nvim_set_hl(0, "@lsp.typemod.enumMember.library.rust", { link = "@lsp.type.enumMember" })
    api.nvim_set_hl(0, "@lsp.typemod.enumMember.defaultLibrary.rust", { link = "@lsp.type.enumMember" })
    api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary.rust", {})
    api.nvim_set_hl(0, "@lsp.typemod.const.constant.rust", { fg = "#a215a0", bold = true, })
    api.nvim_set_hl(0, "@lsp.type.static.rust", { fg = "#000000", bold = true, })
    api.nvim_set_hl(0, "@lsp.type.namespace.rust", { fg = "#000000", })
    api.nvim_set_hl(0, "@macro", { fg = "#dd6718", })
    api.nvim_set_hl(0, "@function.macro.rust", { link = "@macro" })
    -- * -- C highlights -- * --
    api.nvim_set_hl(0, "@lsp.mod.defaultLibrary.c", { link = "DiagnosticHint", })
    api.nvim_set_hl(0, "@lsp.typemod.function.defaultLibrary.c", { fg = "#00ab9c", })
    api.nvim_set_hl(0, "cType", { link = "rustKeyword", })
    api.nvim_set_hl(0, "cTypedef", { link = "cType", })
    api.nvim_set_hl(0, "cStructure", { link = "cType", })
    api.nvim_set_hl(0, "cString", { fg = "#0a8521", italic = true, })
    api.nvim_set_hl(0, "cCharacter", { link = "cString", })
    api.nvim_set_hl(0, "cEnum", { link = "cType", })
    api.nvim_set_hl(0, "cSpecialCharacter", { link = "@lsp.type.formatSpecifier.rust" })
    api.nvim_set_hl(0, "cSpecial", { link = "@lsp.type.formatSpecifier.rust" })
    api.nvim_set_hl(0, "@lsp.type.variable.c", { fg = "#000000", })
    api.nvim_set_hl(0, "@type.builtin.c", { link = "Statement" })
    api.nvim_set_hl(0, "@lsp.typemod.variable.readonly.c", { link = "@lsp.mod.constant.rust", })
    api.nvim_set_hl(0, "@lsp.type.function.c", { fg = "#0070a0", })
    api.nvim_set_hl(0, "cOperator", { link = "ctype", })

    -- * -- Lua highlights -- * --
    api.nvim_set_hl(0, "luaFunction", { fg = "#0033b3", italic = true, })
    api.nvim_set_hl(0, "luaString", { fg = "#0a8521", italic = true, })
    api.nvim_set_hl(0, "luaStatement", { link = "Statement", })
    api.nvim_set_hl(0, "@keyword.function.lua", { link = "Keyword", })
    api.nvim_set_hl(0, "@lsp.typemod.function.defaultLibrary.lua", { link = "@macro" })
    api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary.lua", { link = "DiagnosticHint" })
    api.nvim_set_hl(0, "@lsp.type.function.lua", { fg = "#00ab9c", })
    api.nvim_set_hl(0, "@lsp.type.method.lua", { fg = "#0070a0", italic = true })


    -- * -- Rust highlights -- * --
    -- types
    api.nvim_set_hl(0, "@lsp.mod.defaultLibrary.rust", { fg = "#000000", })
    api.nvim_set_hl(0, "@lsp.typemod.property.library.rust", { link = "@lsp.type.property" })
    api.nvim_set_hl(0, "@variable.member.rust", { link = "@lsp.type.property" })

    -- variables and parameters (closure variables are considered parameters)
    api.nvim_set_hl(0, "@lsp.type.variable.rust", { link = "Identifier" })
    api.nvim_set_hl(0, "@lsp.type.parameter", { fg = "#000000", })
    api.nvim_set_hl(0, "@lsp.typemod.variable.mutable.rust", { sp = "#aaaaaa", underline = true, })
    api.nvim_set_hl(0, "@lsp.typemod.parameter.mutable.rust", { link = "@lsp.typemod.variable.mutable.rust" })
    api.nvim_set_hl(0, "@lsp.typemod.variable.reference.rust", { italic = true, })
    api.nvim_set_hl(0, "@lsp.typemod.parameter.reference.rust", { italic = true, })

    -- standalone function declarations
    api.nvim_set_hl(0, "@lsp.typemod.function.declaration", { fg = "#006f95", bold = true, })
    api.nvim_set_hl(0, "@function.wgsl", { link = "@lsp.typemod.function.declaration" })
    -- standalone function calls
    api.nvim_set_hl(0, "@lsp.type.function.rust", { fg = "#00ab9c", })
    api.nvim_set_hl(0, "@lsp.typemod.function.static.rust", { fg = method_color, })
    api.nvim_set_hl(0, "@lsp.mod.callable.rust", { link = "@lsp.type.function.rust" })
    api.nvim_set_hl(0, "@lsp.typemod.variable.callable", { link = "@lsp.type.function.rust" })
    api.nvim_set_hl(0, "@lsp.typemod.function.library.rust", { fg = "#00ab9c", })
    api.nvim_set_hl(0, "@lsp.typemod.function.defaultLibrary.rust", { link = "none" })
    -- associated function (calls and declarations)
    api.nvim_set_hl(0, "@lsp.typemod.method.static.rust", { fg = "#0079a5", italic = true, })
    api.nvim_set_hl(0, "@lsp.typemod.function.associated.rust", { fg = "#0079a5", })

    api.nvim_set_hl(0, "@lsp.typemod.method.defaultLibrary.rust", { fg = method_color, })
    api.nvim_set_hl(0, "rustFuncCall", { fg = method_color, })
    -- method declaration
    api.nvim_set_hl(0, "@lsp.typemod.method.declaration.rust", { bold = true })
    -- method call
    api.nvim_set_hl(0, "@lsp.typemod.method.reference.rust", { fg = method_color, })
    api.nvim_set_hl(0, "@function.call.rust", { fg = method_color, })
    api.nvim_set_hl(0, "@lsp.typemod.method.consuming.rust", { fg = method_color, })

    api.nvim_set_hl(0, "@lsp.type.typeAlias.rust", { fg = "#000000", })
    api.nvim_set_hl(0, "@lsp.type.selfTypeKeyword.rust", { link = "DiagnosticHint" })
    api.nvim_set_hl(0, "@lsp.type.selfKeyword.rust", { fg = "#0033b3", })
    api.nvim_set_hl(0, "@lsp.typemod.selfKeyword.consuming.rust", { bold = true, })
    api.nvim_set_hl(0, "@lsp.typemod.selfKeyword.mutable.rust", { link = "@lsp.typemod.variable.mutable.rust" })
    api.nvim_set_hl(0, "@lsp.typemod.selfKeyword.reference.rust", { italic = true, })

    -- api.nvim_set_hl(0, "@lsp.mod.constant.rust", { fg = "#a215a0", bold = true, })
    api.nvim_set_hl(0, "@lsp.type.builtinType.rust", { fg = "#0033b3", })
    api.nvim_set_hl(0, "@lsp.type.label.rust", { fg = "#00ab9c", })

    api.nvim_set_hl(0, "@lsp.type.keyword.rust", { link = "rustKeyword", })
    api.nvim_set_hl(0, "@lsp.typemod.keyword.constant.rust", { link = "@lsp.type.keyword.rust" })
    api.nvim_set_hl(0, "cConstant", { link = "@lsp.mod.constant.rust", })
    api.nvim_set_hl(0, "@lsp.type.struct.rust", { link = "Type", })
    api.nvim_set_hl(0, "@lsp.type.enum.rust", { link = "Type", })
    -- default library types
    api.nvim_set_hl(0, "@lsp.typemod.enum.defaultLibrary.rust", { link = "DiagnosticHint", --[[ fg = "#bc5c00", ]] })
    api.nvim_set_hl(0, "@lsp.typemod.struct.defaultLibrary.rust", { link = "@lsp.typemod.enum.defaultLibrary.rust", })
    api.nvim_set_hl(0, "rustTrait", { link = "@lsp.typemod.enum.defaultLibrary.rust", })
    api.nvim_set_hl(0, "@keyword.function.rust", { link = "@keyword.rust", })
    api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "#8c8c8c", sp = "#8c8c8c", underline = true, italic = true, })
    api.nvim_set_hl(0, "@lsp.type.macro.rust", { link = "@macro" })
    api.nvim_set_hl(0, "@lsp.typemod.macro.defaultLibrary.rust", { link = "@macro" })
    api.nvim_set_hl(0, "@lsp.typemod.macro.library.rust", { link = "@macro" })
    api.nvim_set_hl(0, "@lsp.typemod.macro.declaration.rust", { bold = true })
    api.nvim_set_hl(0, "@lsp.type.string.rust", { fg = "#0f8f21", italic = true, })
    api.nvim_set_hl(0, "rustString", { link = "String" })
    api.nvim_set_hl(0, "@lsp.type.formatSpecifier.rust", { fg = "#0033b3", })
    api.nvim_set_hl(0, "@lsp.typemod.decorator.attribute.rust", { fg = "#b89e00" })
    api.nvim_set_hl(0, "@lsp.typemod.generic.attribute.rust", { fg = "#000000" })
    api.nvim_set_hl(0, "@lsp.typemod.derive.attribute.rust", { fg = "#000000" })
    api.nvim_set_hl(0, "@lsp.mod.attribute.rust", { fg = "#af9800" })
    api.nvim_set_hl(0, "@lsp.typemod.attributeBracket.attribute.rust", { link = "@lsp.mod.attribute.rust" })
    api.nvim_set_hl(0, "@punctuation.bracket.rust", {})
    api.nvim_set_hl(0, "@include.rust", { link = "Keyword" })
    api.nvim_set_hl(0, "@variable.builtin.rust", {})
    api.nvim_set_hl(0, "@punctuation.delimiter.rust", {})
    api.nvim_set_hl(0, "@lsp.typemod.keyword.unsafe.rust", { fg = "#cc0000", })
    api.nvim_set_hl(0, "@lsp.mod.unsafe.rust", { bg = "#ffeeee" })
    api.nvim_set_hl(0, "rustMacro", { link = "@macro" })
    api.nvim_set_hl(0, "Braces", { link = "DiagnosticHint", })
    api.nvim_set_hl(0, "@lsp.type.lifetime.rust", { link = "rustLifetime", })
    api.nvim_set_hl(0, "@lsp.typemod.operator.controlFlow.rust", { link = "Statement", })

    api.nvim_set_hl(0, "@lsp.type.interface.rust", { fg = "#8a2bed" })
    api.nvim_set_hl(0, "@lsp.typemod.interface.library.rust", { link = "@lsp.type.interface.rust" })
    api.nvim_set_hl(0, "@lsp.typemod.interface.declaration.rust", { link = "@lsp.type.interface.rust", })

    api.nvim_set_hl(0, "TabLineSel", { link = "Visual", })

    api.nvim_set_hl(0, "SignatureMarkText", { link = "Comment", })

    api.nvim_set_hl(0, "OilDir", { link = "@lsp.type.method.cpp", })
    api.nvim_set_hl(0, "OilLink", { link = "@lsp.type.namespace.cpp", })
    api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = "#426d77", bg = "#e5e5e5" })
    api.nvim_set_hl(0, "markdownCodeBlock", { link = "@markup.raw.markdown_inline" })
    api.nvim_set_hl(0, "markdownCode", { link = "@markup.raw.markdown_inline" })
    api.nvim_set_hl(0, "markdownRule", { link = "@macro" })
    api.nvim_set_hl(0, "markdownBlockquote", { link = "@lsp.type.namespace.cpp" })
    api.nvim_set_hl(0, "markdownH1", { fg = "#003389", bold = true })
    api.nvim_set_hl(0, "markdownH2", { fg = method_color, bold = true })
    api.nvim_set_hl(0, "markdownH3", { fg = "#6a959f", bold = true })
    api.nvim_set_hl(0, "markdownH4", { fg = "#9c9c9c", bold = true })
    api.nvim_set_hl(0, "markdownH5", { fg = "#9c9c9c" })
    api.nvim_set_hl(0, "markdownH6", { fg = "#9c9c9c" })
    -- api.nvim_set_hl(0, "DiagnosticError", { fg = "#d95716", })
    -- api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#d9aa0d", })
    -- api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#cccccc", })
    -- api.nvim_set_hl(0, "DiagnosticHint", { fg = "#6a959f", })

    api.nvim_set_hl(0, "IblScope", { link = "Comment" })
    api.nvim_set_hl(0, "IblIndent", { link = "DiagnosticInfo" })

    api.nvim_set_hl(0, "@text.note", { fg = "#ff0000" })

    set_cpp_highlights()
    set_objcpp_highlights()
    set_cs_highlights()
    set_glsl_highlights()
    set_c_highlights()
end

M = {}

vim.api.nvim_create_autocmd("LspTokenUpdate", {
    callback = function(args)
        local token = args.data.token
        if token.type == "function" and token.modifiers.static and
            token.modifiers.library then
            vim.lsp.semantic_tokens.highlight_token(
                token, args.buf, args.data.client_id,
                "@lsp.typemod.function.static.rust"
            )
        end
        if token.type == "enumMember" then
            vim.lsp.semantic_tokens.highlight_token(
                token, args.buf, args.data.client_id,
                "@lsp.type.enumMember.cpp"
            )
        end
        -- if token.type == "function" and token.modifiers.fileScope and not
        --     token.modifiers.definition then
        --     vim.lsp.semantic_tokens.highlight_token(
        --         token, args.buf, args.data.client_id,
        --         "@lsp.typemod.variable.reference.rust"
        --     )
        -- end
        if token.type == "variable" and (token.modifiers.functionScope or
                token.modifiers.fileScope) and token.modifiers.readonly then
            vim.lsp.semantic_tokens.highlight_token(
                token, args.buf, args.data.client_id,
                "@lsp.typemod.const.constant.rust"
            )
        end
        if token.type == "class" and token.modifiers.abstract then
            vim.lsp.semantic_tokens.highlight_token(
                token, args.buf, args.data.client_id,
                "@lsp.type.interface.rust"
            )
            if token.modifiers.declaration or token.modifiers.definition or
                token.modifiers.globalScope then
                vim.lsp.semantic_tokens.highlight_token(
                    token, args.buf, args.data.client_id,
                    "@lsp.type.interface.rust"
                )
            end
        end
    end
})

function M.set_theme()
    vim.opt.background = "light"
    set_highlights()
    io.stdout:write(("\027]11;#%06x\027\\"):format(0xffffff))

    api.nvim_set_hl(0, "@lsp.type.formatSpecifier.rust", { fg = "#0033b3", italic = false, })
    io.stdout:write(("\027]11;#%06x\027\\"):format(16777215))

    vim.api.nvim_set_hl(0, "BlueComment",   { fg = "#008dde", bg = "#c0ddef", italic = true, bold = true })
    vim.api.nvim_set_hl(0, "YellowComment", { fg = "#d9aa0d", bg = "#f7fab7", italic = true, bold = true })
    vim.api.nvim_set_hl(0, "RedComment",    { fg = "#d95716", bg = "#ffeeee", italic = true, bold = true })
    vim.api.nvim_set_hl(0, "PurpleComment", { fg = "#bb61e8", bg = "#f7e3fc", italic = true, bold = true })
    vim.api.nvim_set_hl(0, "GreenComment",  { fg = "#4dbb20", bg = "#e3f7de", italic = true, bold = true })
    vim.api.nvim_set_hl(0, "GreenUnderlinedComment",  { fg = "#4dbb20", bg = "#e3f7de", italic = true, bold = true, underline = true })

    vim.api.nvim_set_hl(0, "@ibl.indent.char.1", { fg = "#dfdfdf" })
    vim.api.nvim_set_hl(0, "@ibl.scope.char.1", { fg = "#cccccc" })

    print("Set light theme")
end

return M
