local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
-- keymap("n", "", "<C-w>h", opts)
-- keymap("n", "<C-j>", "<C-w>j", opts)
-- keymap("n", "<C-k>", "<C-w>k", opts)
-- keymap("n", "<C-l>", "<C-w>l", opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts)

local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

vim.g.mapleader = " " -- Map leader to Space

keymap("i", "<D-[>", "<Esc>", default_opts)
keymap("n", "<D-o>", "<C-o>", default_opts)
keymap("n", "<D-i>", "<C-i>", default_opts)
keymap("v", "<D-/>", "gc", default_opts)

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)
keymap("t", "jk", "<C-\\><C-n>", default_opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Switch buffer
keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
keymap("n", "<S-l>", ":bnext<CR>", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<Esc>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("v", "<S-k>", ":move '<-2<CR>gv-gv", default_opts)
keymap("v", "<S-j>", ":move '>+1<CR>gv-gv", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)
keymap("n", "<S-D-e>", "<cmd>NvimTreeFindFile<cr>", default_opts)

-- Select all
keymap("n", "<D-a>", "gg<S-v>G", default_opts)
keymap("i", "<D-v>", "<Esc>pa", default_opts)

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- New tab
-- keymap.set('n', 'te', ':tabedit')
-- Split window
-- keymap.set('n', 'ss', ':split<Return><C-w>w')
-- keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
-- Move window
-- keymap.set('n', '<Space>', '<C-w>w')
keymap("", "<D-w>o", "<C-w>o", default_opts)
keymap("", "<D-w>q", "<C-w>q", default_opts)
keymap("", "<D-w>s", "<C-w>s", default_opts)
keymap("", "<D-w>v", "<C-w>v", default_opts)
keymap("", "<D-w>h", "<C-w>h", default_opts)
keymap("", "<D-w>k", "<C-w>k", default_opts)
keymap("", "<D-w>j", "<C-w>j", default_opts)
keymap("", "<D-w>l", "<C-w>l", default_opts)
keymap("i", "<D-s>", "<Esc>:w<CR>", default_opts)
keymap("n", "<D-s>", "<Esc>:w<CR>", default_opts)

-- Resize window
-- keymap.set('n', '<C-w><left>', '<C-w><')
-- keymap.set('n', '<C-w><right>', '<C-w>>')
-- keymap.set('n', '<C-w><up>', '<C-w>+')
-- keymap.set('n', '<C-w><down>', '<C-w>-')
