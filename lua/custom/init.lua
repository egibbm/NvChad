-- This is where you custom modules and plugins goes.
-- See the wiki for a guide on how to extend NvChad

local hooks = require "core.hooks"

-- NOTE: To use this, make a copy with `cp example_init.lua init.lua`

--------------------------------------------------------------------

-- To modify packaged plugin configs, use the overrides functionality
-- if the override does not exist in the plugin config, make or request a PR,
-- or you can override the whole plugin config with 'chadrc' -> M.plugins.default_plugin_config_replace{}
-- this will run your config instead of the NvChad config for the given plugin

-- hooks.override("lsp", "publish_diagnostics", function(current)
--   current.virtual_text = false;
--   return current;
-- end)

-- To add new mappings, use the "setup_mappings" hook,
-- you can set one or many mappings
-- example below:

hooks.add("setup_mappings", function(map)
   -- easy wrap toggling
   map("n", "<Leader>w", ":set wrap!<cr>", opt)
   map("n", "<Leader>W", ":set nowrap<cr>", opt)

   -- close all other windows (in the current tab)
   map("n", "gW", ":only<cr>", opt)

   -- delete all buffers
   map("", "<Leader>d", ":bufdo bd<cr>", opt)

   -- insert blank lines without going into insert mode
   map("n", "go", "o<esc>", opt)
   map("n", "gO", "O<esc>", opt)

   -- mapping the jumping between splits. Hold control while using vim nav.
   map("n", "<C-J>", "<C-W>j", opt)
   map("n", "<C-K>", "<C-W>k", opt)
   map("n", "<C-H>", "<C-W>h", opt)
   map("n", "<C-L>", "<C-W>l", opt)

   -- Yank from the cursor to the end of the line, to be consistent with C and D.
   map("n", "Y", "y$", opt)

   -- select the lines which were just pasted
   map("n", "vv", "`[V`]", opt)

   -- clean up trailing whitespace
   map("", "<Leader>c", ":lua require('trim.trimmer').trim()<cr>", opt)

   -- compress excess whitespace on current line
   map("", "<Leader>e", ":s/\\v(\\S+)\\s+/\\1 /<cr>:nohl<cr>", opt)

   -- buffer resizing mappings (shift + arrow key)
   map("n", "<S-Up>", "<c-w>+", opt)
   map("n", "<S-Down>", "<c-w>-", opt)
   map("n", "<S-Left>", "<c-w><<c-w><<c-w><", opt)
   map("n", "<S-Right>", "<c-w>><c-w>><c-w>>", opt)

   -- reindent the entire file
   map("n", "<Leader>I", "gg=G``<cr>", opt)

   -- insert the path of currently edited file into a command
   -- Command mode: Ctrl-P
   map("c", "<C-S-P>", '<C-R>=expand("%:p:h") . "/" <cr>', opt)

   -- Tricks
   map("", "n", "nzz", opt)
   map("", "N", "Nzz", opt)
   map("", "<C-o>", "<C-o>zz", opt)
   map("", "<C-i>", "<C-i>zz", opt)

   -- PHP
   -- map("i", "<C-l>", "->", opt)
   -- map("i", "<C-k>", "=>", opt)

   -- CTRL-X and SHIFT-Del are Cut
   map("v", "<C-X>", '"+x', opt)
   map("v", "<S-Del>", '"+x', opt)

   -- CTRL-C and CTRL-Insert are Copy
   map("v", "<C-C>", '"+y', opt)
   map("v", "<C-Insert>", '"+y', opt)

   -- CTRL-V and SHIFT-Insert are Paste
   map("",  "<S-Insert>", '"+gP', opt)
   map("i", "<S-Insert>", '<Esc>"+gP', opt)
   map("c", "<S-Insert>", "<C-R>+", opt)

   -- Navigation for tab
   map("", "<Leader>1", "1gt", opt)
   map("", "<Leader>2", "2gt", opt)
   map("", "<Leader>3", "3gt", opt)
   map("", "<Leader>4", "4gt", opt)
   map("", "<Leader>5", "5gt", opt)
   map("", "<Leader>6", "6gt", opt)
   map("", "<Leader>7", "7gt", opt)
   map("", "<Leader>8", "8gt", opt)
   map("", "<Leader>9", "9gt", opt)
   map("", "<Leader>0", ":tablast<cr>", opt)
end)

-- To add new plugins, use the "install_plugin" hook,
-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event' field)
-- see: https://github.com/wbthomason/packer.nvim
-- examples below:

hooks.add("install_plugins", function(use)
   use {
      "tpope/vim-fugitive",
      event = "BufRead",
      setup = function()
         local utils = require "core.utils"
         local map = utils.map

         map("n", "<leader>gs", ":tab Git <CR>")
         map("n", "<leader>gb", ":Git blame <CR>")
         map("n", "<leader>gh", ":diffget //2 <CR>")
         map("n", "<leader>gl", ":diffget //3 <CR>")
      end
   }

   use {
      "kevinhwang91/nvim-bqf",
      event = "BufRead",
      config = function()
         local bqf = require "bqf"
         bqf.setup {
            auto_enable = true,
            preview = {
               win_height = 12,
               win_vheight = 12,
               delay_syntax = 80,
               border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
            },
            func_map = {
               vsplit = "",
               ptogglemode = "z,",
               stoggleup = "",
            },
         }
      end
   }

   use {
      "junegunn/gv.vim",
      event = "BufRead",
   }

   use {
      "mg979/vim-visual-multi",
      event = "BufRead",
   }

   use {
      "troydm/zoomwintab.vim",
      event = "BufRead",
   }

   use {
      "tpope/vim-unimpaired",
      event = "BufRead",
   }

   use {
      "tpope/vim-surround",
      event = "BufRead",
   }

   use {
      "tpope/vim-repeat",
      event = "BufRead",
   }

   use {
      "mfukar/robotframework-vim",
      ft = "robot" 
   }

   use { 
      "mMontu/vim-RobotUtils", 
      ft = "robot" 
   }
end)

-- alternatively, put this in a sub-folder like "lua/custom/plugins/mkdir"
-- then source it with

-- require "custom.plugins.mkdir"
