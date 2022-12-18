local status, mason_null_ls = pcall(require, "mason-null-ls")
if (not status) then return end

mason_null_ls.setup({
  ensure_installed = { "rubocop" }
})
