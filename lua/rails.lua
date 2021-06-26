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
map("", "<Leader>oc", ":Rcontroller<Space>", opt)
map("", "<Leader>ov", ":Rview<Space>", opt)
map("", "<Leader>om", ":Rmodel<Space>", opt)
map("", "<Leader>oh", ":Rhelper<Space>", opt)
map("", "<Leader>oj", ":Rjavascript<Space>", opt)
map("", "<Leader>os", ":Rstylesheet<Space>", opt)
map("", "<Leader>oi", ":Rintegration<Space>", opt)

-- require thoughtbot/vim-rspec, tpope/vim-dispatch
vim.g.rspec_command = "Dispatch rspec --format=progress --no-profile {spec}"

map("n", "<Leader>rc", ":wa<CR> :call RunCurrentSpecFile()<CR>", opt)
map("n", "<Leader>rn", ":wa<CR> :call RunNearestSpec()<CR>", opt)
map("n", "<Leader>rl", ":wa<CR> :call RunLastSpec()<CR>", opt)
map("n", "<Leader>ra", ":wa<CR> :call RunAllSpecs()<CR>", opt)
