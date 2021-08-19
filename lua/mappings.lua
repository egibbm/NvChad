local user_map = require("utils").load_config().mappings
local miscMap = user_map.misc

local cmd = vim.cmd

local function map(mode, lhs, rhs, opts)
   local options = { noremap = true, silent = true }
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end
   vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local M = {}
local opt = {}

-- these mappings will only be called during initialization
M.misc = function()
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

   -- copy whole file content
   -- map("n", miscMap.copywhole_file, ":%y+<CR>", opt)

   -- toggle numbers
   -- map("n", miscMap.toggle_linenr, ":set nu!<CR>", opt)

   -- terminals
   local function terms()
      local m = user_map.terms

      -- get out of terminal mode
      map("t", m.esc_termmode, "<C-\\><C-n>", opt)
      -- hide a term from within terminal mode
      map("t", m.esc_hide_termmode, "<C-\\><C-n> :lua require('utils').close_buffer() <CR>", opt)
      -- pick a hidden term 
      map("n", m.pick_term, ":Telescope terms <CR>", opt)

      -- Open terminals
      -- TODO this opens on top of an existing vert/hori term, fixme
      map("n", m.new_wind, ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>", opt)
      map("n", m.new_vert, ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>", opt)
      map("n", m.new_hori, ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>", opt)

      -- terminal navigation remap
      map("t", "<A-j>", "<C-W>j", opt)
      map("t", "<A-k>", "<C-W>k", opt) 
      map("t", "<A-h>", "<C-W>h", opt) 
      map("t", "<A-l>", "<C-W>l", opt) 
      map("t", "<C-j>", "<C-W>j", opt) 
      map("t", "<C-k>", "<C-W>k", opt) 
      map("t", "<C-h>", "<C-W>h", opt) 
      map("t", "<C-l>", "<C-W>l", opt) 
   end
   terms()

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
   vidio()

   -- ctrl + s to save file
   -- map("n", "<C-s>", ":w <CR>", opt)

   -- use ESC to turn off search highlighting
   map("n", "<leader><space>", ":noh<CR>", opt)

   -- navigation within insert mode
   local check_insertNav = require("utils").load_config().options.enable_insertNav

   if check_insertNav == true then
      local m = user_map.insert_nav

      map("i", m.forward, "<Right>", opt)
      map("i", m.backward, "<Left>", opt)
      map("i", m.top_of_line, "<ESC>^i", opt)
      map("i", m.end_of_line, "<End>", opt)
      map("i", m.next_line, "<Up>", opt)
      map("i", m.prev_line, "<Down>", opt)
   end

   -- check the theme toggler
   local theme_toggler = require("utils").load_config().ui.theme_toggler
   if theme_toggler == true then
      local m = user_map.misc.theme_toggle

      map("n", m, ":lua require('utils').toggle_theme(require('utils').load_config().ui.fav_themes)<CR>", opt)
   end

   -- Packer commands till because we are not loading it at startup
   cmd "silent! command PackerCompile lua require 'pluginList' require('packer').compile()"
   cmd "silent! command PackerInstall lua require 'pluginList' require('packer').install()"
   cmd "silent! command PackerStatus lua require 'pluginList' require('packer').status()"
   cmd "silent! command PackerSync lua require 'pluginList' require('packer').sync()"
   cmd "silent! command PackerUpdate lua require 'pluginList' require('packer').update()"

   -- add NvChadUpdate command and mapping
   cmd "silent! command! NvChadUpdate lua require('utils').update_nvchad()"
   map("n", user_map.misc.update_nvchad, ":NvChadUpdate<CR>", opt)
end

M.bufferline = function()
   local m = user_map.bufferline

   map("n", m.new_buffer, ":enew<CR>", opt) -- new buffer
   map("n", m.newtab, ":tabnew<CR>", opt) -- new tab
   map("n", m.close, ":lua require('utils').close_buffer() <CR>", opt) -- close  buffer

   -- move between tabs

   map("n", m.cycleNext, ":BufferLineCycleNext<CR>", opt)
   map("n", m.cyclePrev, ":BufferLineCyclePrev<CR>", opt)
end

M.chadsheet = function()
   local m = user_map.chadsheet

   map("n", m.default_keys, ":lua require('cheatsheet').show_cheatsheet_telescope()<CR>", opt)
   map(
      "n",
      m.user_keys,
      ":lua require('cheatsheet').show_cheatsheet_telescope{bundled_cheatsheets = false, bundled_plugin_cheatsheets = false }<CR>",
      opt
   )
end

M.comment_nvim = function()
   local m = user_map.comment_nvim.comment_toggle
   map("n", m, ":CommentToggle<CR>", opt)
   map("v", m, ":CommentToggle<CR>", opt)
end

M.dashboard = function()
   local m = user_map.dashboard

   map("n", m.open, ":Dashboard<CR>", opt)
   map("n", m.newfile, ":DashboardNewFile<CR>", opt)
   map("n", m.bookmarks, ":DashboardJumpMarks<CR>", opt)
   map("n", m.sessionload, ":SessionLoad<CR>", opt)
   map("n", m.sessionsave, ":SessionSave<CR>", opt)
end

M.fugitive = function()
   local m = user_map.fugitive

   map("n", m.Git, ":tab Git<CR>", opt)
   map("n", m.diffget_2, ":diffget //2<CR>", opt)
   map("n", m.diffget_3, ":diffget //3<CR>", opt)
   map("n", m.git_blame, ":Git blame<CR>", opt)
end

M.nvimtree = function()
   local m = user_map.nvimtree

   map("n", m.treetoggle, ":NvimTreeToggle<CR>", opt)
   map("n", m.findfile, ":NvimTreeFindFile<CR>", opt)
end

M.neoformat = function()
   local m = user_map.neoformat.format
   map("n", m, ":Neoformat<CR>", opt)
end

M.truezen = function()
   local m = user_map.truezen

   map("n", m.ataraxisMode, ":TZAtaraxis<CR>", opt)
   map("n", m.minimalisticmode, ":TZMinimalist<CR>", opt)
   map("n", m.focusmode, ":TZFocus<CR>", opt)
end

M.telescope = function()
   local m = user_map.telescope

   map("n", m.live_grep, ":Telescope live_grep<CR>", opt)
   -- map("n", m.git_status, ":Telescope git_status <CR>", opt)
   map("n", m.git_commits, ":Telescope git_commits <CR>", opt)
   map("n", m.find_files, ":Telescope find_files <CR>", opt)
   map("n", m.buffers, ":Telescope buffers<CR>", opt)
   map("n", m.help_tags, ":Telescope help_tags<CR>", opt)
   map("n", m.oldfiles, ":Telescope oldfiles<CR>", opt)
   map("n", m.themes, ":Telescope themes<CR>", opt)
end

M.telescope_media = function()
   local m = user_map.telescope_media
   map("n", m.media_files, ":Telescope media_files <CR>", opt)
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
