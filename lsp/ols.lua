-- ols (Odin Language Server) config from nvim-lspconfig.

local function tbl_flatten(t)
    -- @diagnostic disable-next-line:deprecated
    return ((vim.fn.has('nvim-0.11') == 1) and vim.iter(t):flatten(math.huge):totable()) or vim.tbl_flatten(t)
end

local function strip_archive_subpath(path)
    path = vim.fn.substitute(path, 'zipfile://\\(.\\{-}\\)::[^\\\\].*$', "\\1", "")
    path = vim.fn.substitute(path, 'tarfile:\\(.\\{-}\\)::.*$', "\\1", "")
    return path
end

local function search_ancestors(startpath, func)
    if (vim.fn.has('nvim-0.11') == 1) then
        vim.validate('func', func, 'function')
    end

    if func(startpath) then
        return startpath
    end

    local guard = 100
    for path in vim.fs.parents(startpath) do
        guard = guard - 1
        if guard == 0 then
            return
        end

        if func(path) then
            return path
        end
    end
end

local function escape_wildcards(path)
    return path:gsub('([%[%]%?%*])', '\\%1')
end

local function root_pattern(...)
    local patterns = tbl_flatten({ ... })

    return function(startpath)
        startpath = strip_archive_subpath(startpath)
        for _, pattern in ipairs(patterns) do
            local match = search_ancestors(startpath, function(path)
                for _, p in ipairs(vim.fn.glob(table.concat({ escape_wildcards(path), pattern }, '/'), true, true)) do
                    if vim.uv.fs_stat(p) then
                        return path
                    end
                end
            end)

            if match ~= nil then
                local real = vim.uv.fs_realpath(match)
                return real or match
            end
        end
    end
end

return {
    cmd = { 'ols' },
    filetypes = { 'odin' },
    root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        on_dir(root_pattern('ols.json', '.git', '*.odin')(fname))
    end,
}
