let mapleader="\<tab>"

" Buffer
nnoremap <silent> <Leader>n :enew<cr>

" No cheating!
for map_command in ['noremap', 'noremap!', 'tnoremap']
    execute map_command . ' <LeftMouse> <nop>'
endfor

" coc.nvim
nmap <leader>p :Prettier<cr>

" Search mappings
nmap <silent> <esc> :nohlsearch<cr>

" Remap shift on homerow
map H ^
map L $
map J G
map K gg

" Easy align mappings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" FZF mappings
nnoremap <leader><leader> <cmd>:Files<cr>
nnoremap <leader>ff <cmd>:Rg<cr>
nnoremap <leader>fg <cmd>:BLines<cr>
nnoremap <leader>fb <cmd>:Buffers<cr>
nnoremap <leader>fc <cmd>:Commands<cr>
nnoremap <leader>fh <cmd>:Helptags<cr>
nnoremap <leader>fm <cmd>:Maps<cr>

" Quit/Save actions
nmap <Leader>w :w<cr>
nmap <C-q> :q<cr>
nmap <C-c> :qa!<cr>
nmap <C-s> :w<cr>
nmap <C-x> :wqa<cr>

" Switch buffer
nmap <Leader>hs :split<cr>
nmap <Leader>vs :vsplit<cr>
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>
tmap <C-J> <C-\><C-n><C-W><C-J>
tmap <C-K> <C-\><C-n><C-W><C-K>
tmap <C-H> <C-\><C-n><C-W><C-H>
tmap <C-L> <C-\><C-n><C-W><C-L>

" Terminal mode
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
nnoremap <Leader>ts :exec winheight(0)/3."split" \| terminal<cr>i
nnoremap <Leader>tv :vsplit \| terminal<cr>
tnoremap <Leader>q <C-\><C-n><C-W><C-q>

" Move lines
nnoremap <silent> <A-j> :m .+1<CR>==
nnoremap <silent> <A-k> :m .-2<CR>==
inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

" Mappings: vim-fugitive
map <Leader>ga :Git add %:p<cr><cr>
map <Leader>g. :Git add .<cr><cr>
map <Leader>gw :Gwrite<cr>
map <Leader>gs :Git<cr>
map <Leader>gc :Git commit<cr>
map <Leader>gb :exec ":Git switch -c " . input("New branch name: ")<cr>
map <Leader>gd :Gdiff<cr>
map <Leader>gp :Git pull<space>
map <Leader>gg :Git push -u origin<cr>
map <Leader>gm :Git mergetool<cr>
map <Leader>gf :terminal git-graph --no-pager --style round -n 999<cr>
