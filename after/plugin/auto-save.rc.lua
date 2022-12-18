local status, autosave = pcall(require, "auto-save")
if not status then
  return
end

autosave.setup {
  enabled = false,
  write_all_buffers = true,
}
