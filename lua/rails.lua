local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local opt = {}

-- key mappings

-- require tpope/vim-rails
map("", "<Leader>oc", ":Econtroller<Space>", opt)
map("", "<Leader>ov", ":Eview<Space>", opt)
map("", "<Leader>om", ":Emodel<Space>", opt)
map("", "<Leader>oh", ":Ehelper<Space>", opt)
map("", "<Leader>oj", ":Ejavascript<Space>", opt)
map("", "<Leader>os", ":Estylesheet<Space>", opt)
map("", "<Leader>oi", ":Eintegrationtest<Space>", opt)

-- require surround
-- # to surround with ruby string interpolation
vim.g.surround_35 = "#{\r}"
-- - to surround with no-output erb tag
vim.g.surround_45 = "<% \r %>"
-- = to surround with output erb tag
vim.g.surround_61 = "<%= \r %>"

-- require thoughtbot/vim-rspec, tpope/vim-dispatch
vim.g.rspec_command = "Dispatch rspec --format=progress --no-profile {spec}"

map("n", "<Leader>rc", ":wa<CR> :call RunCurrentSpecFile()<CR>", opt)
map("n", "<Leader>rn", ":wa<CR> :call RunNearestSpec()<CR>", opt)
map("n", "<Leader>rl", ":wa<CR> :call RunLastSpec()<CR>", opt)
map("n", "<Leader>ra", ":wa<CR> :call RunAllSpecs()<CR>", opt)
