local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
   augroup packer_user_config
   autocmd!
   autocmd BufWritePost plugins.lua source <afile> | PackerSync
   augroup end
 ]]

local status, packer = pcall(require, "packer")
if not status then
  print "Packer is not installed"
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- LSP
  use {
    "neovim/nvim-lspconfig",
    requires = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Additional lua configuration, makes nvim stuff amazing
      "folke/neodev.nvim",
    },
  }

  -- Colorschemes
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "lunarvim/darkplus.nvim"
  -- use 'flazz/vim-colorschemes'

  -- Completion
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-path"
  use { "hrsh7th/nvim-cmp", requires = { "onsails/lspkind-nvim" } }
  use "saadparwaiz1/cmp_luasnip"

  -- snippets
  use { "L3MON4D3/LuaSnip", run = "make install_jsregexp" } --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- utils
  use {
    "folke/which-key.nvim",
    config = function()
      require("config.whichkey").setup()
    end,
  } -- pop up key board
  use {
    "kyazdani42/nvim-tree.lua",
    requires = {
      "kyazdani42/nvim-web-devicons",
    },
  } -- structure file
  use { "nvim-lualine/lualine.nvim", requires = { "SmiteshP/nvim-gps" } } -- Statusline
  use "lukas-reineke/indent-blankline.nvim" -- Add indentation guides even on blank lines
  use { "numToStr/Comment.nvim", requires = { "JoosepAlviste/nvim-ts-context-commentstring" } } -- "gc" to comment visual regions/lines
  use "jayp0521/mason-null-ls.nvim"
  use "jose-elias-alvarez/null-ls.nvim" -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua

  -- use { 'glepnir/lspsaga.nvim', branch = "main" } -- LSP UIs
  use { "kkharji/lspsaga.nvim" }
  use {
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update { with_sync = true }
    end,
    requires = {
      "nvim-treesitter/playground",
    },
  }
  use { -- Additional text objects via treesitter
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  }
  use "kyazdani42/nvim-web-devicons" -- File icons

  -- Telescope
  use {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    -- or                            , branch = '0.1.x',
    requires = { { "nvim-lua/plenary.nvim" } },
  }
  -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable "make" == 1 }
  use "nvim-telescope/telescope-file-browser.nvim"

  -- Show current code context (method name, etc.)
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
  }

  -- Nice looking modal notifications that fade away
  -- use {
  --   'rcarriga/nvim-notify',
  --   config = function()
  --     require("notify").setup({
  --       background_colour = "#000000",
  --     })
  --   end
  -- }
  --
  -- -- LSP server notifications using nvim-notify
  -- use {
  --   'mrded/nvim-lsp-notify',
  --   config = function()
  --     require('lsp-notify').setup({
  --       notify = require('notify')
  --     })
  --   end
  -- }

  use {
    "danielfalk/smart-open.nvim",
    requires = { "tami5/sqlite.lua" },
    config = function()
      require("telescope").load_extension "smart_open"
    end,
  }
  use "windwp/nvim-autopairs"
  use "windwp/nvim-ts-autotag"
  use "norcalli/nvim-colorizer.lua"
  use "folke/zen-mode.nvim"
  use {
    "iamcco/markdown-preview.nvim",
    run = function()
      vim.fn["mkdp#util#install"]()
    end,
  }
  use "akinsho/nvim-bufferline.lua"
  -- use 'github/copilot.vim'

  use "tpope/vim-fugitive"
  use "tpope/vim-rhubarb"
  use "lewis6991/gitsigns.nvim"
  use { "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }
  -- use 'dinhhuy258/git.nvim' -- For git blame & browse
  use "kevinhwang91/nvim-bqf"
  use "vim-scripts/ReplaceWithRegister"
  use {
    "kana/vim-textobj-entire",
    requires = { "kana/vim-textobj-user" },
  }
  use "tpope/vim-surround"
  use "tpope/vim-rails"
  use "tpope/vim-rbenv"
  use "vim-ruby/vim-ruby"

  -- auto save
  --[[ use "Pocco81/auto-save.nvim" ]]
  use "tpope/vim-repeat"
  use "semanticart/ruby-code-actions.nvim"
  use "wellle/targets.vim"
  use "michaeljsmith/vim-indent-object"
  use "nelstrom/vim-textobj-rubyblock"
  use "https://github.com/whatyouhide/vim-textobj-erb"
  use "mattn/emmet-vim"
  use "dcampos/cmp-emmet-vim"
  use "tpope/vim-endwise"
  use "tpope/vim-bundler"
  use "thoughtbot/vim-rspec"
  use "machakann/vim-textobj-delimited"
  use "slim-template/vim-slim"
  use {
    "tanvirtin/vgit.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }
  use "ludovicchabant/vim-gutentags"
  use "webastien/vim-ctags"
  use "ThePrimeagen/refactoring.nvim"
  -- use { "akinsho/toggleterm.nvim", tag = '*', config = function()
  --   require("toggleterm").setup()
  -- end }

  use "takac/vim-hardtime"

  use "NvChad/base46"
  use {
    "NvChad/ui",
    after = "base46",
  }
  use "NvChad/nvterm"

  use "nathom/filetype.nvim"
  use "easymotion/vim-easymotion"

  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  use "AndrewRadev/rails_extra.vim"
  use "AndrewRadev/splitjoin.vim"
  use "AndrewRadev/rtranslate.vim"
  use "AndrewRadev/exercism.vim"
  use "AndrewRadev/switch.vim"
  use "aperezdc/vim-template"
  use { "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
