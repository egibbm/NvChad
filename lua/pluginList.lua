local packer = require("packer")
local use = packer.use

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {border = "single"}
        end
    },
    git = {
        clone_timeout = 600 -- Timeout, in seconds, for git clones
    }
}

return packer.startup(
    function()
        use "wbthomason/packer.nvim"

        use "akinsho/nvim-bufferline.lua"

        use {
            "glepnir/galaxyline.nvim",
            config = function()
                require("plugins.statusline").config()
            end
        }

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
                require("plugins.treesitter").config()
            end
        }

        use {
            "kabouzeid/nvim-lspinstall",
            event = "BufRead"
        }

        use {
            "neovim/nvim-lspconfig",
            after = "nvim-lspinstall",
            config = function()
                require("plugins.lspconfig").config()
            end
        }

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
                require("plugins.compe").config()
            end,
            wants = {"LuaSnip"},
            requires = {
                {
                    "L3MON4D3/LuaSnip",
                    wants = "friendly-snippets",
                    event = "InsertCharPre",
                    config = function()
                        require("plugins.compe").snippets()
                    end
                },
                {
                    "rafamadriz/friendly-snippets",
                    event = "InsertCharPre"
                }
            }
        }

        use {"sbdchd/neoformat", cmd = "Neoformat"}

        -- file managing , picker etc
        use {
            "kyazdani42/nvim-tree.lua",
            config = function()
                require("plugins.nvimtree").config()
            end
        }

        use {
            "kyazdani42/nvim-web-devicons",
            config = function()
                require("plugins.icons").config()
            end
        }

        use "slim-template/vim-slim"
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
          }
        }

        use {"mfukar/robotframework-vim", ft = 'robot'}
        use {"mMontu/vim-RobotUtils", ft = 'robot'}

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
        use "tpope/vim-repeat"
        -- use "easymotion/vim-easymotion"

        use {
            "nvim-telescope/telescope.nvim",
            requires = {
                {"nvim-lua/popup.nvim"},
                {"nvim-telescope/telescope-media-files.nvim"},
                {"nvim-lua/plenary.nvim"}
            },
            cmd = "Telescope",
            config = function()
                require("plugins.telescope").config()
            end
        }

        use {"nvim-telescope/telescope-fzf-native.nvim", run = "make", cmd = "Telescope"}

        -- use {
        --     "nvim-telescope/telescope-media-files.nvim",
        --     cmd = "Telescope"
        -- }

        -- git stuff
        use {
            "lewis6991/gitsigns.nvim",
            event = "BufRead",
            config = function()
                require("plugins.gitsigns").config()
            end
        }

        -- misc plugins
        use {
            "windwp/nvim-autopairs",
            after = "nvim-compe",
            config = function()
                require("nvim-autopairs").setup()
                require("nvim-autopairs.completion.compe").setup(
                    {
                        map_cr = true,
                        map_complete = true -- insert () func completion
                    }
                )
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
                require("plugins.dashboard").config()
            end
        }

        use {
          "kevinhwang91/nvim-bqf",
          event = "BufRead",
          config = function()
            require("bqf-nvim").config()
          end
        }

        use "tpope/vim-fugitive"
        use "junegunn/gv.vim"
        use {
          "rcarriga/vim-ultest", 
          run = ":UpdateRemotePlugins",
          requires = {
            "vim-test/vim-test"
          }
        }

        use {"tweekmonster/startuptime.vim", cmd = "StartupTime"}

        -- load autosave only if its globally enabled
        use {
            "Pocco81/AutoSave.nvim",
            config = function()
                require("plugins.zenmode").autoSave()
            end,
            cond = function()
                return vim.g.auto_save == true
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
            cmd = {"TZAtaraxis", "TZMinimalist", "TZFocus"},
            config = function()
                require("plugins.zenmode").config()
            end
        }

        -- use "majutsushi/tagbar"
        -- use "godlygeek/tabular"

        --   use "alvan/vim-closetag" -- for html autoclosing tag

        use {
            "lukas-reineke/indent-blankline.nvim",
            event = "BufRead",
            setup = function()
                require("utils").blankline()
            end
        }
    end
)
