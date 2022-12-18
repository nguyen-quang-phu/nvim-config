--local keymap = vim.api.nvim_set_keymap
--local default_opts = { noremap = true, silent = true }
--local expr_opts = { noremap = true, expr = true, silent = true }

---- Better escape using jk in insert and terminal mode
--keymap("i", "jk", "<ESC>", default_opts)
--keymap("t", "jk", "<C-\\><C-n>", default_opts)

---- Center search results
--keymap("n", "n", "nzz", default_opts)
--keymap("n", "N", "Nzz", default_opts)

---- Visual line wraps
--keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
--keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

---- Better indent
--keymap("v", "<", "<gv", default_opts)
--keymap("v", ">", ">gv", default_opts)

---- Paste over currently selected text without yanking it
--keymap("v", "p", '"_dP', default_opts)

---- Switch buffer
--keymap("n", "<S-h>", ":bprevious<CR>", default_opts)
--keymap("n", "<S-l>", ":bnext<CR>", default_opts)

---- Cancel search highlighting with ESC
--keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

---- Move selected line / block of text in visual mode
--keymap("x", "K", ":move '<-2<CR>gv-gv", default_opts)
--keymap("x", "J", ":move '>+1<CR>gv-gv", default_opts)

---- Resizing panes
--keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
--keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
--keymap("n", "<Up>", ":resize -1<CR>", default_opts)
--keymap("n", "<Down>", ":resize +1<CR>", default_opts)

--vim.g.mapleader = " " -- Map leader to Space

---- Select all
--keymap('n', '<D-a>', 'gg<S-v>G')
--keymap('i', '<D-v>', '<Esc>pi')
--keymap('i', '<D-[>', '<Esc>')

---- Save with root permission (not working for now)
----vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

---- New tab
---- keymap.set('n', 'te', ':tabedit')
---- Split window
---- keymap.set('n', 'ss', ':split<Return><C-w>w')
---- keymap.set('n', 'sv', ':vsplit<Return><C-w>w')
---- Move window
---- keymap.set('n', '<Space>', '<C-w>w')
--keymap('', '<D-w>o', '<C-w>o')
--keymap('', '<D-w>q', '<C-w>q')
--keymap('', '<D-w>s', '<C-w>s')
--keymap('', '<D-w>v', '<C-w>v')
--keymap('', '<D-w>h', '<C-w>h')
--keymap('', '<D-w>k', '<C-w>k')
--keymap('', '<D-w>j', '<C-w>j')
--keymap('', '<D-w>l', '<C-w>l')

---- Resize window
---- keymap.set('n', '<C-w><left>', '<C-w><')
---- keymap.set('n', '<C-w><right>', '<C-w>>')
---- keymap.set('n', '<C-w><up>', '<C-w>+')
---- keymap.set('n', '<C-w><down>', '<C-w>-')
