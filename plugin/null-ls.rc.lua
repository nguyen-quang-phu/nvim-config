local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

local ruby_code_actions = require "ruby-code-actions"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local diagnostics = require("null-ls").builtins.diagnostics
local formatting = require("null-ls").builtins.formatting
local code_actions = require("null-ls").builtins.code_actions

local h = require("null-ls.helpers")
local methods = require("null-ls.methods")

local DIAGNOSTICS = methods.internal.DIAGNOSTICS

local offense_to_diagnostic = function(offense)
  local diagnostic = nil

  diagnostic = {
    message = offense.message,
    ruleId = offense.cop_name,
    level = offense.severity,
    line = offense.location.start_line,
    column = offense.location.start_column,
    endLine = offense.location.last_line,
    endColumn = offense.location.last_column,
  }

  if offense.location.start_line ~= offense.location.last_line then
    diagnostic = vim.tbl_extend("force", diagnostic, { endLine = offense.location.start_line, endColumn = 0 })
  end

  return diagnostic
end

local handle_rubocop_output = function(params)
  if params.output and params.output.files then
    local file = params.output.files[1]
    if file and file.offenses then
      local parser = h.diagnostics.from_json({
        severities = {
          info = h.diagnostics.severities.information,
          convention = h.diagnostics.severities.information,
          refactor = h.diagnostics.severities.hint,
          warning = h.diagnostics.severities.warning,
          error = h.diagnostics.severities.error,
          fatal = h.diagnostics.severities.fatal,
        },
      })
      local offenses = {}

      for _, offense in ipairs(file.offenses) do
        table.insert(offenses, offense_to_diagnostic(offense))
      end

      return parser({ output = offenses })
    end
  end

  return {}
end

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format {
    filter = function(client)
      return client.name == "null-ls"
    end,
    bufnr = bufnr,
  }
end

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
  formatting.eslint_d,
  diagnostics.eslint_d.with {
    diagnostics_format = "[eslint] #{m}\n(#{c})",
  },
  -- null_ls.builtins.code_actions.gitsigns,
  -- null_ls.builtins.diagnostics.cspell,
  -- null_ls.builtins.code_actions.cspell,
  -- null_ls.builtins.diagnostics.rubocop,
  -- null_ls.builtins.code_actions.rubocop
  diagnostics.rubocop.with({
    command = "bundle",
    args = vim.list_extend(
      { "exec", "rubocop" },
      null_ls.builtins.diagnostics.rubocop._opts.args
    ),

    diagnostics_format = "[rubocop] #{m}\n(#{c})",
  }),
  --[[ diagnostics.rubocop.with { ]]
  --[[ command = "bundle", ]]
  --[[ args = vim.list_extend({ "exec", "rubocop" }, formatting.rubocop._opts.args), ]]
  --[[   diagnostics_format = "[rubocop] #{m}\n(#{c})", ]]
  --[[ }, ]]
  ruby_code_actions.insert_frozen_string_literal,
  ruby_code_actions.autocorrect_with_rubocop,
  formatting.stylua,
  formatting.rubocop.with {
    command = "bundle",
    args = vim.list_extend({ "exec", "rubocop" }, formatting.rubocop._opts.args),
  },
  --[[ { ]]
  --[[   name = "reek", ]]
  --[[   meta = {}, ]]
  --[[   method = DIAGNOSTICS, ]]
  --[[   filetypes = { "ruby" }, ]]
  --[[   generator_opts = { ]]
  --[[     command = "reek", ]]
  --[[     args = { "-f", "json", "--force-exclusion", "--stdin", "$FILENAME" }, ]]
  --[[     to_stdin = true, ]]
  --[[     format = "json", ]]
  --[[     check_exit_code = function(code) ]]
  --[[       return code <= 1 ]]
  --[[     end, ]]
  --[[     on_output = handle_rubocop_output, ]]
  --[[   }, ]]
  --[[   factory = h.generator_factory, ]]
  --[[ } ]]
}

local on_attach = function(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_buf_create_user_command(bufnr, "LspFormatting", function()
      vim.lsp.buf.format { async = true }
      --[[ vim.lsp.buf.formatting_sync() ]]
    end, {})

    -- you can leave this out if your on_attach is unique to null-ls,
    -- but if you share it with multiple servers, you'll want to keep it
    vim.api.nvim_clear_autocmds {
      group = augroup,
      buffer = bufnr,
    }

    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      command = "undojoin | LspFormatting",
    })
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
