colorscheme moloka
" search&replacement related config
set incsearch
set hlsearch
nmap / /\c
nmap ? ?\c
vmap / <ESC>/\%V\c
nmap <f2> :gr! "<c-r><c-w>" -iFwr "%:h" <home><c-right><c-right><left>
vmap <f2> y:gr! "<c-r>"" -iFr "%:h" <home><c-right><c-right><left>
" comment of <f2>: 
"   Fn2 is used for search globally
"   flags
"     -i ignore case
"     -F treat PATTERN as a fixed string but not a regex
"     -w match a whole word
"     -r recursively
"   path to search
"     . CWD
"     %:h the path of current file
"     %:. in current file
nmap <f3> :%s/<c-r><c-w>//g<right><right>
vmap <f3> :s/\%V<c-r><c-w>//g<right><right>
" comment of <f3>:
"   Fn3 is used for replacement
"   append 'c' after this command to enable confirmation for 
"   every replacement, e.g. %s/StringA/StringB/gc
nmap <m-up> :cp<CR>
nmap <m-down> :cn<CR>
" comment of alt-up,down:
"   jump to the next item of global search list

" about line number
set number
set relativenumber
autocmd InsertEnter * set nu nornu
autocmd InsertLeave * set nu rnu
autocmd FileType taglist set nornu

" misc config
set noswapfile
set laststatus=2  " give a status line to every window
imap jj <ESC>
au BufEnter,FocusGained,WinEnter * silent! checktime  " check file change
au WinEnter * set cul    " show cursorline on active window
au WinLeave * set nocul
set hidden  " when switch buffer while content is changed, just keep it.
set wildmode=longest:full  " set completion mode, pls see help
set iskeyword-=: " this option affect the * command(highlighting) 
autocmd FileType html set iskeyword+=-
set list lcs=tab:\|\ " display the indent tab as |, :h listchars for help"
set expandtab " tabs typed will be replace by spaces"
if &diff
    set noro
endif

" quickfix window
"  show quickfix window on the bottom
autocmd FileType qf wincmd J

" keyword completion related config
set complete=t,.,w,b,u,i
set completeopt+=noinsert,menuone
set infercase

" tab key related config
set tabstop=4
set shiftwidth=4

" folding related config
set foldcolumn=1  " showing a column at the lift side of the window indicates folds
set foldmethod=indent
set foldlevel=100
nnoremap <silent><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

" window related config
" window focusing
nmap <up> <c-w>k
nmap <down> <c-w>j
nmap <right> <c-w>l
nmap <left> <c-w>h
nmap <c-k> <c-w>k
nmap <c-j> <c-w>j
nmap <c-l> <c-w>l
nmap <c-h> <c-w>h
" window resizing, ctrl-up,down,left,right for resizing window
nmap <c-up> <c-w>+:set wfh<CR>
nmap <c-down> <c-w>-:set wfh<CR>
nmap <c-left> <c-w>>:set wfw<CR>
nmap <c-right> <c-w><:set wfw<CR>
" window moving, shift-up,down,left,right for moving window
nmap <s-up> <c-w>K
nmap <s-down> <c-w>J
nmap <s-left> <c-w>L
nmap <s-right> <c-w>H

set splitright  " splitting window will appear to the right of current window

" tag jump related config
map <f12> g<c-]>
vmap <f12> g<c-]>
map <f11> <c-w>g}
map <f10> :vsp<CR>:exec("tjump ".expand("<cword>"))<CR>zt
map <f9> :!ctags -R --extras=+f .

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

" plugins
"  vim-plug is needed, 
"  download vim-plug in Unix:
"   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
"  For more infomation please goto: https://github.com/junegunn/vim-plug
call plug#begin()
"   nerdtree
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
"   auto-pairs: auto pair the coupled signs e.g. (), [], {}
Plug 'jiangmiao/auto-pairs'
"   casejump: jumps between switch cases
Plug 'vim-scripts/casejump.vim'
"   tagbar
Plug 'majutsushi/tagbar', {'on': 'TagbarToggle'}
"   AutoComplPop: auto popup completion menu when inputing
Plug 'vim-scripts/AutoComplPop'
"   localvimrc
Plug 'embear/vim-localvimrc'
"   taghighlight: highlight source code elements
Plug 'abudden/taghighlight-automirror'
"   Mark--Karkat: mark words as hlsearch does, more info :h mark.txt
Plug 'vim-scripts/Mark--Karkat'
"   vim-bufsurf: quick switch among buffers
Plug 'Qiguang/vim-bufsurf'
"   starsearch.vim: star search the visual selected word
Plug 'vim-scripts/star-search'



