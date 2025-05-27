set nocompatible              " be iMproved, required
 filetype off                  " required

" Have vim-plug install any plugins that are included but missing
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'
"Plug 'girishji/vimcomplete'  " only works with neovim > 0.9, which I can't get
"right now
call plug#end()

" Basic coc.nvim config
" Use <Tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>"
let g:coc_disable_startup_warning = 1

" ALE config
let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1

" vimcomplete minimal setup
"let g:vimcomplete_enable = 1  " uncomment once I get nvim > 0.9

" Enable filetype plugin indent
filetype plugin indent on
syntax on

" how many lines of history VIM remembers
set history=500

" :W sudo saves the file
" good for permission-denied error
command W w !sudo tee % > /dev/null


" beginning of cse11 vimrc

" don't wrap lines at all
set textwidth=0

" set number of lines of context (default is 0)
set so=5

" line numbers
set number

" linebreak on 80 chars
set lbr
set tw=80

""""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""
"Enable syntax highlighting
syntax enable

" highlight searched items
set hlsearch

set background=dark

" I like the default colorscheme
colorscheme default

"everything past column 80 is dark red
"let &colorcolumn=join(range(81,999),",")

"column at 80 
"let &colorcolumn="80,".join(range(120,999),",")

"highlight OverLength ctermbg=red ctermfg=white guibg=#59292
"match OverLength /\%81v.\+/

" define a highlight group, then apply it
highlight Error ctermbg = red
match Error /\%81v.\+/

" turn off error bells (sound if mistake)
set noerrorbells

" end of stuff from cse 11 vimrc


" when searching 
set ignorecase
set smartcase

" for regex, turn magic on
set magic

" show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2


"""""""""""""""""""""""""""""""'
" Text, tab, and indents
"""""""""""""""""""""""""""""""
" Use spaces
set expandtab
    
" 1 tab = 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

set ai "Auto indent
set si "Smart indent


" trying to make y and p work between vim sessions
" didn't work :'(. Left in as a warning to future me -- probably not worth
" trying this.
" set clipboard=unnamed

" show file info at bottom of vim
set ls=2
set statusline+=%<%F\ %h%m%r%=%-14.(%l,%c,%V%)\ %P

" make commenting nicer (add asterisk after enter
set formatoptions+=r


"""""""""""""""
"  MAPPINGS
""""""""""""""
" jj and jk will exit insert mode
map! jk <ESC>
map! jj <ESC>

" make tab autocomplete if in middle of word, and insert tab otherwise
"inoremap <tab> <c-r>=Smart_TabComplete()<CR>

" inserts line above cursor
nmap [<Enter> mkO<Esc>`k
" insert line at cursor
nmap <Enter> i<Enter><Esc><left>
" inserts line below cursor
nmap ]<Enter> mko<Esc>`k

" inserts space at cursor
nmap <Space> i<Space><Esc>

set pastetoggle=<F2>


"""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocompletion
"""""""""""""""""""""""""""""""""""""""""""""""""""
" filetype plugin on
" autocmd FileType python set omnifunc=python3complete#Complete
" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
" autocmd FileType c set omnifunc=ccomplete#Complete
" set omnifunc=syntaxcomplete#Complete


"""""""""""""""""""
"  Functions
"""""""""""""""""
" function! Smart_TabComplete()
"   let line = getline('.')                     " current line
" 
"   let substr = strpart(line, -1, col('.')+1)  " from the start of the current
"                                               " line to one character right
"                                               " of the cursor
"   let substr = matchstr(substr, "[^ \t]*$")   " word till cursor
"   if (strlen(substr)==0)                      " nothing to match on empty string
"     return "\<tab>"
"   endif
"   let has_period = match(substr, '\.') != -1  " position of period, if any
"   let has_slash = match(substr, '\/') != -1   " position of slash, if any
"   if (!has_period && !has_slash)
"     return "\<C-X>\<C-P>"                     " existing text matching
"   elseif ( has_slash )
"     return "\<C-X>\<C-F>"                     " file matching
"   else
"     return "\<C-X>\<C-O>"                     " plugin matching
"   endif
" endfunction
