colorscheme molokai
" search&replacement related config
set incsearch
set hlsearch
nmap / /\c
nmap ? ?\c
vmap / <ESC>/\%V\c
let s:helpList = []
function HelpString()
    let helpString = ""
    call sort(s:helpList)
    for item in s:helpList
        let helpString = helpString.item."\n"
    endfor
    echo helpString
endfunction
nmap <f1> :call HelpString()<CR>

call add(s:helpList, "F2: Global Search")
let s:filetypeTrailingList = [
    \"--include=*.{js,json,css,htm,html}", 
    \"--include=*.java", 
    \"--include=*.{c,cpp,hpp,h}",
\]
let s:filetypeTrailingDict = {
    \"javascript": s:filetypeTrailingList[0],
    \"json": s:filetypeTrailingList[0],
    \"css": s:filetypeTrailingList[0],
    \"html": s:filetypeTrailingList[0],
    \"java": s:filetypeTrailingList[1],
    \"cpp": s:filetypeTrailingList[2],
    \"c": s:filetypeTrailingList[2],
\}
function GlobalSearch(mode)
    if a:mode == "normal"
        let wordUnderCursor = expand("<cword>")
        let searchOptions = "-iFwr"
    elseif a:mode == "visual"
        let wordUnderCursor = getreg("\"")
        let searchOptions = "-iFr"
    endif
    let filetypeTrailing = get(s:filetypeTrailingDict, &filetype, "")
    let grepCmd = 'grep! "'.wordUnderCursor.'" '.searchOptions.' "%:h" '.filetypeTrailing
    let hint = ""
    \ . "Grep Flags:\n"
    \ . "  -i ignore case\n"
    \ . "  -F treat PATTERN as a fixed string but not a regex\n"
    \ . "  -w match a whole word\n"
    \ . "  -r recursively\n"
    \ . "Path to Search:\n"
    \ . "  .   CWD (".getcwd()."/)\n"
    \ . "  %:h the path of current file (".expand("%:h")."/)\n"
    \ . "  %:. in current file\n\n"
    let grepCmd = input(hint ,grepCmd)
    if grepCmd != ''
        exec("silent ".grepCmd) | cwindow
    endif
endfunction
nmap <f2> :call GlobalSearch("normal")<CR>
vmap <f2> y:call GlobalSearch("visual")<CR>
call add(s:helpList, "F3: Replacement")
function Replace(mode)
    let visualModeFlag = ''
    let wordUnderCursor = expand("<cword>")
    if a:mode == "normal"
    elseif a:mode == "visual"
        let visualModeFlag = '\%V'
    endif
    let replaceCmd = '%s/'.visualModeFlag.'\<'.wordUnderCursor.'\>/'.wordUnderCursor.'/g'
    let hint = ""
    \ . "Flags:\n"
    \ . "  i ignore case\n"
    \ . "  c ask for confirmation\n"
    \ . "Patterns:\n"
    \ . "  /toBeReplaced/Replacement/ match any occurrence\n"
    \ . "  /\<toBeReplaced\>/Replacement/ match whole word exactly\n\n"
    let replaceCmd = input(hint ,replaceCmd)
    if replaceCmd != ''
        echo "\n"
        exec(replaceCmd)
    endif
endfunction
nmap <f3> :call Replace("normal")<CR>
vmap <f3> y:call Replace("visual")<CR>

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
set showcmd   " show typing command in statusline
set noswapfile
set laststatus=2  " give a status line to every window
imap jj <ESC>
au BufEnter,FocusGained,WinEnter * silent! checktime  " check file change
set cul    " show cursorline on active window
au WinEnter * set cul
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
call add(s:helpList, "F10: Jumps to Tag in vsp Window")
call add(s:helpList, "F11: Jumps to Tag in sp Window")
call add(s:helpList, "F12: Jumps to Tag in Current Window")
map <f12> g<c-]>
vmap <f12> g<c-]>
map <f11> <c-w>g}
map <f10> :vsp<CR>:exec("tjump ".expand("<cword>"))<CR>zt

