local status, filetype = pcall(require, "filetype")
if (not status) then return end

filetype.setup({
  overrides = {
    extensions = {
      yml = "yaml"
    }
  }
})
