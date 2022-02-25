vim.cmd [[ autocmd BufEnter * :syntax sync fromstart ]]

vim.cmd [[
function! OnUIEnter(event) abort
  if 'Firenvim' ==# get(get(nvim_get_chan_info(a:event.chan), 'client', {}), 'name', '')
    set guifont=FiraCode\ Nerd\ Font:h11
    set laststatus=0
  endif
endfunction
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
]]
