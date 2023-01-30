--vim.lsp.set_log_level("debug")

local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
  return
end

local protocol = require "vim.lsp.protocol"
local navic = require "nvim-navic"
local cmp = require "cmp"
local ls = require "luasnip"
local s = ls.snippet
local r = ls.restore_node
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node

lspsnips = {}

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
  vim.api.nvim_clear_autocmds { group = augroup_format, buffer = bufnr }
  --[[ vim.api.nvim_create_autocmd("BufWritePre", { ]]
  --[[   group = augroup_format, ]]
  --[[   buffer = bufnr, ]]
  --[[   callback = function() ]]
  --[[     vim.lsp.buf.format() ]]
  --[[   end, ]]
  --[[ }) ]]
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  vim.api.nvim_clear_autocmds { group = augroup_format, buffer = bufnr }
  -- Set auto commands conditional on server_capabilities
  if client.server_capabilities.documentHighlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local orig_rpc_request = client.rpc.request
  function client.rpc.request(method, params, handler, ...)
    local orig_handler = handler
    if method == "textDocument/completion" then
      -- Idiotic take on <https://github.com/fannheyward/coc-pyright/blob/6a091180a076ec80b23d5fc46e4bc27d4e6b59fb/src/index.ts#L90-L107>.
      handler = function(...)
        local err, result = ...
        if not err and result then
          local items = result.items or result
          for _, item in ipairs(items) do
            -- override snippets for kind `field`, matching the snippets for member initializer lists.
            if
              item.kind == vim.lsp.protocol.CompletionItemKind.Field
              and item.textEdit.newText:match "^[%w_]+%(${%d+:[%w_]+}%)$"
            then
              local snip_text = item.textEdit.newText
              local name = snip_text:match "^[%w_]+"
              local type = snip_text:match "%{%d+:([%w_]+)%}"
              -- the snippet is stored in a separate table. It is not stored in the `item` passed to
              -- cmp, because it will be copied there and cmps [copy](https://github.com/hrsh7th/nvim-cmp/blob/ac476e05df2aab9f64cdd70b6eca0300785bb35d/lua/cmp/utils/misc.lua#L125-L143) doesn't account
              -- for self-referential tables and metatables (rightfully so, a response from lsp
              -- would contain neither), both of which are vital for a snippet.
              lspsnips[snip_text] = s("", {
                t(name),
                c(1, {
                  -- use a restoreNode to remember the text typed here.
                  { t "(", r(1, "type", i(1, type)), t ")" },
                  { t "{", r(1, "type"), t "}" },
                }, { restore_cursor = true }),
              })
            end
          end
        end
        return orig_handler(...)
      end
    end
    return orig_rpc_request(method, params, handler, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }
  -- buf_set_keymap('n', '<D-.>', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

protocol.CompletionItemKind = {
  "", -- Text
  "", -- Method
  "", -- Function
  "", -- Constructor
  "", -- Field
  "", -- Variable
  "", -- Class
  "ﰮ", -- Interface
  "", -- Module
  "", -- Property
  "", -- Unit
  "", -- Value
  "", -- Enum
  "", -- Keyword
  "﬌", -- Snippet
  "", -- Color
  "", -- File
  "", -- Reference
  "", -- Folder
  "", -- EnumMember
  "", -- Constant
  "", -- Struct
  "", -- Event
  "ﬦ", -- Operator
  "", -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

nvim_lsp.flow.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities,
}

nvim_lsp.sourcekit.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.sumneko_lua.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    enable_format_on_save(client, bufnr)
  end,
  settings = {

    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  },
}

nvim_lsp.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.astro.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.solargraph.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    solargraph = {
      diagnostics = false,
    },
  },
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config {
  virtual_text = {
    prefix = "●",
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
}

cmp.setup.snippet = {
  expand = function(args)
    -- check if we created a snippet for this lsp-snippet.
    if lspsnips[args.body] then
      -- use `snip_expand` to expand the snippet at the cursor position.
      require("luasnip").snip_expand(lspsnips[args.body])
    else
      require("luasnip").lsp_expand(args.body)
    end
  end,
}
-- vim.cmd([[ autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
