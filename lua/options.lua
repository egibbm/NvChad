local options = require("chadrc").options
local opt = vim.opt
local g = vim.g

opt.completeopt = { "menuone", "noselect" }
opt.undofile = options.permanent_undo
opt.ruler = options.ruler
opt.hidden = options.hidden
opt.ignorecase = options.ignorecase
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.gdefault = true
opt.autoread = true
opt.cul = true
opt.mouse = options.mouse
opt.signcolumn = "yes"
opt.cmdheight = options.cmdheight
opt.updatetime = options.updatetime -- update interval for gitsigns
opt.timeoutlen = options.timeoutlen
opt.clipboard = options.clipboard

-- disable nvim intro
opt.shortmess:append "sI"

-- disable tilde on end of buffer: https://github.com/  neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = { eob = " " }

-- Numbers
opt.number = options.number
opt.numberwidth = options.numberwidth
-- opt.relativenumber = true

-- Indenline
opt.expandtab = options.expandtab
opt.shiftwidth = options.shiftwidth
opt.smartindent = options.smartindent

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>hl"

g.mapleader = options.mapleader
g.auto_save = options.autosave

-- disable builtin vim plugins
local disabled_built_ins = {
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "gzip",
   "zip",
   "zipPlugin",
   "tar",
   "tarPlugin",
   "getscript",
   "getscriptPlugin",
   "vimball",
   "vimballPlugin",
   "2html_plugin",
   "logipat",
   "rrhelper",
   "spellfile_plugin",
   "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end

-- Don't show status line on certain windows
vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber ]]
vim.cmd [[let hidden_statusline = luaeval('require("chadrc").ui.hidden_statusline') | autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter,TermEnter * nested if index(hidden_statusline, &ft) >= 0 | set laststatus=0 | else | set laststatus=2 | endif]]

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

