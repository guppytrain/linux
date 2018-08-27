" editing
" map <BACKSPACE> X

" for fzp
map ; :Files<CR>
map <C-o> :NERDTreeToggle<CR>

" toggle line numbers
map 3 :set nonumber!<CR>

" save, then to shell
map wsh :w<bar>sh<CR>

" close other buffers
" map bo :NERDTreeToggle <bar> :%bd <bar> :e# <bar> :bd#<CR>
" map BO :%bd<bar>e#<bar>bd#<CR>
map BO :%bd<bar>e#<bar>bd#

" abbreviations
iabbr cb; # [?]
