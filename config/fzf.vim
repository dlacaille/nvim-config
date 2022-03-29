let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'top' } }
let g:fzf_preview_window = ['right:60%:border-left', 'ctrl-/']
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--ansi', '--layout=reverse', '--info=inline']}), <bang>0)
