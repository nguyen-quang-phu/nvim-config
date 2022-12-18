require "base"
require "highlights"
require "maps"
require "plugins"
require "neovide"
require "colorscheme"

local has = vim.fn.has
local is_mac = has "macunix"
---@diagnostic disable-next-line: unused-local
local is_win = has "win32"

if is_mac then
  require "macos"
end