call plug#end()
" some plugins need python installed, about how to install python
" please see :h python-provider

" plugin related config
"   nerdtree
nmap <f8> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="right"
let NERDTreeChDirMode=2
let NERDTreeHighlightCursorline=1
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
"   auto-pairs
let g:AutoPairsFlyMode=1
"   tagbar
nmap <f7> :TagbarToggle<CR>
let g:tagbar_width=25
let g:tagbar_zoomwidth=0
let g:tagbar_left=1
let g:tagbar_sort=0
let g:tagbar_autofocus=1
highlight TagbarSignature ctermfg=67
"   taghighlight, please reference to the help doc
if ! exists('g:TagHighlightSettings')
	let g:TagHighlightSettings = {}
endif
let g:TagHighlightSettings['DisableTagManager'] = 'True'
nmap <f4> :UpdateTypesFileOnly<CR>
"   Mark--Karkat, to avoid conflit with starsearch.
" check Mark--Karkat help doc for help
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
"   bufsurf
nmap - :BufSurfBack<CR>
nmap + :BufSurfForward<CR>


" vim specified configs
if !has('nvim') 

" see usr_05.txt install matchit
if has('syntax') && has('eval')
  packadd! matchit
endif

" auto check file changing out of vim when cursor holded for 'updatetime'
set updatetime=500
au CursorHold * silent! checktime

set encoding=utf-8
" reopen the file with specified encoding
" :e ++enc=utf-8
set fileencodings=utf-8,utf-16,gbk,big5,gb180380,latin1

endif

" file type dependent configs
"
" autocmd FileType javascript nnoremap <buffer> this cmd makes the f2 follow
" the file extension 
autocmd FileType javascript,json,css,htm,html nnoremap <buffer> <f2> :gr! "<c-r><c-w>" -iFwr "." --include=*.{js,json,css,htm,html}<home><c-right><c-right> | vnoremap <buffer> <f2> y:gr! "<c-r>"" -iFr "." --include=*.{js,json,css,htm,html}<home><c-right><c-right> | nnoremap <buffer> <leader><f2> :gr! "<c-r><c-w>" -iFwr ./ --include=*.{js,json,css,htm,html}<home><c-right><c-right> | vnoremap <buffer> <leader><f2> y:gr! "<c-r>"" -iFr ./ --include=*.{js,json,css,htm,html}<home><c-right><c-right>
autocmd FileType java nnoremap <buffer> <f2> :gr! "<c-r><c-w>" -iFwr "." --include=*.java<home><c-right><c-right> | vnoremap <buffer> <f2> y:gr! "<c-r>"" -iFr "." --include=*.java<home><c-right><c-right> | nnoremap <buffer> <leader><f2> :gr! "<c-r><c-w>" -iFwr ./ --include=*.java<home><c-right><c-right> | vnoremap <buffer> <leader><f2> y:gr! "<c-r>"" -iFr ./ --include=*.java<home><c-right><c-right>
autocmd FileType c,cpp,hpp,h nnoremap <buffer> <f2> :gr! "<c-r><c-w>" -iFwr "." --include=*.{c,cpp,hpp,h}<home><c-right><c-right> | vnoremap <buffer> <f2> y:gr! "<c-r>"" -iFr "." --include=*.{c,cpp,hpp,h}<home><c-right><c-right> | nnoremap <buffer> <leader><f2> :gr! "<c-r><c-w>" -iFwr ./ --include=*.{c,cpp,hpp,h}<home><c-right><c-right> | vnoremap <buffer> <leader><f2> y:gr! "<c-r>"" -iFr ./ --include=*.{c,cpp,hpp,h}<home><c-right><c-right>

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
