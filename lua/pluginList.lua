local packer = require("packer")
local use = packer.use

-- using { } for using different branch , loading plugin with certain commands etc
return packer.startup(
    function()
        use "wbthomason/packer.nvim"

        -- color related stuff
        use "siduck76/nvim-base16.lua"
        use "norcalli/nvim-colorizer.lua"

        -- lang stuff
        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = function()
                require("treesitter-nvim").config()
            end
        }

        use "neovim/nvim-lspconfig"

        -- load compe in insert mode only
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require("compe-completion").config()
            end
        }

        use "onsails/lspkind-nvim"
        use "sbdchd/neoformat"
        use "nvim-lua/plenary.nvim"
        use "kabouzeid/nvim-lspinstall"
        use "slim-template/vim-slim"
        use {'tpope/vim-dispatch', opt = true, cmd = {'Dispatch', 'Make', 'Focus', 'Start'}}
        use {"vim-ruby/vim-ruby", opt = true, requires = {
          "thoughtbot/vim-rspec", 
          "tpope/vim-dispatch", 
          "tpope/vim-rake", 
          "vim-scripts/ruby-matchit"}}
        use {"tpope/vim-rails", opt = true, requires = {
          "tpope/vim-dispatch", 
          "tpope/vim-abolish"}}
        -- use "mattn/emmet-vim"
        -- use "ap/vim-css-color"
        -- use "digitaltoad/vim-pug"
        -- use "leafgarland/typescript-vim"
        -- use "groenewege/vim-less"
        -- use "mustache/vim-mustache-handlebars"
        -- use "kchmck/vim-coffee-script"
        -- use "tpope/vim-markdown"
        -- use "xsbeats/vim-blade"
        -- use "mxw/vim-xhp"
        -- use "stephpy/vim-php-cs-fixer"
        -- use "arrufat/vala.vim"
        -- use "sophacles/vim-bundle-mako"

        use "lewis6991/gitsigns.nvim"
        use "akinsho/nvim-bufferline.lua"
        use "glepnir/galaxyline.nvim"
        use "mg979/vim-visual-multi"
        use "troydm/zoomwintab.vim"
        use "tpope/vim-unimpaired"
        use "tpope/vim-surround"
        -- use "easymotion/vim-easymotion"

        use {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = function()
                require("nvim-autopairs").setup()
            end
        }
        --   use "alvan/vim-closetag" -- for html

        use "terrortylor/nvim-comment" -- snippet support

        -- snippet
        -- use {
        --     "hrsh7th/vim-vsnip",
        --     event = "InsertCharPre"
        -- }
        -- use "rafamadriz/friendly-snippets"

        -- file managing , picker etc
        use {
            "kyazdani42/nvim-tree.lua",
            cmd = "NvimTreeToggle",
            config = function()
                require("nvimTree").config()
            end
        }

        use "kyazdani42/nvim-web-devicons"
        use "nvim-telescope/telescope.nvim"
        use "nvim-telescope/telescope-media-files.nvim"
        use "nvim-lua/popup.nvim"
        use "kevinhwang91/nvim-bqf"
        use "tpope/vim-fugitive"
        use "junegunn/gv.vim"
        use {"rcarriga/vim-ultest", run = ":UpdateRemotePlugins", requires = {
          "vim-test/vim-test"}}

        -- misc
        use "glepnir/dashboard-nvim"
        use "tweekmonster/startuptime.vim"

        -- load autosave plugin only if its globally enabled
        use {
            "907th/vim-auto-save",
            cond = function()
                return vim.g.auto_save == 1
            end
        }

        -- use "karb94/neoscroll.nvim"
        use "kdav5758/TrueZen.nvim"
        use "folke/which-key.nvim"
        use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
        -- use "majutsushi/tagbar"
        -- use "godlygeek/tabular"
    end,
    {
        display = {
            border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
        }
    }
)
