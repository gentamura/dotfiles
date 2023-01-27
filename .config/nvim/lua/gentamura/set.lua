vim.opt.guicursor = ""

vim.opt.encoding = "UTF-8"
vim.opt.ruler = true
vim.opt.history = 2000
vim.opt.helplang = "en"
vim.opt.formatoptions:append("mM")
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.clipboard:append("unnamedplus")

vim.opt.list = true  -- 不可視文字を表示する
vim.opt.listchars.tab = '>~' -- タブを >~ で表示

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab  = true

vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

