set incsearch
set infercase
set encoding=utf-8
" reopen the file with specified encoding
" :e ++enc=utf-8
set fileencodings=utf-8,utf-16,gbk,big5,gb180380,latin1
let g:acp_ignorecaseOption = 0
let g:acp_completeoptPreview = 1
" the backspace cannot delete indent without this
set backspace=2
set hlsearch
set nu rnu
set noswapfile
set complete=t,.,w,b,u,i
set completeopt+=noinsert
" set window fix height and width
" set wfh
syntax enable
set laststatus=2
set iskeyword-=:
autocmd FileType html :set iskeyword+=-
"---------------- show line head tab as |----------
":h listchars for help
set list lcs=tab:\|\ 
"--------------------------------------------------
autocmd InsertEnter * :set nu nornu
autocmd InsertLeave * :set nu rnu
autocmd FileType taglist set norelativenumber
" see usr_05.txt install matchit
silent! packadd! matchit
" autocmd FileType nerdtree set norelativenumber
set tabstop=4
set shiftwidth=4
set expandtab
set hidden

"------------------ for folding
set foldcolumn=1
set foldmethod=indent
set foldlevel=100
" set foldopen=all
" set foldclose=all
nnoremap <silent><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
"------------------ end for folding 
nnoremap <pageup> :bp<CR>
nnoremap <pagedown> :bn<CR>
nnoremap <f12> g<c-]>
vnoremap <f12> g<c-]>
nnoremap <f11> <c-w>g}
set splitright
map <f10> :vsp<CR>:exec("tjump ".expand("<cword>"))<CR>zt
" -w of grep is used to match a whole word 
" %:h will be expanded as the path of current file
" %:. stands for currnt file
" if I want to use CWD, replace %:h to ./
" -F treat PATTERN as a fixed string instead of regex
nnoremap <f2> :gr! "<c-r><c-w>" -iFwr "." <home><c-right><c-right>
" in virsual mode, I don't want to search a whole word, so doesn't use -w
vnoremap <f2> y:gr! "<c-r>"" -iFr "." <home><c-right><c-right>
" replacement, add a 'c' after 'g' if you want to confirm each replacement
" manually
" autocmd FileType javascript nnoremap <buffer> this cmd makes the f2 follow
" the file extension 
autocmd FileType javascript,json,css,htm,html nnoremap <buffer> <f2> :gr! "<c-r><c-w>" -iFwr "." --include=*.{js,json,css,htm,html}<home><c-right><c-right> | vnoremap <buffer> <f2> y:gr! "<c-r>"" -iFr "." --include=*.{js,json,css,htm,html}<home><c-right><c-right> | nnoremap <buffer> <leader><f2> :gr! "<c-r><c-w>" -iFwr ./ --include=*.{js,json,css,htm,html}<home><c-right><c-right> | vnoremap <buffer> <leader><f2> y:gr! "<c-r>"" -iFr ./ --include=*.{js,json,css,htm,html}<home><c-right><c-right>
autocmd FileType java nnoremap <buffer> <f2> :gr! "<c-r><c-w>" -iFwr "." --include=*.java<home><c-right><c-right> | vnoremap <buffer> <f2> y:gr! "<c-r>"" -iFr "." --include=*.java<home><c-right><c-right> | nnoremap <buffer> <leader><f2> :gr! "<c-r><c-w>" -iFwr ./ --include=*.java<home><c-right><c-right> | vnoremap <buffer> <leader><f2> y:gr! "<c-r>"" -iFr ./ --include=*.java<home><c-right><c-right>
autocmd FileType c,cpp,hpp,h nnoremap <buffer> <f2> :gr! "<c-r><c-w>" -iFwr "." --include=*.{c,cpp,hpp,h}<home><c-right><c-right> | vnoremap <buffer> <f2> y:gr! "<c-r>"" -iFr "." --include=*.{c,cpp,hpp,h}<home><c-right><c-right> | nnoremap <buffer> <leader><f2> :gr! "<c-r><c-w>" -iFwr ./ --include=*.{c,cpp,hpp,h}<home><c-right><c-right> | vnoremap <buffer> <leader><f2> y:gr! "<c-r>"" -iFr ./ --include=*.{c,cpp,hpp,h}<home><c-right><c-right>
nnoremap <f3> :%s/<c-r><c-w>//g<right><right>
vnoremap <f3> :s/\%V<c-r><c-w>//g<right><right>

