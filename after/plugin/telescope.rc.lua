local status, telescope = pcall(require, "telescope")
if not status then
  return
end
local actions = require "telescope.actions"
local action_set = require "telescope.actions.set"
local builtin = require "telescope.builtin"

local function telescope_buffer_dir()
  return vim.fn.expand "%:p:h"
end

local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup {
  pickers = {
    current_buffer_fuzzy_find = { sorting_strategy = "ascending" },
    find_files = {
      hidden = true,
      attach_mappings = function(_)
        action_set.select:enhance {
          post = function()
            vim.cmd ":normal! zx"
          end,
        }
        return true
      end,
    },
  },
  defaults = {
    ripgrep_arguments = {
      "rg",
      "--hidden",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
    file_ignore_patterns = { "node_modules", "vendor", ".history", ".git", "tags", ".tags", "tmp", "log", "dist" },
    mappings = {
      n = {
        ["<ESC>"] = actions.close,
      },
      i = {
        ["<esc>"] = actions.close,
      },
    },
    previewer = false,
    prompt_prefix = "⦕ ",
    selection_caret = "⪢ ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    file_sorter = require("telescope.sorters").get_generic_sorter,
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    border = {},
    borderchars = {
      "─",
      "│",
      "─",
      "│",
      "╭",
      "╮",
      "╯",
      "╰",
    },
    color_devicons = true,
    use_less = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function()
            vim.cmd "normal vbd"
          end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["/"] = function()
            vim.cmd "startinsert"
          end,
        },
      },
    },
    -- fzf = {
    --   fuzzy = true,
    --   override_generic_sorter = true, -- override the generic sorter
    --   override_file_sorter = true, -- override the file sorter
    --   case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    -- },
  },
}

telescope.load_extension "file_browser"
telescope.load_extension "fzf"

vim.keymap.set("n", "<D-p>", function()
  builtin.find_files {
    no_ignore = true,
    hidden = true,
  }
end)
vim.keymap.set("n", "<S-D-f>", function()
  builtin.live_grep()
end)
vim.keymap.set("n", "\\\\", function()
  builtin.buffers()
end)
vim.keymap.set("n", ";t", function()
  builtin.help_tags()
end)
vim.keymap.set("n", ";;", function()
  builtin.resume()
end)
vim.keymap.set("n", ";e", function()
  builtin.diagnostics()
end)
vim.keymap.set("n", "sf", function()
  telescope.extensions.file_browser.file_browser {
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = true,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 },
  }
end)
