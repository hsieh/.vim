function! _VimuxNearestIndex()
  let views = split(system("tmux list-panes"), "\n")

  for view in views
    if match(view, "(active)") != -1
      let l:nearestIndex=split(view, ":")[0]
      let g:VimuxRunnerIndex=l:nearestIndex
      return l:nearestIndex
    endif
  endfor

  return -1
endfunction


