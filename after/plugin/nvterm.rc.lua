local status, nvterm = pcall(require, "nvterm")
if (not status) then return end

nvterm.setup({})

vim.keymap.set('n', '<D-`>', function()
  require("nvterm.terminal").toggle "float"
end, { silent = true })


vim.keymap.set('t', '<D-`>', function()
  require("nvterm.terminal").toggle "float"
end, { silent = true })
