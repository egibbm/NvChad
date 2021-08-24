local present, packer = pcall(require, "plugins.packerInit")

if not present then
   return false
end

local use = packer.use

return packer.startup(function()
   local plugin_status = require("core.utils").load_config().plugin_status

   -- this is arranged on the basis of when a plugin starts

   -- this is the nvchad core repo containing utilities for some features like theme swticher, no need to lazy load
   use {
      "Nvchad/core",
   }

   use {
      "wbthomason/packer.nvim",
      event = "VimEnter",
   }

   use {
      "NvChad/nvim-base16.lua",
      after = "packer.nvim",
      config = function()
         require("colors").init()
      end,
   }

   use {
      "kyazdani42/nvim-web-devicons",
      after = "nvim-base16.lua",
      config = function()
         require "plugins.configs.icons"
      end,
   }

   use {
      "glepnir/galaxyline.nvim",
      disable = not plugin_status.galaxyline,
      after = "nvim-web-devicons",
      config = function()
         require "plugins.configs.statusline"
      end,
   }

   use {
      "akinsho/bufferline.nvim",
      disable = not plugin_status.bufferline,
      after = "galaxyline.nvim",
      config = function()
         require "plugins.configs.bufferline"
      end,
      setup = function()
         require("core.mappings").bufferline()
      end,
   }

   use {
      "nvim-lua/plenary.nvim",
      after = "bufferline.nvim",
   }

   -- git stuff
   use {
      "lewis6991/gitsigns.nvim",
      disable = not plugin_status.gitsigns,
      after = "plenary.nvim",
      config = function()
         require "plugins.configs.gitsigns"
      end,
   }

   use {
      "nvim-telescope/telescope.nvim",
      after = "plenary.nvim",
      requires = {
         {
            "sudormrfbin/cheatsheet.nvim",
            disable = not plugin_status.cheatsheet,
            after = "telescope.nvim",
            config = function()
               require "plugins.configs.chadsheet"
            end,
            setup = function()
               require("core.mappings").chadsheet()
            end,
         },
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
         },
         {
            "nvim-telescope/telescope-media-files.nvim",
            disable = not plugin_status.telescope_media,
            setup = function()
               require("core.mappings").telescope_media()
            end,
         },
      },
      config = function()
         require "plugins.configs.telescope"
      end,
      setup = function()
         require("core.mappings").telescope()
      end,
   }

   -- load autosave only if its globally enabled
   use {
      disable = not plugin_status.autosave,
      "Pocco81/AutoSave.nvim",
      config = function()
         require "plugins.configs.autosave"
      end,
      cond = function()
         return require("core.utils").load_config().options.plugin.autosave == true
      end,
   }

   use {
      "lukas-reineke/indent-blankline.nvim",
      disable = not plugin_status.blankline,
      event = "BufRead",
      config = function()
         require("plugins.configs.others").blankline()
      end,
   }

   use {
      "norcalli/nvim-colorizer.lua",
      disable = not plugin_status.colorizer,
      event = "BufRead",
      config = function()
         require("plugins.configs.others").colorizer()
      end,
   }

   -- lsp stuff
   use {
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      config = function()
         require "plugins.configs.treesitter"
      end,
   }

   use {
      "kabouzeid/nvim-lspinstall",
      event = "BufRead",
   }

   use {
      "neovim/nvim-lspconfig",
      after = "nvim-lspinstall",
      config = function()
         require "plugins.configs.lspconfig"
      end,
   }

   use {
      "ray-x/lsp_signature.nvim",
      disable = not plugin_status.lspsignature,
      after = "nvim-lspconfig",
      config = function()
         require("plugins.configs.others").signature()
      end,
   }

   use {
      "onsails/lspkind-nvim",
      disable = not plugin_status.lspkind,
      event = "BufEnter",
      config = function()
         require("plugins.configs.others").lspkind()
      end,
   }

   use {
      "jdhao/better-escape.vim",
      disable = not plugin_status.esc_insertmode,
      event = "InsertEnter",
      config = function()
         require("plugins.configs.others").better_escape()
      end,
      setup = function()
         require("core.mappings").better_escape()
      end,
   }

   -- load compe in insert mode only
   use {
      "hrsh7th/nvim-compe",
      event = "InsertEnter",
      config = function()
         require "plugins.configs.compe"
      end,
      setup = function()
         require("core.mappings").compe()
      end,
      wants = "LuaSnip",
      requires = {
         {
            "L3MON4D3/LuaSnip",
            wants = "friendly-snippets",
            event = "InsertCharPre",
            config = function()
               require "plugins.configs.luasnip"
            end,
         },
         {
            "rafamadriz/friendly-snippets",
            event = "InsertCharPre",
         },
      },
   }

   -- misc plugins
   use {
      "windwp/nvim-autopairs",
      after = "nvim-compe",
      config = function()
         require "plugins.configs.autopairs"
      end,
   }

   use {
      "andymass/vim-matchup",
      disable = not plugin_status.vim_matchup,
      event = "CursorMoved",
   }

   -- smooth scroll
   use {
      "karb94/neoscroll.nvim",
      disable = not plugin_status.neoscroll,
      event = "WinScrolled",
      config = function()
         require("plugins.configs.others").neoscroll()
      end,
   }

   use {
      "glepnir/dashboard-nvim",
      disable = not plugin_status.dashboard,
      cmd = {
         "Dashboard",
         "DashboardNewFile",
         "DashboardJumpMarks",
         "SessionLoad",
         "SessionSave",
      },
      config = function()
         require "plugins.configs.dashboard"
      end,
      setup = function()
         require("core.mappings").dashboard()
      end,
   }

   use {
      "sbdchd/neoformat",
      disable = not plugin_status.neoformat,
      cmd = "Neoformat",
      setup = function()
         require("core.mappings").neoformat()
      end,
   }

   --   use "alvan/vim-closetag" -- for html autoclosing tag
   use {
      "terrortylor/nvim-comment",
      disable = not plugin_status.comment,
      cmd = "CommentToggle",
      config = function()
         require("plugins.configs.others").comment()
      end,
      setup = function()
         require("core.mappings").comment()
      end,
   }

   -- file managing , picker etc
   use {
      "kyazdani42/nvim-tree.lua",
      cmd = "NvimTreeToggle",
      config = function()
         require "plugins.configs.nvimtree"
      end,
      setup = function()
         require("core.mappings").nvimtree()
      end,
   }

   use {
      "Pocco81/TrueZen.nvim",
      disable = not plugin_status.truezen,
      cmd = {
         "TZAtaraxis",
         "TZMinimalist",
         "TZFocus",
      },
      config = function()
         require "plugins.configs.zenmode"
      end,
      setup = function()
         require("core.mappings").truezen()
      end,
   }

   use {
      "tpope/vim-fugitive",
      disable = not plugin_status.vim_fugitive,
      cmd = {
         "Git",
      },
      setup = function()
         require("core.mappings").vim_fugitive()
      end,
   }

   use {
      "kevinhwang91/nvim-bqf",
      event = "BufRead",
      config = function()
         require("plugins.configs.bqf-nvim").config()
      end
   }

   use "junegunn/gv.vim"
   use {
      "rcarriga/vim-ultest",
      run = ":UpdateRemotePlugins",
      requires = {
         {
            "vim-test/vim-test",
            setup = function()
               require("core.mappings").vim_test()
            end
         }
      }
   }

   -- use "majutsushi/tagbar"
   -- use "godlygeek/tabular"
   -- use "alvan/vim-closetag" -- for html autoclosing tag

   use {"slim-template/vim-slim", ft='slim'}
   use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
   use {
      "vim-ruby/vim-ruby",
      opt = true,
      ft = 'ruby',
      requires = {
         "thoughtbot/vim-rspec",
         "tpope/vim-dispatch",
         "tpope/vim-rake",
         "vim-scripts/ruby-matchit"
      }
   }

   use {
      "tpope/vim-rails",
      opt = true,
      ft = 'ruby',
      requires = {
         "vim-ruby/vim-ruby",
         "tpope/vim-dispatch",
         "tpope/vim-abolish"
      },
      config = function()
         require "plugins.configs.rails"
      end,
      setup = function()
         require("core.mappings").rails()
      end,
   }

   use {"mfukar/robotframework-vim", ft = 'robot'}
   use {"mMontu/vim-RobotUtils", ft = 'robot'}

   -- use "mattn/emmet-vim"
   -- use "ap/vim-css-color"           <-- supported by treesitter(?)
   -- use "digitaltoad/vim-pug"
   -- use "leafgarland/typescript-vim" <-- supported by treesitter
   -- use "groenewege/vim-less"
   -- use "mustache/vim-mustache-handlebars"
   -- use "kchmck/vim-coffee-script"
   -- use "tpope/vim-markdown"
   -- use "xsbeats/vim-blade"
   -- use "mxw/vim-xhp"
   -- use "stephpy/vim-php-cs-fixer"
   -- use "arrufat/vala.vim"
   -- use "sophacles/vim-bundle-mako"

   use "mg979/vim-visual-multi"
   use "troydm/zoomwintab.vim"
   use "tpope/vim-unimpaired"
   use "tpope/vim-surround"
   use "tpope/vim-repeat"
   -- use "easymotion/vim-easymotion"

   use {
     "cappyzawa/trim.nvim",
     setup = function()
       disable = { "markdown" }
     end
   }
end)
