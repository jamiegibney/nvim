vim.g.indent_blankline_use_treesitter = true
vim.cmd "autocmd BufRead,BufNewFile * syn match Braces /[{}]/"

vim.keymap.set("n", "<leader>hg", ":Inspect<CR>")

local function set_hl(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

M = {}

function M.set_dark_theme()
    vim.cmd.colorscheme "quiet"
    vim.opt.background = "dark"

    set_hl("TODOComment", { fg = "#459cff", bg = "#052c3f", italic = true, bold = true })
    set_hl("NOTEComment", { fg = "#d9aa0d", bg = "#2f2803", italic = true, bold = true })
    set_hl("IMPORTANTComment", { fg = "#d95716", bg = "#371c1c", italic = true, bold = true })
    set_hl("MARKComment", { fg = "#61cf34", bg = "#072f02", italic = true, bold = true, underline = true })
    set_hl("NocheckinComment", { fg = "#bb61e8", bg = "#392552", italic = true, bold = true })

    vim.fn.matchadd("TODOComment", [[\<TODO\>]])
    vim.fn.matchadd("NOTEComment", [[\<NOTE\>]])
    vim.fn.matchadd("MARKComment", [[\<MARK\>]])
    vim.fn.matchadd("IMPORTANTComment", [[\<IMPORTANT\>]])
    vim.fn.matchadd("NocheckinComment", [[nocheckin]])

    set_hl("cTodo", { fg = "#397fac", bg = "#112f34", italic = true, bold = true })

    local bg_color = "#181818"

    local fn_color = "#607781"
    local type_color = "#767676"
    local keyword_color = "#586c8e"

    set_hl("@lsp.type.macro",                      { fg = "#975d36", })
    set_hl("@lsp.type.function",                   { fg = fn_color })
    set_hl("@lsp.typemod.function",                { fg = fn_color })
    set_hl("@lsp.typemod.method",                  { fg = fn_color })
    set_hl("@lsp.typemod.function.defaultLibrary", { fg = fn_color })
    set_hl("@lsp.typemod.function.globalScope",    { fg = fn_color })
    set_hl("@lsp.type.type",                       { fg = keyword_color })
    set_hl("@lsp.type.class",                      { fg = type_color })
    set_hl("@lsp.type.enum",                       { fg = type_color })
    set_hl("@lsp.type.struct",                     { fg = type_color })
    set_hl("@lsp.typemod.variable.readonly",       { fg = "#9b7891" })
    set_hl("@lsp.type.enumMember",                 { fg = "#9b7891", italic = true })

    set_hl("@constant.macro",                      { fg = "#975d36", })
    set_hl("cPreCondit",                           { fg = "#975d36", })
    set_hl("@function",                            { fg = fn_color })
    set_hl("@function.call",                       { fg = fn_color })
    set_hl("@function.method.call",                { fg = fn_color })
    set_hl("@keyword.type",                        { fg = keyword_color })
    set_hl("@keyword.repeat",                      { fg = keyword_color })
    set_hl("@keyword.modifier",                    { fg = keyword_color })
    set_hl("@type.builtin",                        { fg = keyword_color })
    set_hl("@type",                                { fg = type_color })
    set_hl("@constant",                            { link = "none" })
    set_hl("@variable",                            { link = "none" })
    set_hl("@_parent",                             { link = "Identifier" })

    set_hl("cConditional",                         { fg = keyword_color })
    set_hl("cStorageClass",                        { fg = keyword_color })
    set_hl("cType",                                { fg = keyword_color })
    set_hl("cTypedef",                             { fg = keyword_color })
    set_hl("cStructure",                           { fg = keyword_color })
    set_hl("cRepeat",                              { fg = keyword_color })
    set_hl("cLabel",                               { fg = keyword_color })
    set_hl("cStatement",                           { fg = keyword_color })
    set_hl("cConditional",                         { fg = keyword_color })
    set_hl("cConditional",                         { fg = keyword_color })
    set_hl("cppConditional",                       { fg = keyword_color })
    set_hl("cppStorageClass",                      { fg = keyword_color })
    set_hl("cppType",                              { fg = keyword_color })
    set_hl("cppTypedef",                           { fg = keyword_color })
    set_hl("cppStructure",                         { fg = keyword_color })
    set_hl("cppRepeat",                            { fg = keyword_color })
    set_hl("cppLabel",                             { fg = keyword_color })
    set_hl("cppStatement",                         { fg = keyword_color })
    set_hl("cppConditional",                       { fg = keyword_color })
    set_hl("cppConditional",                       { fg = keyword_color })
    set_hl("cppModifier",                          { fg = keyword_color })
    set_hl("@variable.bash",                       { fg = keyword_color })
    set_hl("@constant.bash",                       { fg = fn_color })
    set_hl("@punctuation.special.bash",            { fg = "#555555" })
    set_hl("@tag.xml",                             { fg = keyword_color })
    set_hl("@tag.delimiter.xml",                   { fg = "#555555" })
    set_hl("Statement",                            { fg = "#eaeaea" })
    set_hl("Identifier",                           { fg = "#eaeaea" })
    set_hl("Normal",                               { fg = "#eaeaea", bg = bg_color, })
    set_hl("MatchParen",                           { fg = "#111111", bg = "#888888", })
    set_hl("Preproc",                              { fg = "#9e9b87", })
    set_hl("Comment",                              { italic = true,  fg = "#666666", })
    set_hl("String",                               { fg = "#5a6753", italic = true })
    set_hl("Braces",                               { fg = "#565959", })
    set_hl("Statusline",                           { bg = "#202020", })
    set_hl("StatuslineNC",                         { bg = "#202020", })
    set_hl("VertSplit",                            { bg = "none", })
    set_hl("FloatNormal",                          { bg = "#202020", })
    set_hl("FloatBorder",                          { fg = "#bababa", bg = "#202020", })
    set_hl("PMenu",                                { fg = "none",    bg = "#202020", })
    set_hl("DapUIModifiedValue",                   { link = "DiagnosticWarn" })
    -- api.nvim_set_hl(0, "DiagnosticHint", { fg = "#6a959f", })

    set_hl("@ibl.indent.char.1", { fg = "#2a2a2a" })
    set_hl("@ibl.scope.char.1", { fg = "#444444" })

    local bg = vim.api.nvim_get_hl(0, { name = "Normal", link = false }).bg
    io.stdout:write(("\027]11;#%06x\027\\"):format(bg))
end

M.set_dark_theme()

return M
