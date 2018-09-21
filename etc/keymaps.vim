" editing
" map <BACKSPACE> X

" for fzp
map ; :Files<CR>
map <C-o> :NERDTreeToggle<CR>

" toggle line numbers
map 3 :set nonumber!<CR>

" save, then to shell
command Wsh :w<bar>:sh

" close other buffers
" map bo :NERDTreeToggle <bar> :%bd <bar> :e# <bar> :bd#<CR>
" map BO :%bd<bar>e#<bar>bd#<CR>
command Bo :%bd<bar>e#<bar>bd#

" abbreviations
iabbr cb; # [?]
iabbr xb; # [x]
iabbr ts; <C-R>=strftime("%c", localtime())<CR>
iabbr xbts; # [x] <C-R>=strftime("%c", localtime())<CR>


