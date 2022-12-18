local status, vgit = pcall(require, "vgit")
if (not status) then return end

vgit.setup({
  keymaps={
    ['n <D-k>'] = function() require('vgit').hunk_up() end,
    ['n <D-j>'] = function() require('vgit').hunk_down() end,
  },
  settings = {
    live_blame = {
      enabled = true
    },
    scene = {
      diff_preference = 'split'
    }
  }
})


local keymap = vim.api.nvim_set_keymap

local default_opts = { noremap = true, silent = true }

keymap('n', '<S-D-g>', ':VGit project_diff_preview<cr>', default_opts)
