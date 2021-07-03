local M = {}

M.config = function()
  local bqf = require('bqf')
  bqf.setup({
    auto_enable = true,
    preview = {
      win_height = 12,
      win_vheight = 12,
      delay_syntax = 80,
      border_chars = {'┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█'}
    },
    func_map = {
      vsplit = '',
      ptogglemode = 'z,',
      stoggleup = ''
    }
  })
end

return M
