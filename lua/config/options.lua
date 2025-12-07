-- Vim options.

local opt = vim.opt

vim.g.loaded_node_provider    = 0
vim.g.loaded_perl_provider    = 0
vim.g.loaded_python_provider  = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider    = 0

opt.guicursor = "n-v:block-blinkwait400-blinkon200-blinkoff200,i-ci-ve:ver80,r-cr:hor80,o:hor50,c:ver80,a:blinkwait10-blinkoff350-blinkon350-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

opt.history = 500
opt.ttimeoutlen = 1
opt.updatetime = 50

opt.laststatus = 2

-- TODO
opt.autoindent  = false
opt.smartindent = false

opt.shiftwidth  = 4
opt.tabstop     = 4
opt.softtabstop = 4

opt.expandtab = true

opt.autowrite = true

opt.termguicolors = true

opt.clipboard = "unnamedplus"

opt.ignorecase = true
opt.smartcase = true

opt.number = true
opt.relativenumber = true
opt.numberwidth = 6
vim.wo.signcolumn = "yes"

opt.scrolloff = 12

opt.inccommand = "nosplit"
opt.incsearch = true
opt.hlsearch = true

opt.linebreak = true

opt.fillchars = { eob = " " }
opt.cursorline = true

opt.undofile = true
opt.undodir = os.getenv("HOME") .. "/.nvim/undodir/"
opt.swapfile = false

opt.shortmess = "OTxtIsonF"

opt.background = "dark"
-- required for toggleterm to function correctly
opt.hidden = true

opt.spelllang = "en_gb"

opt.shada = "!,'200,<50,s10,h"
