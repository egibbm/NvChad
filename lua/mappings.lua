local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
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

-- Don't copy the replaced text after pasting in visual mode
map("v", "p", '"_dP', opt)

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
-- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
-- empty mode is same as using :map
map("", "j", 'v:count ? "j" : "gj"', {expr = true})
map("", "k", 'v:count ? "k" : "gk"', {expr = true})
map("", "<Down>", 'v:count ? "j" : "gj"', {expr = true})
map("", "<Up>", 'v:count ? "k" : "gk"', {expr = true})

-- OPEN TERMINALS --
-- map("n", "<C-l>", ":vnew +terminal | setlocal nobuflisted <CR>", opt) -- term over right
-- map("n", "<C-x>", ":10new +terminal | setlocal nobuflisted <CR>", opt) --  term bottom
-- map("n", "<C-t>t", ":terminal <CR>", opt) -- term buffer

-- copy whole file content
-- map("n", "<C-a>", ":%y+<CR>", opt)

-- toggle numbers
-- map("n", "<leader>n", ":set nu!<CR>", opt)

-- Truezen.nvim
map("n", "<leader>zz", ":TZAtaraxis<CR>", opt)
map("n", "<leader>zm", ":TZMinimalist<CR>", opt)
map("n", "<leader>zf", ":TZFocus<CR>", opt)

-- map("n", "<C-s>", ":w <CR>", opt)

-- easy wrap toggling
map("n", "<Leader>w", ":set wrap!<cr>", opt)
map("n", "<Leader>W", ":set nowrap<cr>", opt)

-- close all other windows (in the current tab)
map("n", "gW", ":only<cr>", opt)

-- delete all buffers
map("", "<Leader>d", ":bufdo bd<cr>", opt)

-- Commenter Keybinding
map("n", "<C-_>", ":CommentToggle<CR>", opt)
map("v", "<C-_>", ":CommentToggle<CR>", opt)

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
    local npairs
    if
        not pcall(
            function()
                npairs = require "nvim-autopairs"
            end
        )
     then
        return
    end

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
-- map("n", "<leader>g", ":NvimTreeToggle<CR>",   opt)
map("n", "<leader>G", ":NvimTreeFindFile<CR>", opt)

-- require 'janko-m/vim-test'

map("n", "<leader>T", ":TestFile<CR>",    { silent = true })
map("n", "<leader>F", ":TestNearest<CR>", { silent = true })

-- format code
map("n", "<Leader>fm", ":Neoformat<CR>", opt)

-- dashboard stuff
map("n", "<Leader>db", ":Dashboard<CR>", opt)
map("n", "<Leader>fn", ":DashboardNewFile<CR>", opt)
map("n", "<Leader>bm", ":DashboardJumpMarks<CR>", opt)
map("n", "<C-s>l", ":SessionLoad<CR>", opt)
map("n", "<C-s>s", ":SessionSave<CR>", opt)

-- Telescope
map("n", "<Leader>fw", ":Telescope live_grep<CR>", opt)
-- map("n", "<Leader>gt", ":Telescope git_status <CR>", opt)
map("n", "<Leader>gc", ":Telescope git_commits <CR>", opt)
map("n", "<Leader>ff", ":Telescope find_files <CR>", opt)
map("n", "<C-p>",      ":Telescope find_files <CR>", opt)
map("n", "<Leader>fp", ":Telescope media_files <CR>", opt)
map("n", "<Leader>fb", ":Telescope buffers<CR>", opt)
map("n", "<Leader>fh", ":Telescope help_tags<CR>", opt)
map("n", "<Leader>fo", ":Telescope oldfiles<CR>", opt)
map("n", "<Leader>th", ":Telescope themes<CR>", opt)

-- bufferline tab stuff
map("n", "<S-t>", ":enew<CR>", opt) -- new buffer
map("n", "<C-t>b", ":tabnew<CR>", opt) -- new tab
map("n", "<S-x>", ":bd!<CR>", opt) -- close tab

-- move between tabs
map("n", "<TAB>", ":BufferLineCycleNext<CR>", opt)
map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", opt)

-- use ESC to turn off search highlighting
-- map("n", "<Esc>", ":noh<CR>", opt)
-- map("n", "<Leader><space>", ":noh<cr>", opt)

-- get out of terminal with jk
-- map("t", "jk", "<C-\\><C-n>", opt)

-- Packer commands till because we are not loading it at startup
vim.cmd("silent! command PackerCompile lua require 'pluginList' require('packer').compile()")
vim.cmd("silent! command PackerInstall lua require 'pluginList' require('packer').install()")
vim.cmd("silent! command PackerStatus lua require 'pluginList' require('packer').status()")
vim.cmd("silent! command PackerSync lua require 'pluginList' require('packer').sync()")
vim.cmd("silent! command PackerUpdate lua require 'pluginList' require('packer').update()")

-- Vim Fugitive
map("n", "<Leader>gs", ":tab Git<CR>", opt)
map("n", "<Leader>gh", ":diffget //2<CR>", opt)
map("n", "<Leader>gl", ":diffget //3<CR>", opt)
map("n", "<Leader>gb", ":Git blame<CR>", opt)
