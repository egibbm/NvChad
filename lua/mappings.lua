local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- dont copy any deleted text , this is disabled by default so uncomment the below mappings if you want them
--[[ remove this line

map("n", "dd", [=[ "_dd ]=], opt)
map("v", "dd", [=[ "_dd ]=], opt)
map("v", "x", [=[ "_x ]=], opt)

 this line too ]]
--

-- OPEN TERMINALS --
--map("n", "<C-l>", [[<Cmd>vnew term://bash <CR>]], opt) -- term over right
--map("n", "<C-x>", [[<Cmd> split term://bash | resize 10 <CR>]], opt) --  term bottom
--map("n", "<C-t>t", [[<Cmd> tabnew | term <CR>]], opt) -- term newtab

-- copy whole file content
-- map("n", "<C-a>", [[ <Cmd> %y+<CR>]], opt)

-- toggle numbers
-- map("n", "<leader>n", [[ <Cmd> set nu!<CR>]], opt)

-- Truezen.nvim
-- map("n", "<leader>z", [[ <Cmd> TZAtaraxis<CR>]], opt)
-- map("n", "<leader>m", [[ <Cmd> TZMinimalist<CR>]], opt)

-- map("n", "<C-s>", [[ <Cmd> w <CR>]], opt)
-- vim.cmd("inoremap jh <Esc>")

-- easy wrap toggling
map("n", "<Leader>w", ":set wrap!<cr>", opt)
map("n", "<Leader>W", ":set nowrap<cr>", opt)

-- close all other windows (in the current tab)
map("n", "gW", ":only<cr>", opt)

-- delete all buffers
map("", "<Leader>d", ":bufdo bd<cr>", opt)

-- shortcuts for frequenly used files
map("n", "gs", ":e db/schema.rb<cr>", opt)
map("n", "gr", ":e config/routes.rb<cr>", opt)
map("n", "gm", ":e Gemfile<cr>", opt)

-- Commenter Keybinding
map("n", "<C-_>", ":CommentToggle<CR>", {noremap = true, silent = true})
map("v", "<C-_>", ":CommentToggle<CR>", {noremap = true, silent = true})

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
map("", "<Leader>c", ":StripTrailingWhitespaces<cr>", opt)

-- compress excess whitespace on current line
map("", "<Leader>e", ":s/\\v(\\S+)\\s+/\\1 /<cr>:nohl<cr>", opt)

-- map spacebar to clear search highlight
map("n", "<Leader><space>", ":noh<cr>", opt)

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
map("i", "<C-l>", "->", opt)
map("i", "<C-k>", "=>", opt)

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

-- compe stuff

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn["compe#complete"]()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

function _G.completions()
    local npairs = require("nvim-autopairs")
    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end

--  compe mappings
map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("i", "<CR>", "v:lua.completions()", {expr = true})

-- Mappings for nvimtree
map("n", "<leader>g", ":NvimTreeToggle<CR>",   { noremap = true, silent = true })
map("n", "<leader>G", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })

-- require 'janko-m/vim-test'

map("n", "<leader>T", ":TestFile<CR>",    { silent = true })
map("n", "<leader>F", ":TestNearest<CR>", { silent = true })
