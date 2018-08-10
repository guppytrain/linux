set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
 Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" ======= START PLUGINS ===============
" badwolf is a vim colorscheme put together by Steve Losh.
Plugin 'sjl/badwolf'

" ctrlp is a fuzzy file and buffer finder that shows up above the vim status bar when you’re trying to find or edit another file.
" Plugin 'ctrlpvim/ctrlp.vim'

" tcomment_vim is a syntax-aware plugin for easy commenting. It’s so great and might be my most-used plugin.
Plugin 'tomtom/tcomment_vim'

" vim-indent-guides provides visual indicators of the indent level of each line in a file.
Plugin 'nathanaelkane/vim-indent-guides'

" adds a column to the left margin indicating lines changed in the active file since the last Git revision
Plugin 'airblade/vim-gitgutter'

" EditorConfig is a multi-editor tool for defining base file handling and code style preferences in a project and aligning these between editors
"Plugin 'editorconfig/editorconfig-vim'

" replace statusline — whether as an improved visual aid 
Plugin 'itchyny/lightline.vim'

" open a file instantly after typing a rough representation of its name
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

" powerful completion tool for HTML, CSS and JavaScript which allows you to make dynamic completions from a shorthand expression
Plugin 'mattn/emmet-vim'

" popular plugin to display an interactive file tree view in a side panel
Plugin 'scrooloose/nerdtree'

" You’ve got to love multiple selections
Plugin 'terryma/vim-multiple-cursors'

" a dozen core Unix file operations as Vim commands in the context of the current file
Plugin 'tpope/vim-eunuch'

" motions to add, change or remove surrounding characters and strings in a variety of ways
Plugin 'tpope/vim-surround'

" ALE (Asynchronous Lint Engine) is a comprehensive code analysis plugin for Vim
Plugin 'w0rp/ale'

" scratch plugin
Plugin 'mtth/scratch.vim'

" ------- END PLUGINS -----------------

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" To install from command line: vim +PluginInstall +qall
