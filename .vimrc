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
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
Plugin 'ascenator/L9', {'name': 'newL9'}

"""""""""""""""""
" Plugins I added
" """""""""""""""
" Better Autocomplete
Plugin 'Valloric/YouCompleteMe'
" Syntax checking
Plugin 'scrooloose/syntastic'
" quicker commenting
Plugin 'tomtom/tcomment_vim'
" better copy-pasting
" Plugin 'svermeulen/vim-easyclip' "decided not to use because of extensive
" remaps


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

"""""""""""""""""""""""""
" End of stuff for vundle
"""""""""""""""""""""""""
" set syntax checkers for syntastic
let g:syntastic_c_checkers = ['gcc', 'make']
"let g:syntastic_enable_c_checker = 1
" vim config file
" based heavily on other vimrc's i found on the internet, as well as vimrc's
" from cse 11

" how many lines of history VIM remembers
set history=500

" :W sudo saves the file
" good for permission-denied error
command W w !sudo tee % > /dev/null


" beginning of cse11 vimrc

" wraps lines at 80 characters
set textwidth=80

" set number of lines of context (default is 0)
set so=5

" line numbers
" set relativenumber
" set number

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

" default is ron, use something different for embedded work so you can tell the
" terminals apart
try
  colorscheme ron
catch
endtry

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
    
" 1 tab = 2 spaces
set shiftwidth=2
set tabstop=2
set softtabstop=2

set ai "Auto indent
set si "Smart indent


" trying to make y and p work between vim sessions
" didn't work :'(
set clipboard=unnamed

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
