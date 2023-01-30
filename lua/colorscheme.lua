local colorscheme = "darkplus"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

--[[ vim.api.nvim_set_hl(0, "Comment", { ctermbg = #6a9955, guibg = lightgrey }) ]]
