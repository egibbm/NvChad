local config = require("core.utils").load_config()
local maps = config.mappings
local plugin_maps = maps.plugin
local cmd = vim.cmd

local function map(mode, lhs, rhs, opts)
   local options = { noremap = true, silent = true }
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end

   -- if list of keys provided then run set for all of them
   if type(lhs) == "table" then
      for _, key in ipairs(lhs) do
         vim.api.nvim_set_keymap(mode, key, rhs, options)
      end
   else
      vim.api.nvim_set_keymap(mode, lhs, rhs, options)
   end
end

local opt, M = {}, {}

-- these mappings will only be called during initialization
M.misc = function()
   local function non_config_mappings()
      -- dont copy any deleted text , this is disabled by default so uncomment the below mappings if you want them
      -- map("n", "dd", [=[ "_dd ]=], opt)
      -- map("v", "dd", [=[ "_dd ]=], opt)
      -- map("v", "x", [=[ "_x ]=], opt)
      -- todo: this should be configurable via chadrc

      -- Don't copy the replaced text after pasting in visual mode
      map("v", "p", '"_dP', opt)

      -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
      -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
      -- empty mode is same as using :map
      map("", "j", 'v:count ? "j" : "gj"', { expr = true })
      map("", "k", 'v:count ? "k" : "gk"', { expr = true })
      map("", "<Down>", 'v:count ? "j" : "gj"', { expr = true })
      map("", "<Up>", 'v:count ? "k" : "gk"', { expr = true })

      -- use ESC to turn off search highlighting
      map("n", "<leader><space>", ":noh <CR>", opt)
   end

   local function vidio()
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
   end

   local function optional_mappings()
      -- navigation within insert mode
      if config.options.insert_nav then
         local inav = maps.insert_nav

         map("i", inav.backward, "<Left>", opt)
         map("i", inav.end_of_line, "<End>", opt)
         map("i", inav.forward, "<Right>", opt)
         map("i", inav.next_line, "<Up>", opt)
         map("i", inav.prev_line, "<Down>", opt)
         map("i", inav.top_of_line, "<ESC>^i", opt)
      end

      -- check the theme toggler
      if config.ui.theme_toggler then
         map(
            "n",
            maps.theme_toggler,
            ":lua require('nvchad').toggle_theme(require('core.utils').load_config().ui.theme_toggler.fav_themes) <CR>",
            opt
         )
      end
   end

   local function required_mappings()
      map("n", maps.close_buffer, ":lua require('core.utils').close_buffer() <CR>", opt) -- close  buffer
      -- map("n", maps.copy_whole_file, ":%y+ <CR>", opt) -- copy whole file content
      map("n", maps.new_buffer, ":enew <CR>", opt) -- new buffer
      map("n", maps.new_tab, ":tabnew <CR>", opt) -- new tabs
      -- map("n", maps.line_number_toggle, ":set nu! <CR>", opt) -- toggle numbers
      -- map("n", maps.save_file, ":w <CR>", opt) -- ctrl + s to save file

      -- terminal mappings --
      local term_maps = maps.terminal
      -- get out of terminal mode
      map("t", term_maps.esc_termmode, "<C-\\><C-n>", opt)
      -- hide a term from within terminal mode
      map("t", term_maps.esc_hide_termmode, "<C-\\><C-n> :lua require('core.utils').close_buffer() <CR>", opt)
      -- pick a hidden term
      map("n", term_maps.pick_term, ":Telescope terms <CR>", opt)
      -- Open terminals
      -- TODO this opens on top of an existing vert/hori term, fixme
      map(
         "n",
         term_maps.new_horizontal,
         ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>",
         opt
      )
      map("n", term_maps.new_vertical, ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>", opt)
      map("n", term_maps.new_window, ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>", opt)
      -- terminal mappings end --

      -- Add Packer commands because we are not loading it at startup
      cmd "silent! command PackerClean lua require 'plugins' require('packer').clean()"
      cmd "silent! command PackerCompile lua require 'plugins' require('packer').compile()"
      cmd "silent! command PackerInstall lua require 'plugins' require('packer').install()"
      cmd "silent! command PackerStatus lua require 'plugins' require('packer').status()"
      cmd "silent! command PackerSync lua require 'plugins' require('packer').sync()"
      cmd "silent! command PackerUpdate lua require 'plugins' require('packer').update()"

      -- add NvChadUpdate command and mapping
      cmd "silent! command! NvChadUpdate lua require('nvchad').update_nvchad()"
      map("n", maps.update_nvchad, ":NvChadUpdate <CR>", opt)
   end

   non_config_mappings()
   vidio()
   optional_mappings()
   required_mappings()
end

-- below are all plugin related mappinsg

M.better_escape = function()
   vim.g.better_escape_shortcut = plugin_maps.better_escape.esc_insertmode or { "" }
end

M.bufferline = function()
   local m = plugin_maps.bufferline

   map("n", m.next_buffer, ":BufferLineCycleNext <CR>", opt)
   map("n", m.prev_buffer, ":BufferLineCyclePrev <CR>", opt)
end

M.chadsheet = function()
   local m = plugin_maps.chadsheet

   map("n", m.default_keys, ":lua require('cheatsheet').show_cheatsheet_telescope() <CR>", opt)
   map(
      "n",
      m.user_keys,
      ":lua require('cheatsheet').show_cheatsheet_telescope{bundled_cheatsheets = false, bundled_plugin_cheatsheets = false } <CR>",
      opt
   )
end

M.comment = function()
   local m = plugin_maps.comment.toggle
   map("n", m, ":CommentToggle <CR>", opt)
   map("v", m, ":CommentToggle <CR>", opt)
end

M.dashboard = function()
   local m = plugin_maps.dashboard

   map("n", m.bookmarks, ":DashboardJumpMarks <CR>", opt)
   map("n", m.new_file, ":DashboardNewFile <CR>", opt)
   map("n", m.open, ":Dashboard <CR>", opt)
   map("n", m.session_load, ":SessionLoad <CR>", opt)
   map("n", m.session_save, ":SessionSave <CR>", opt)
end

M.nvimtree = function()
   map("n", plugin_maps.nvimtree.toggle, ":NvimTreeToggle <CR>", opt)
   map("n", plugin_maps.nvimtree.focus,  ":NvimTreeFocus <CR>", opt)
   map("n", plugin_maps.nvimtree.findfile, ":NvimTreeFindFile <CR>", opt)
end

M.neoformat = function()
   map("n", plugin_maps.neoformat.format, ":Neoformat <CR>", opt)
end

M.telescope = function()
   local m = plugin_maps.telescope

   map("n", m.buffers, ":Telescope buffers <CR>", opt)
   map("n", m.find_files, ":Telescope find_files <CR>", opt)
   map("n", m.git_commits, ":Telescope git_commits <CR>", opt)
   -- map("n", m.git_status, ":Telescope git_status <CR>", opt)
   map("n", m.help_tags, ":Telescope help_tags <CR>", opt)
   map("n", m.live_grep, ":Telescope live_grep <CR>", opt)
   map("n", m.oldfiles, ":Telescope oldfiles <CR>", opt)
   map("n", m.themes, ":Telescope themes <CR>", opt)
end

M.telescope_media = function()
   local m = plugin_maps.telescope_media

   map("n", m.media_files, ":Telescope media_files <CR>", opt)
end

M.truezen = function()
   local m = plugin_maps.truezen

   map("n", m.ataraxis_mode, ":TZAtaraxis <CR>", opt)
   map("n", m.focus_mode, ":TZFocus <CR>", opt)
   map("n", m.minimalistic_mode, ":TZMinimalist <CR>", opt)
end

M.vim_fugitive = function()
   local m = plugin_maps.vim_fugitive

   map("n", m.git, ":tab Git <CR>", opt)
   map("n", m.git_blame, ":Git blame <CR>", opt)
   map("n", m.diff_get_2, ":diffget //2 <CR>", opt)
   map("n", m.diff_get_3, ":diffget //3 <CR>", opt)
end

M.rails = function()
   -- shortcuts for frequenly used files
   map("n", "gs", ":e db/schema.rb<cr>", opt)
   map("n", "gr", ":e config/routes.rb<cr>", opt)
   map("n", "gm", ":e Gemfile<cr>", opt)

   -- require thoughtbot/vim-rspec, tpope/vim-dispatch
   map("n", "<Leader>rc", ":wa<CR> :call RunCurrentSpecFile()<CR>", opt)
   map("n", "<Leader>rn", ":wa<CR> :call RunNearestSpec()<CR>", opt)
   map("n", "<Leader>rl", ":wa<CR> :call RunLastSpec()<CR>", opt)
   map("n", "<Leader>ra", ":wa<CR> :call RunAllSpecs()<CR>", opt)

   -- require tpope/vim-rails
   map("", "<Leader>oc", ":Econtroller<Space>", opt)
   map("", "<Leader>ov", ":Eview<Space>", opt)
   map("", "<Leader>om", ":Emodel<Space>", opt)
   map("", "<Leader>oh", ":Ehelper<Space>", opt)
   map("", "<Leader>oj", ":Ejavascript<Space>", opt)
   map("", "<Leader>os", ":Estylesheet<Space>", opt)
   map("", "<Leader>oi", ":Eintegrationtest<Space>", opt)
end

M.compe = function()
   map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
   map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
   map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
   map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
   map("i", "<CR>", "v:lua.completions()", {expr = true})
end

M.vim_test = function()
   map("n", "<leader>T", ":TestFile<CR>",    { silent = true })
   map("n", "<leader>F", ":TestNearest<CR>", { silent = true })
end

return M
