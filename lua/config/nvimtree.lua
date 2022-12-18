local status, nvimtree = pcall(require, "nvim-tree")
if (not status) then return end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvimtree.setup {
  disable_netrw = true,
  hijack_netrw = true,
  view = {
    number = true,
    relativenumber = true,
    mappings = {
      custom_only = false,
      list = {
        { key = "n", action = "create" }
      }
    }
  },
  filters = {
    dotfiles = false,
    custom = { ".git" },
  },
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<D-b>', '<cmd>NvimTreeToggle<cr>', opts)
vim.keymap.set('n', '<S-D-e>', '<cmd>NvimTreeFocus<cr>', opts)
