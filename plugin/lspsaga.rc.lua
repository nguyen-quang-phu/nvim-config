local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

saga.setup {
  debug = true,
  code_action_keys = {
    quit = "<ESC>",
    exec = "<CR>",
  },
  finder_action_keys = {
    open = "<CR>",
  },
  -- code_action_prompt = {
  --   virtual_text = false,
  -- },
  --[[ code_action = { ]]
  --[[   num_shortcut = true, ]]
  --[[   keys = { ]]
  --[[     -- string | table type ]]
  --[[     quit = "q", ]]
  --[[     exec = "<CR>", ]]
  --[[   }, ]]
  --[[ }, ]]
}

--- In lsp attach function
local map = vim.api.nvim_buf_set_keymap
-- map(0, "n", "gr", "<cmd>Lspsaga rename<cr>", { silent = true, noremap = true })
-- map(0, "n", "<D-.>", "<cmd>Lspsaga code_action<cr>", { silent = true, noremap = true })
-- map(0, "x", "ga", ":<c-u>Lspsaga range_code_action<cr>", { silent = true, noremap = true })
-- map(0, "n", "gh", "<cmd>Lspsaga hover_doc<cr>", { silent = true, noremap = true })
-- map(0, "n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", { silent = true, noremap = true })
-- map(0, "n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", { silent = true, noremap = true })
-- map(0, "n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { silent = true, noremap = true })
-- map(0, "n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
-- map(0, "n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})

-- local diagnostic = require("lspsaga.diagnostic")
local opts = { noremap = true, silent = true }
-- vim.keymap.set('n', '<C-j>', diagnostic.goto_next, opts)
-- vim.keymap.set('n', 'gl', diagnostic.show_diagnostics, opts)
-- vim.keymap.set('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
-- -- vim.keymap.set('i', '<C-k>', '<Cmd>Lspsaga signature_help<CR>', opts)
-- vim.keymap.set('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
-- vim.keymap.set('n', 'gp', '<Cmd>Lspsaga peek_definition<CR>', opts)
vim.keymap.set("n", "<F2>", "<Cmd>Lspsaga rename<CR>", opts)
--
-- -- code action
-- local codeaction = require("lspsaga.codeaction")
-- vim.keymap.set("n", "<D-.>", function() codeaction:code_action() end, { silent = true })
-- vim.keymap.set("v", "<D-.>", function()
--   vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
--   codeaction:range_code_action()
-- end, { silent = true })
vim.keymap.set("n", "<D-.>", "<cmd>Lspsaga code_action<cr>", opts)
