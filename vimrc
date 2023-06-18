set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
set rtp+=/root/.fzf
call vundle#begin()

" [tool]
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
"Plugin 'majutsushi/tagbar'
Plugin 'tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'Shougo/neocomplcache.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'rhysd/vim-clang-format'

" [colorscheme]
Plugin 'sickill/vim-monokai'
Plugin 'notpratheek/vim-luna'
Plugin 'altercation/vim-colors-solarized'

" [go]
Plugin 'fatih/vim-go'
"Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'buoto/gotests-vim'

Plugin 'rking/ag.vim'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
Plugin 'wsdjeg/FlyGrep.vim'

Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'tbastos/vim-lua'

"Plugin 'ctrlpvim/ctrlp.vim'
"Plugin 'Chun-Yang/vim-action-ag'
"Plugin 'Yggdroot/LeaderF', { 'do': '.\install.bat' }

" [cpp]
"Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'vim-scripts/a.vim'
"Plugin 'SirVer/ultisnips'
"""go to define test
"Plugin 'chxuan/cpp-mode'

" [csharp]
"Plugin 'Chiel92/vim-autoformat'
"Plugin 'OmniSharp/omnisharp-vim'
"Plugin 'dispatch.vim'
"Plugin 'dense-analysis/ale'

" [other]
"Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
"Plugin 'rdnetto/YCM-Generator'

call vundle#end()
filetype plugin indent on
" [bookmark]
let g:bookmark_sign = '☰'
"" avoid nerdtree and bookmark conflic
let g:bookmark_no_default_key_mappings = 1
function! BookmarkMapKeys()
    nmap mm :BookmarkToggle<CR>
    nmap mi :BookmarkAnnotate<CR>
    nmap mn :BookmarkNext<CR>
    nmap mp :BookmarkPrev<CR>
    nmap ma :BookmarkShowAll<CR>
    nmap mc :BookmarkClear<CR>
    nmap mx :BookmarkClearAll<CR>
    nmap mkk :BookmarkMoveUp
    nmap mjj :BookmarkMoveDown
endfunction
function! BookmarkUnmapKeys()
    unmap mm
    unmap mi
    unmap mn
    unmap mp
    unmap ma
    unmap mc
    unmap mx
    unmap mkk
    unmap mjj
endfunction
autocmd BufEnter * :call BookmarkMapKeys()
autocmd BufEnter NERD_tree_* :call BookmarkUnmapKeys()

" [tagbar]
let g:tagbar_ctags_bin = 'ctags'
let g:tagbar_width = 25
let g:Lf_ShortcutF = '<C-P>'
let g:tagbar_autofocus = 1
"map <c-[> g]
map <C-j> :Tagbar<CR>
"map <C-j> :!ctags -R<CR>
" list all ctags

" [nerdtree]
let NERDTreeWinPos = 'left'
let NERDTreeWinSize = 25
let NERDTreeIgnore = ['\.pyc']
map <C-u> :NERDTreeToggle<CR>

" [tab]
map <C-l> :tabn<CR>
map <C-k> :tabnew<CR>

" [buffer]
map <C-n> :bnext<CR>
map <C-b> :bprevious<CR>
" Close the current buffer and move to the previous one
" " This replicates the idea of closing a tab
map <C-w> :bp <BAR> bd #<CR>

" [fzf]
map <C-p> :Files<CR>
nnoremap <silent> <Leader>a :Ag<CR>

" [airline]
let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 0

" [cpp build]
map <C-a> :call CppBuild()<CR>
function CppBuild()
    execute "!g++ % -Wall -std=c++11 -ggdb -gdwarf-2 -o %<"
endfunction

" [Ag]
""map <C-r> :norm yiw<CR>:Ag! --go -t -w "<C-R>""
map <C-r> :norm yiw<CR>:Ag --ignore-dir={robot,ntools,pb} --go -w "<C-R>"" <CR>

map <C-x> :norm yiw<CR>:/\<<C-R>"\>

"nnoremap <silent> <leader>g :vimgrep/<C-R><C-W>/**/*.go <CR> :cw <CR>
""map <C-g> :norm yiw<CR>:/<C-R>"

" [terminal]
"map <C-g> :vs ter ++rows=10<CR>
map <C-g> :vert ter<CR>
"map <C-g> :vertical topright terminal<CR>
"map <C-g> :vert copen<CR>

" [cpp format]
"let g:formatdef_my_cpp = '"astyle --style=attach --pad-oper --lineend=linux"'
"let g:formatters_cpp = ['my_cpp']
"au BufWrite * :Autoformat

" [ycm]
"let g:ycm_gopls_args = ['-remote=auto']
"let g:ycm_gopls_binary_path = [$GOPATH.'/gopls']
"
" <<<close function prompt>>>
"let g:ycm_auto_hover='' 
"let g:ycm_semantic_triggers =  {
"  \   'go' : ['.' , 're!\w{2}'],
"  \ }

" <<<ycm remove>>>
"let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_confirm_extra_conf=0
"let g:ycm_collect_identifiers_from_comments_and_strings = 1
"let g:ycm_complete_in_strings=1
"map <C-i> :GoToFunImpl<CR>

"function GotoDefine()
"    redir => s:messages
"    execute "YcmCompleter GoToDefinition"
"    redir END
"    let s:lastmsg=get(split(s:messages, "\n"), -1, "")
"    if s:lastmsg >= "RuntimeError: Can't jump to definition."
"        "echo "fail"
"        execute "YcmCompleter GoToDefinitionElseDeclaration"
"        execute "GoToFunImpl"
"    endif
"
"endfunction
"map <c-]> :call GotoDefine()<CR>

" [golang]
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"let g:go_fmt_command = "goimports"
"let g:go_def_mode='gopls'
"let g:go_info_mode='gopls'

" auto save
"let g:go_referrers_mode='gopls'
"let g:go_metalinter_autosave = 1
"let g:go_metalinter_enabled = ['errcheck']

" vim-go
"let g:go_gopls_options = ['-remote=auto']
 
" vim-gotests
let g:gotests_template_dir = ''
let g:gotests_template = ''

let mapleader = ","
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test -v *.go)
"au FileType go nmap <leader>c <Plug>(go-coverage)
"au FileType go nmap <leader>e :GoReferrers<CR> 
au FileType go nmap <leader>e :GoReferrers <CR> 
au FileType go nmap <leader>tf :GoTests<CR>
au FileType go nmap <leader>ta :GoTestsAll<CR>
"au FileType go nmap <leader>gr:GoRename<CR> 

"au FileType go nmap <leader>w :GoImports<CR>
au FileType go nmap <leader>s <Plug>(go-implements)

" [protobuff]
au FileType go nmap <leader>pb :ClangFormat<CR>

" [quickfix]
au FileType go nmap <leader>w :ccl <CR>
au FileType go nmap <leader>cn :cn <CR>
au FileType go nmap <leader>cp :cp <CR>
au FileType go nmap <leader>q :lclose <CR>
au FileType go nmap <leader>ln :lnext <CR>
au FileType go nmap <leader>lp :lprev <CR>

" [csharp]
"let g:OmniSharp_server_use_mono = 0  " Use mono self
"let g:OmniSharp_server_stdio = 1
"let g:OmniSharp_highlight_types = 3
"
"let g:formatdef_my_custom_cs = '"astyle --mode=cs --style=ansi -pcHs4"'
"let g:formatters_cs = ['my_custom_cs']
"let g:ale_linters = {
"\ 'cs': ['OmniSharp']
"\}
""let g:OmniSharp_selector_ui = 'unite'  " Use unite.vim
"let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim
"let g:OmniSharp_selector_ui = 'fzf'    " Use fzf.vim
"let g:OmniSharp_selector_ui = ''       " Use vim - command line, quickfix etc.
"
"let g:ycm_show_diagnostics_ui = 0 
"map <c-]> :OmniSharpGotoDefinition<CR>

" [ale]
" let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_insert_leave = 0
"let g:ale_lint_on_enter = 0
"let g:ale_lint_on_save = 0

" [lua]
au BufNewFile,BufRead *.lua.txt set filetype=lua

" [markdown]
let g:vim_markdown_folding_disabled = 1

" [clang-format]
"autocmd BufWritePre *.proto :ClangFormat
"
"
" [basic]
syntax on
syntax enable

set completeopt=longest,menu
set cscopequickfix=s-,c-,d-,i-,t-,e-
"set number
set ruler
set tabstop=4
set softtabstop=4
set shiftwidth=4
set ts=4
set expandtab
set cindent
set novisualbell
set laststatus=2
set cinoptions=g0
set hlsearch
set incsearch
set ic
set maxmempattern=10000
" 设置下方分割
" set nosplitright 
" set splitbelow

nnoremap <space> za

" [colorscheme]
set t_Co=256
set background=dark
"colorscheme SolarizedDark
colorscheme luna-term

