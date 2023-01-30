local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

local ruby_code_actions = require "ruby-code-actions"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local diagnostics = require("null-ls").builtins.diagnostics
local formatting = require("null-ls").builtins.formatting
local code_actions = require("null-ls").builtins.code_actions

local conditional = function(fn)
  local utils = require("null-ls.utils").make_conditional_utils()
  return fn(utils)
end

local sources = {
  -- check spell
  diagnostics.cspell.with {
    diagnostics_format = "[cspell] #{m}\n(#{c})",
  },
  code_actions.cspell,

  -- eslint
  code_actions.eslint_d,
  formatting.prettierd,
  diagnostics.eslint_d.with {
    diagnostics_format = "[eslint] #{m}\n(#{c})",
  },
  -- null_ls.builtins.code_actions.gitsigns,
  -- null_ls.builtins.diagnostics.cspell,
  -- null_ls.builtins.code_actions.cspell,
  -- null_ls.builtins.diagnostics.rubocop,
  -- null_ls.builtins.code_actions.rubocop
  formatting.rubocop,
  diagnostics.rubocop.with {
    diagnostics_format = "[rubocop] #{m}\n(#{c})",
  },
  ruby_code_actions.insert_frozen_string_literal,
  ruby_code_actions.autocorrect_with_rubocop,
  formatting.stylua,
  -- formatting.rubocop.with {
  --   command = 'bundle',
  --   args = vim.list_extend({ 'exec', 'rubocop' }, formatting.rubocop._opts.args),
  -- },
}

local on_attach = function(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_buf_create_user_command(bufnr, "LspFormatting", function(bufnr)
      vim.lsp.buf.format {
        filter = function(client)
          return client.name == "null-ls"
        end,
        bufnr = bufnr,
      }
    end, {})

    vim.api.nvim_clear_autocmds {
      group = augroup,
      buffer = bufnr,
    }

    --[[ vim.api.nvim_create_autocmd("BufWritePre", { ]]
    --[[   group = augroup, ]]
    --[[   buffer = bufnr, ]]
    --[[   command = "undojoin | LspFormatting", ]]
    --[[ }) ]]
  end
end
null_ls.setup {
  debug = true,
  sources = sources,
  on_attach = on_attach,
}

vim.api.nvim_create_user_command("DisableLspFormatting", function()
  vim.api.nvim_clear_autocmds { group = augroup, buffer = 0 }
end, { nargs = 0 })
