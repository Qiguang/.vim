set incsearch
set hlsearch
set nu rnu
autocmd InsertEnter * :set nu nornu
autocmd InsertLeave * :set nu rnu
autocmd FileType taglist set norelativenumber
" autocmd FileType nerdtree set norelativenumber
set tabstop=4
set shiftwidth=4
set hidden

"------------------ for folding
set foldcolumn=3
set foldmethod=syntax
set foldlevel=3
" set foldopen=all
" set foldclose=all
nnoremap <silent><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
"------------------ end for folding 

nnoremap <f12> g<c-]>zt
" nnoremap <f11> <c-w>g<c-]>
nnoremap <f11> <c-w>g}
set splitright
map <f10> :vsp<CR>:exec("tjump ".expand("<cword>"))<CR>zt
" -w of grep is used to match a whole word 
" %:h will be expanded as the path of current file
" if I want to use CWD, replace %:h to ./
" -F treat PATTERN as a fixed string instead of regex
nnoremap <f2> :gr! "<c-r><c-w>" -iFwr %:h --include=*.{c,cpp,hpp,h}<home><c-right><c-right>
" in virsual mode, I don't want to search a whole word, so doesn't use -w
vnoremap <f2> y:gr! "<c-r>"" -iFr %:h --include=*.{c,cpp,hpp,h}<home><c-right><c-right>
nnoremap <f3> :%s/<c-r><c-w>/<c-r><c-w>/g
nnoremap <f5> :UpdateTypesFileOnly<CR>
nnoremap <f7> :TlistToggle<CR>
nnoremap <f8> :NERDTreeToggle<CR>
nnoremap zC zCzz
nnoremap zc zczz
nnoremap / /\c
nnoremap ? ?\c
nnoremap <up> <c-w>k
nnoremap <down> <c-w>j
nnoremap <left> <c-w>h
nnoremap <right> <c-w>l
"different terminals have different character sequences of Function Keys , check which sequence stands for <c-up>  
" by type ctrl-v ctrl-up in insert mode 
" ctrl-up ctrl-down ctrl-left ctrl-right to resize current window
nnoremap [1;5A <c-w>+
nnoremap [1;5B <c-w>-
nnoremap [1;5C <c-w>>
nnoremap [1;5D <c-w><
" shift-up shift-down shift-left shift-right to move window position
nnoremap [1;2A <c-w>K
nnoremap [1;2B <c-w>J
nnoremap [1;2C <c-w>L
nnoremap [1;2D <c-w>H
" nnoremap zo zozz
nnoremap zM zMzz
vnoremap / <Esc>/\%V\c
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
Plugin 'vim-scripts/Mark--Karkat' 
" Plugin 'Valloric/YouCompleteMe' cygwin seems not support ycm
Plugin 'vim-scripts/AutoComplPop'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'LucHermitte/lh-vim-lib'
Plugin 'LucHermitte/local_vimrc'
" Plugin 'flazz/vim-colorschemes' colors doesn't show propriety
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
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
let NERDTreeShowBookmarks=1
let NERDTreeWinPos = "right"
let NERDTreeChDirMode=2
let NERDTreeHighlightCursorline=1
"---------------------
" this 2 lines is for Mark--Karkat plugin, to avoid conflit with starsearch.
" check Mark--Karkat help doc for help
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
"---------------------
colorscheme moloka
set showcmd
" hi StatusLine ctermfg=Brown
" hi Folded ctermfg=green
" hi FoldColum ctermfg=green
augroup BgHighlight
	autocmd!
	autocmd WinEnter * set cul
	autocmd WinLeave * set nocul
augroup END
" change default quick fix window position to bottom
autocmd FileType qf wincmd J