nnoremap <f5> :UpdateTypesFileOnly<CR>
nnoremap <f7> :TagbarToggle<CR>
nnoremap <f8> :NERDTreeToggle<CR>
nnoremap zC zCzz
nnoremap zc zczz
nnoremap / /\c
nnoremap ? ?\c
nnoremap <up> <c-w>k
nnoremap <down> <c-w>j
nnoremap <left> <c-w>h
nnoremap <right> <c-w>l
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h
"different terminals have different character sequences of Function Keys , check which sequence stands for <c-up>  
" by type ctrl-v ctrl-up in insert mode 
" ctrl-up ctrl-down ctrl-left ctrl-right to resize current window
if has('nvim')
    nnoremap <c-up> <c-w>+:set wfh<CR>
    nnoremap <c-down> <c-w>-:set wfh<CR>
    nnoremap <c-left> <c-w>>:set wfw<CR>
    nnoremap <c-right> <c-w><:set wfw<CR>
else
    nnoremap [1;5A <c-w>+:set wfh<CR>
    nnoremap [1;5B <c-w>-:set wfh<CR>
    nnoremap [1;5C <c-w>>:set wfw<CR>
    nnoremap [1;5D <c-w><:set wfw<CR>
endif
" shift-up shift-down shift-left shift-right to move window position
if has('nvim')
    nnoremap <s-up> <c-w>K
    nnoremap <s-down> <c-w>J
    nnoremap <s-left> <c-w>L
    nnoremap <s-right> <c-w>H
else
    nnoremap [1;2A <c-w>K
    nnoremap [1;2B <c-w>J
    nnoremap [1;2C <c-w>L
    nnoremap [1;2D <c-w>H
endif
" alt-up alt-down to jump to next global search result
if has('nvim')
    nnoremap <m-up> :cp<CR>
    nnoremap <m-down> :cn<CR>
else
    nnoremap [1;3A :cp<CR>
    nnoremap [1;3B :cn<CR>
endif
" nnoremap zo zozz
nnoremap zM zMzz
vnoremap / <Esc>/\%V\c
"----------for bufsurf----------
" alt-9 for back alt-0 for forward
if has('nvim')
    nnoremap <silent> <m-9> :BufSurfBack<CR>
    nnoremap <silent> <m-0> :BufSurfForward<CR>
else
    nnoremap <silent> 9 :BufSurfBack<CR>
    nnoremap <silent> 0 :BufSurfForward<CR>
endif
"-------------------------------
" auto check file changing out of vim when cursor holded for 'updatetime'
set updatetime=500
au CursorHold * silent! checktime

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
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-notes'
Plugin 'jiangmiao/auto-pairs'
Plugin 'majutsushi/tagbar'
Plugin 'abudden/taghighlight-automirror'
Plugin 'vim-scripts/Mark--Karkat' 
Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'jvanja/vim-bootstrap4-snippets'
" Plugin 'Valloric/YouCompleteMe' cygwin seems not support ycm
"Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'vim-scripts/AutoComplPop'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
"Plugin 'LucHermitte/lh-vim-lib'
"Plugin 'LucHermitte/local_vimrc'
Plugin 'maksimr/vim-jsbeautify'
"Plugin 'vim-syntastic/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'embear/vim-localvimrc'
Plugin 'tpope/vim-surround'
Plugin 'Qiguang/vim-bufsurf'
Plugin 'tpope/vim-fugitive'
Plugin 'yssl/QFEnter'
Plugin 'ctrlpvim/ctrlp.vim'
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
colorscheme moloka
"--------for ctrlp--------------
let g:ctrlp_cmd = 'CtrlPBuffer'
"--------for netrw--------------
"let g:netrw_liststyle = 3
"let g:netrw_browse_split = 4
"let g:netrw_winsize = 20
"-------------------------------
"--------for NERDTree
let NERDTreeShowBookmarks=1
let NERDTreeWinPos = "right"
let NERDTreeChDirMode=2
let NERDTreeHighlightCursorline=1
let NERDTreeShowLineNumbers=1
"---------------------
"----------for Tarbar
let g:tagbar_width = 30
let g:tagbar_zoomwidth = 0
let g:tagbar_left = 1
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1
highlight TagbarSignature ctermfg=67
"----------for ultisnips---------------
autocmd FileType jsp :UltiSnipsAddFiletypes jsp.java.html
let g:UltiSnipsSnippetsDir = "~/.vim/mySnippets/"
let g:UltiSnipsSnippetDirectories=["Ultisnips","mySnippets"]
"--------------------------------------
"----------for airline and airline theme-------------
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_type = 0
"----------------------------------
" this 2 lines is for Mark--Karkat plugin, to avoid conflit with starsearch.
" check Mark--Karkat help doc for help
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
"---------------------
"------------for syntastic---------------------
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
"----------------------------------------------
"-----------for notes----------
"let g:notes_directories = ['~/Notes']
"------------------------------
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

"these 2 lines are for local vimrc plugin
"the new version of this plugin has a secure mechanism, it will ask me if I want to load local_vimrc
"every time I enter a directory that contains the local_vimrc file.
"these 2 statements can add my HOME path to a whitelist, so it will not bother
"me anymore if I enter a directory under my HOME path.
sil! call lh#local_vimrc#filter_list('asklist', 'v:val != $HOME')
sil! call lh#local_vimrc#munge('whitelist', $HOME)
" for TagHighlight
if ! exists('g:TagHighlightSettings')
	let g:TagHighlightSettings = {}
endif
let g:TagHighlightSettings['DisableTagManager'] = 'True'
imap jj <ESC>
"------------for local vimrc
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0
"--------------------------
"deal with long lines
nnoremap <silent> <expr> gH winline() - 1 - &scrolloff > 0
      \ ? ':normal! ' . (winline() - 1 - &scrolloff) . 'gkg^<CR>'
      \ : 'g^'
nnoremap <silent> <expr> gM winline() < (winheight(0)+1)/2
      \ ? ':normal! ' . ((winheight(0)+1)/2 - winline()) . 'gjg^<CR>'
      \ : winline() == (winheight(0)+1)/2
      \         ? 'g^'
      \         : ':normal! ' . (winline() - (winheight(0)+1)/2) . 'gkg^<CR>'
nnoremap <silent> <expr> gL winheight(0) - winline() - &scrolloff > 0
      \ ? ':normal! ' . (winheight(0) - winline() - &scrolloff) . 'gjg^<CR>'
      \ : 'g^'
map j gj
map k gk
map 0 g0
map ^ g^
map $ g$
map 0 g0
if &diff
    set noro
endif
" Dim inactive windows using 'colorcolumn' setting
" This tends to slow down redrawing, but is very useful.
" Based on https://groups.google.com/d/msg/vim_use/IJU-Vk-QLJE/xz4hjPjCRBUJ
" XXX: this will only work with lines containing text (i.e. not '~')
" from 
"if exists('+colorcolumn')
  "function! s:DimInactiveWindows()
    "for i in range(1, tabpagewinnr(tabpagenr(), '$'))
      "let l:range = ""
      "if i != winnr()
        "if &wrap
         "" HACK: when wrapping lines is enabled, we use the maximum number
         "" of columns getting highlighted. This might get calculated by
         "" looking for the longest visible line and using a multiple of
         "" winwidth().
         "let l:width=256 " max
        "else
         "let l:width=winwidth(i)
        "endif
        "let l:range = join(range(1, l:width), ',')
      "endif
      "call setwinvar(i, '&colorcolumn', l:range)
    "endfor
  "endfunction
  "augroup DimInactiveWindows
    "au!
    "au WinEnter * call s:DimInactiveWindows()
    "au WinEnter * set cursorline
    "au WinLeave * set nocursorline
  "augroup END
"endif
" for vim-jsbeautify
autocmd FileType javascript noremap <buffer>  <F4> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <F4> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <F4> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <F4> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <F4> :call CSSBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <F4> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <F4> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <F4> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <F4> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <F4> :call RangeCSSBeautify()<cr>