function CreateLocalVimrc()
    if filereadable(".lvimrc")
        return
    endif
    let confirmString = "In order to use ctags more conveniently\nCreate .lvimrc file in ".getcwd()."/ ?"
    let choice = confirm(confirmString, "&Yes\n&No", 1)
    if choice == 1
        let firstLine = "cd ".getcwd()
        let secondLine = "set tags=".getcwd()."/tags"
        let lvimrcContent = [firstLine, secondLine]
        call writefile(lvimrcContent, ".lvimrc")
        echo "Complete."
    else
        echo "Canceled."
    endif
endfunction
function GenTagFile()
    let confirmString = "Generate tags file for files in ".getcwd()."/ ?"
    let choice = confirm(confirmString, "&Yes\n&No", 1)
    if choice == 1
        :!ctags -f "tags" -R --extra=+f ./* 
        echo "Complete."
    else
        echo "Canceled."
    endif
endfunction
call add(s:helpList, "F9: Generate Tag File")
map <f9> :call CreateLocalVimrc() \| call GenTagFile()<CR>

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

" terminal related
call add(s:helpList, "F5: Open Terminal")
if !has('nvim') && has('terminal') 
    nmap <f5> :term ++rows=10<CR>
    tnoremap jj <C-W>N
    tnoremap <Esc> <C-W>N:q!<CR>
endif
if has('nvim') && exists(':tnoremap')
    nmap <f5> :split \| execute 'lcd '.getcwd() \| term<CR>
    tnoremap jj <C-\><C-n>
    tnoremap <Esc> <C-\><C-n>:q<CR>
    au TermOpen * resize 10
    au TermOpen * AcpDisable
endif
au BufEnter * if &buftype == 'terminal' | AcpDisable | endif
au BufLeave * if &buftype == 'terminal' | AcpEnable | endif

" plugins
"  vim-plug is needed, 
"  download vim-plug in Unix:
"  for nvim:
"   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim 
"  for vim:
"  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
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
"   commentary: gcc to comment a line, gc to comment by a motion
Plug 'tpope/vim-commentary'
"   snippet engine:
Plug 'SirVer/ultisnips'
"   snippets used by snippet engine
Plug 'honza/vim-snippets'
"   git
Plug 'tpope/vim-fugitive'
"   airline
Plug 'vim-airline/vim-airline'
"   markdown-preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug'] }

call plug#end()
" some plugins need python installed, about how to install python
" if in nvim, please see :h python-provider

" plugin related config
"   nerdtree
call add(s:helpList, "F8: Toggle NERDTree")
nmap <f8> :NERDTreeToggle<CR>
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="right"
let NERDTreeChDirMode=2
let NERDTreeHighlightCursorline=1
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
"   auto-pairs
let g:AutoPairsFlyMode=1
"   localvimrc
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0
"   tagbar
call add(s:helpList, "F7: Toggle Tagbar")
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
call add(s:helpList, "F4: Tag Highlighting")
nmap <f4> :UpdateTypesFileOnly<CR>
"   Mark--Karkat, to avoid conflit with starsearch.
" check Mark--Karkat help doc for help
nmap <Plug>IgnoreMarkSearchNext <Plug>MarkSearchNext
nmap <Plug>IgnoreMarkSearchPrev <Plug>MarkSearchPrev
"   bufsurf
nmap - :BufSurfBack<CR>
nmap + :BufSurfForward<CR>
"   airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"   markdown-preview
let g:mkdp_open_to_the_world = 1
let g:mkdp_echo_preview_url = 1
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 0

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
" for vim-jsbeautify
call add(s:helpList, "F6: Code Beautify")
autocmd FileType javascript noremap <buffer>  <F6> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <F6> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <F6> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <F6> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <F6> :call CSSBeautify()<cr>
autocmd FileType javascript vnoremap <buffer>  <F6> :call RangeJsBeautify()<cr>
autocmd FileType json vnoremap <buffer> <F6> :call RangeJsonBeautify()<cr>
autocmd FileType jsx vnoremap <buffer> <F6> :call RangeJsxBeautify()<cr>
autocmd FileType html vnoremap <buffer> <F6> :call RangeHtmlBeautify()<cr>
autocmd FileType css vnoremap <buffer> <F6> :call RangeCSSBeautify()<cr>
