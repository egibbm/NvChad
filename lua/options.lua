local opt = vim.opt
local g = vim.g

opt.undofile = true
opt.ruler = false
opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.gdefault = true
opt.autoread = true
opt.cul = true
opt.mouse = "a"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.updatetime = 250 -- update interval for gitsigns
opt.timeoutlen = 400
opt.clipboard = "unnamedplus"

-- disable nvim intro
opt.shortmess:append("sI")

-- disable tilde on end of buffer: https://github.com/  neovim/neovim/pull/8546#issuecomment-643643758
vim.cmd("let &fcs='eob: '")

-- Numbers
opt.number = true
opt.numberwidth = 2
-- opt.relativenumber = true

-- Indenline
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>hl")

g.mapleader = "\\"
g.auto_save = false

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
    "matchit"
}

for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end

-- Opening a file from its last left off position
--vim.cmd(
--   [[au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
--)

-- file extension specific tabbing
-- vim.cmd([[
--   autocmd Filetype python     setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
--   autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
--   autocmd FileType less       setlocal tabstop=2 shiftwidth=2 softtabstop=2
--   autocmd FileType scss       setlocal tabstop=2 shiftwidth=2 softtabstop=2
--   autocmd FileType xbt.php    setlocal tabstop=2 shiftwidth=2 softtabstop=2
--   autocmd Filetype gitcommit  setlocal spell textwidth=72
-- ]])

