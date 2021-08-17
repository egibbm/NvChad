-- require surround
-- # to surround with ruby string interpolation
vim.g.surround_35 = "#{\r}"
-- - to surround with no-output erb tag
vim.g.surround_45 = "<% \r %>"
-- = to surround with output erb tag
vim.g.surround_61 = "<%= \r %>"

-- require thoughtbot/vim-rspec, tpope/vim-dispatch
vim.g.rspec_command = "Dispatch rspec --format=progress --no-profile {spec}"

