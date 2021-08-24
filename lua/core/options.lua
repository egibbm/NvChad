local opt = vim.opt
local g = vim.g

-- export user config as a global varibale
g.nvchad_user_config = "chadrc"

local options = require("core.utils").load_config().options

opt.clipboard = options.clipboard
opt.cmdheight = options.cmdheight
opt.completeopt = { "menuone", "noselect" }
opt.cul = true -- cursor line

-- Indentline
opt.expandtab = options.expandtab
opt.shiftwidth = options.shiftwidth
opt.smartindent = options.smartindent

-- disable tilde on end of buffer: https://github.com/  neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = { eob = " " }

opt.hidden = options.hidden
opt.ignorecase = options.ignorecase
opt.mouse = options.mouse
opt.smartcase = true

-- Numbers
opt.number = options.number
opt.numberwidth = options.numberwidth
opt.relativenumber = options.relativenumber
opt.ruler = options.ruler

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.tabstop = options.tabstop
opt.termguicolors = true
opt.timeoutlen = options.timeoutlen
opt.undofile = options.permanent_undo

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = options.updatetime

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>hl"

g.mapleader = options.mapleader
opt.gdefault = true
opt.autoread = true

-- disable some builtin vim plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end

-- uncomment this if you want to open nvim with a dir
-- vim.cmd [[ autocmd BufEnter * if &buftype != "terminal" | lcd %:p:h | endif ]]

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
-- vim.cmd[[ au InsertEnter * set norelativenumber ]]
-- vim.cmd[[ au InsertLeave * set relativenumber ]]

-- Don't show any numbers inside terminals
-- vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]

-- Don't show status line on certain windows
-- vim.cmd [[ autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter,TermEnter * lua require("utils").hide_statusline() ]]

-- Open a file from its last left off position
-- vim.cmd [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]
-- file extension specific tabbing
-- vim.cmd([[
--   autocmd Filetype python     setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
--   autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
--   autocmd FileType less       setlocal tabstop=2 shiftwidth=2 softtabstop=2
--   autocmd FileType scss       setlocal tabstop=2 shiftwidth=2 softtabstop=2
--   autocmd FileType xbt.php    setlocal tabstop=2 shiftwidth=2 softtabstop=2
--   autocmd Filetype gitcommit  setlocal spell textwidth=72
-- ]])

