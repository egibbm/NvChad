local packer = require("packer")
local use = packer.use

return packer.startup(
    function()
        use "wbthomason/packer.nvim"

        use "akinsho/nvim-bufferline.lua"
        use "glepnir/galaxyline.nvim"

        -- color related stuff
        use "siduck76/nvim-base16.lua"

        use {
            "norcalli/nvim-colorizer.lua",
            event = "BufRead",
            config = function()
                require("colorizer").setup()
                vim.cmd("ColorizerReloadAllBuffers")
            end
        }

        -- language related plugins
        use {
            "nvim-treesitter/nvim-treesitter",
            event = "BufRead",
            config = function()
                require("treesitter-nvim").config()
            end
        }

        use {
            "neovim/nvim-lspconfig",
            event = "BufRead",
            config = function()
                require("nvim-lspconfig").config()
            end
        }

        use "kabouzeid/nvim-lspinstall"

        use {
            "onsails/lspkind-nvim",
            event = "BufRead",
            config = function()
                require("lspkind").init()
            end
        }

        -- load compe in insert mode only
        use {
            "hrsh7th/nvim-compe",
            event = "InsertEnter",
            config = function()
                require("compe-completion").config()
            end,
            wants = {"LuaSnip"},
            requires = {
                {
                    "L3MON4D3/LuaSnip",
                    wants = "friendly-snippets",
                    event = "InsertCharPre",
                    config = function()
                        require("compe-completion").snippets()
                    end
                },
                "rafamadriz/friendly-snippets"
            }
        }

        use {"sbdchd/neoformat", cmd = "Neoformat"}

        -- file managing , picker etc
        use {
            "kyazdani42/nvim-tree.lua",
            cmd = {"NvimTreeToggle", "NvimTreeFindFile"},
            config = function()
                require("nvimTree").config()
            end
        }

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
        use "mfukar/robotframework-vim"
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

        use "mg979/vim-visual-multi"
        use "troydm/zoomwintab.vim"
        use "tpope/vim-unimpaired"
        use "tpope/vim-surround"
        -- use "easymotion/vim-easymotion"

        use "kyazdani42/nvim-web-devicons"
        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim"},
                {"nvim-lua/plenary.nvim"},
                {"nvim-telescope/telescope-fzf-native.nvim", run = "make"},
                {"nvim-telescope/telescope-media-files.nvim"}
            },
            cmd = "Telescope",
            config = function()
                require("telescope-nvim").config()
            end
        }

        -- git stuff
        use {
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = function()
                require("gitsigns-nvim").config()
            end
        }

        -- misc plugins
        use {
            "windwp/nvim-autopairs",
            event = "InsertEnter",
            config = function()
                require("nvim-autopairs").setup()
            end
        }

        use {"andymass/vim-matchup", event = "CursorMoved"}

        use {
            "terrortylor/nvim-comment",
            cmd = "CommentToggle",
            config = function()
                require("nvim_comment").setup()
            end
        }

        use {
            "glepnir/dashboard-nvim",
            cmd = {
                "Dashboard",
                "DashboardNewFile",
                "DashboardJumpMarks",
                "SessionLoad",
                "SessionSave"
            },
            setup = function()
                require("dashboard").config()
            end
        }

        use "kevinhwang91/nvim-bqf"
        use "tpope/vim-fugitive"
        use "junegunn/gv.vim"
        use {"rcarriga/vim-ultest", run = ":UpdateRemotePlugins", requires = {
          "vim-test/vim-test"}}

        use {"tweekmonster/startuptime.vim", cmd = "StartupTime"}

        -- load autosave only if its globally enabled
        use {
            "907th/vim-auto-save",
            cond = function()
                return vim.g.auto_save == 1
            end
        }

        -- -- smooth scroll
        -- use {
        --     "karb94/neoscroll.nvim",
        --     event = "WinScrolled",
        --     config = function()
        --         require("neoscroll").setup()
        --     end
        -- }

        use {
            "Pocco81/TrueZen.nvim",
            cmd = {"TZAtaraxis", "TZMinimalist"},
            config = function()
                require("zenmode").config()
            end
        }

        -- use "majutsushi/tagbar"
        -- use "godlygeek/tabular"

        --   use "alvan/vim-closetag" -- for html autoclosing tag

        use {
            "lukas-reineke/indent-blankline.nvim",
            branch = "lua",
            event = "BufRead",
            setup = function()
                require("misc-utils").blankline()
            end
        }
    end,
    {
        display = {
            border = {"┌", "─", "┐", "│", "┘", "─", "└", "│"}
        }
    }
)
