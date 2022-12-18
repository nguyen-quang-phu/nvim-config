vim.o.background = 'dark'
local status, vscode = pcall(require, "vscode")
local colorStatus, vscodeColor = pcall(require, "vscode.colors")
if (not status) then return end
if (not colorStatus) then return end

local c = require('vscode.colors')
vscode.setup({
  -- Enable transparent background
  transparent = true,

  -- Enable italic comment
  italic_comments = true,

  -- Disable nvim-tree background color
  disable_nvimtree_bg = true,

  -- Override colors (see ./lua/vscode/colors.lua)
  color_overrides = {
    vscLineNumber = '#FFFFFF',
  },

  -- Override highlight groups (see ./lua/vscode/theme.lua)
  group_overrides = {
    -- this supports the same val table as vim.api.nvim_set_hl
    -- use colors from this colorscheme by requiring vscode.colors!
    Cursor = { fg = vscodeColor.vscDarkBlue, bg = vscodeColor.vscLightGreen, bold = true },
  }
})
