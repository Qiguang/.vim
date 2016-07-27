set incsearch
set hlsearch
set number
" set relativenumber
" autocmd FileType taglist set norelativenumber
" autocmd FileType nerdtree set norelativenumber
set showcmd
set tabstop=4
set shiftwidth=4
set hidden

"------------------ for folding
set foldcolumn=3
set foldmethod=syntax
set foldlevel=2
" set foldopen=all
" set foldclose=all
nnoremap <silent><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
"------------------ end for folding 

nnoremap <f12> g<c-]>
" nnoremap <f11> <c-w>g<c-]>
nnoremap <f11> <c-w>g}
map <f10> :vsp<CR>:exec("tjump ".expand("<cword>"))<CR>
nnoremap zC zCzz
nnoremap zc zczz
nnoremap <up> <c-w>k
nnoremap <down> <c-w>j
nnoremap <left> <c-w>h
nnoremap <right> <c-w>l
" nnoremap zo zozz
nnoremap zM zMzz
vnoremap / <Esc>/\%V
let Tlist_Exit_OnlyWindow = 1

" auto check file changing out of vim
au CursorHold * checktime

" ------------------for Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-scripts/casejump.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'wincent/command-t'
"Plugin 'bronson/vim-visual-star-search' I like starsearch.vim created by
"Guodong Liang more.
" Plugin 'xolox/vim-easytags'
Plugin 'abudden/taghighlight-automirror'
Plugin 'vim-scripts/taglist.vim'
Plugin 'noah/vim256-color'
" Plugin 'flazz/vim-colorschemes' colors doesn't show propriety
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
"----------------- end for Vundle
colorscheme heroku
let NERDTreeShowBookmarks=1
