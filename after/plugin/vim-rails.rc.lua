local status, vimrails = pcall(require, "vim-rails")
if (not status) then return end

vimrails.setup({})
