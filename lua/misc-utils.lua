local opt = vim.opt

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
opt.clipboard = "unnamedplus"

-- Numbers
opt.number = true
opt.numberwidth = 2
-- opt("w", "relativenumber", true)

-- for indenline
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true

-- disable builtin vim plugins
vim.g.loaded_gzip = 0
vim.g.loaded_tar = 0
vim.g.loaded_tarPlugin = 0
vim.g.loaded_zipPlugin = 0
vim.g.loaded_2html_plugin = 0
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0
vim.g.loaded_matchit = 0
vim.g.loaded_matchparen = 0
vim.g.loaded_spec = 0

local M = {}

function M.is_buffer_empty()
    -- Check whether the current buffer is empty
    return vim.fn.empty(vim.fn.expand("%:t")) == 1
end

function M.has_width_gt(cols)
    -- Check if the windows width is greater than a given number of columns
    return vim.fn.winwidth(0) / 2 > cols
end

-- file extension specific tabbing
vim.cmd([[
  autocmd Filetype python     setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
  autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType less       setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType scss       setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd FileType xbt.php    setlocal tabstop=2 shiftwidth=2 softtabstop=2
  autocmd Filetype gitcommit  setlocal spell textwidth=72
]])

-- blankline config

M.blankline = function()
    vim.g.indentLine_enabled = 1
    vim.g.indent_blankline_char = "▏"

    vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard"}
    vim.g.indent_blankline_buftype_exclude = {"terminal"}

    vim.g.indent_blankline_show_trailing_blankline_indent = false
    vim.g.indent_blankline_show_first_indent_level = false
end

return M
