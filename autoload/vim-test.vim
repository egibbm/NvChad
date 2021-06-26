" require 'janko-m/vim-test'

function! s:cat(filename) abort
  return system('cat '.a:filename)
endfunction

function! VagrantTransform(cmd) abort
  if !empty(glob('Vagrantfile'))
    let vagrant_project = get(matchlist(s:cat('Vagrantfile'), '\vconfig\.vm\.synced_folder \".+\", \"(.+)\",\s+disabled:\s+false'), 1)
    return 'vagrant ssh --command '.shellescape('cd '.vagrant_project.'; '.a:cmd)
  else
    return a:cmd
  endif
endfunction

let g:test#custom_transformations = {'vagrant': function('VagrantTransform')}
let g:test#transformation = 'vagrant'

