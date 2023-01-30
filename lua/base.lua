vim.cmd "autocmd!"

vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.opt.clipboard = "unnamedplus"

vim.wo.number = true
vim.opt.swapfile = false
vim.opt.wildmenu = true
vim.opt.title = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.scrolloff = 10
vim.opt.shell = "zsh"
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.smartcase = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = true -- No Wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append { "**" } -- Finding files - Search down into subfolders
vim.opt.wildignore:append { "*/node_modules/*" }
-- vim.opt.showtabline = 2
-- vim.opt.modifiable = true

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.updatetime = 300
vim.o.incsearch = false
vim.wo.signcolumn = "yes"

-- Undercurl
vim.cmd [[let &t_Cs = "\e[4:3m"]]
vim.cmd [[let &t_Ce = "\e[4:0m"]]

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

vim.api.nvim_set_option("clipboard", "unnamed")

-- vim.cmd [[colorscheme codedark]]

-- Add asterisks in block comments
vim.opt.formatoptions:append { "r" }
vim.cmd [[
  filetype plugin indent on
  syntax on
  set ma
  cnoreabbrev exercism Exercism
]]
vim.cmd [[
autocmd BufWritePre * :%s/\s\+$//e
autocmd FocusLost * nested silent! wall
autocmd BufWinEnter * setlocal modifiable
]]
