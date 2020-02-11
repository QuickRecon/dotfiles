"This is a vimrc made for first year students that contains the basic set of
"useful settings for a person programming with Vim.

"Settings
"Syntax
"This setting turns syntax highlighting on
syntax on

"Tab = 4 spaces
"This sets the number of visual spaces per tab character
set tabstop=4

"This sets the number of visual spaces inserted per tab charecter entered when
"editing a file
set softtabstop=4

"This setting tells vim to replace inserted tab charecters with spaces equal
"to the value of a softtabstop
set expandtab
"Don't autoexpand in make files
autocmd FileType make setlocal noexpandtab

"Line Numbers
"This setting enables absolute line numbering viewing and editing files within
"vim
set number

" Set coloring
set background=dark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Show matching brackets when text indicator is over them
set showmatch 

set ai "Auto indent
set smartindent   "does the right thing (mostly) in programs
set cindent       "stricter rules for C programs
set shiftwidth=4
set wrap "Wrap lines

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
" Map auto complete of (, ", ', [
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

set mouse=a

" Helper functions
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction
