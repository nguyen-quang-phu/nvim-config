local status, nvimtree = pcall(require, "nvim-tree")
if not status then
  return
end

nvimtree.setup {
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  ignore_ft_on_setup = {},
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
  update_focused_file = {
    enable = true,
    update_cwd = true,
    ignore_list = {},
  },
  system_open = {
    cmd = nil,
    args = {},
  },
  view = {
    number = true,
    relativenumber = true,
    mappings = {
      custom_only = false,
      list = {
        { key = "n", action = "create" },
      },
    },
  },
  filters = {
    dotfiles = false,
    custom = { ".git" },
  },
  git = {
    ignore = false,
  },
}

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<D-b>", "<cmd>NvimTreeToggle<cr>", opts)
vim.keymap.set("n", "<S-D-e>", "<cmd>NvimTreeFindFile<cr>", opts)
