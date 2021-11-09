"-----------------------------------------------------------------------------------
" GLOBAL SETTINGS
syntax on
set nocompatible
set cursorline
set noerrorbells
set tabstop=4 softtabstop=4
set expandtab
set smartindent
set nu
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undo
set undofile
set incsearch
set hlsearch
set fileformat=unix
set nobinary
set encoding=UTF-8
set formatoptions=jql
set mouse=a
set guicursor+=a:blinkon1

packadd termdebug

" detect os and set shell accordingly
let _os = system('if [[ $OSTYPE == "linux-gnu"* ]]; then echo "linux"; else echo "macos"; fi')
if _os == "linux"
    set shell=/bin/zsh
elseif _os == "macos"
    set shell=/usr/bin/zsh
endif

" Use a blinking upright bar cursor in Insert mode, a blinking block in normal
if &term == 'xterm-256color' || &term == 'screen-256color'
    let &t_SI = "\<Esc>[5 q"
    let &t_EI = "\<Esc>[1 q"
endif

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

"-----------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------
" KEYMAPINGS

" Ctrl+S to save
noremap  <silent> <C-S> :w<CR>
vnoremap <silent> <C-S> <C-C>:w<CR>
inoremap <silent> <C-S> <C-O>:w<CR>

" Ctrl+Z to undo
nnoremap <C-Z> u
inoremap <C-Z> <Esc>ui

" Ctrl+Y to redo
nnoremap <C-Y> <C-R>
inoremap <C-Y> <Esc><C-R>i

" Alt + Arrows to skip words
nnoremap <A-Left> <C-Left>
nnoremap <A-Right> <C-Right>

" Ctrl+Alt+N and Ctrl+N to enter normal mode (habit from VSCode)
nnoremap <C-N> <NOP>
inoremap <C-N> <Esc>
nnoremap <C-A-N> <NOP>
inoremap <C-A-N> <Esc>

" Ctrl+L to enter normal mode
nnoremap <C-L> <NOP>
inoremap <C-L> <Esc>

" Ctrl + B to toggle nerdtree
nmap <C-B> :NERDTreeToggle<CR>


" Alt+t to toggle terminal
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>
tnoremap <Esc> <C-\><C-n>
" tnoremap <C-W> <C-\><C-n><C-W>

" Unmap some stuff cus they're annoying
inoremap <C-A> <NOP>
nnoremap <s> <NOP>

"-----------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------
" PLUGINS
call plug#begin("~/.vim/plugged")

Plug 'sainnhe/sonokai'                      " color scheme
" Plug 'ghifarit53/tokyonight-vim'            " color scheme
" Plug 'joshdick/onedark.vim'                 " color scheme
" Plug 'phanviet/vim-monokai-pro'             " color scheme
" Plug 'morhetz/gruvbox'                      " color scheme

Plug 'Valloric/YouCompleteMe'               " auto-complete
Plug 'jiangmiao/auto-pairs'                 " auto-type bracket pairs
Plug 'luochen1990/rainbow'                  " colorize bracket pairs
Plug 'sheerun/vim-polyglot'                 " language pack
Plug 'preservim/nerdtree'                   " file explorer
Plug 'ryanoasis/vim-devicons'               " file icons
Plug 'vim-airline/vim-airline'              " statusline
Plug 'vim-airline/vim-airline-themes'       " statusline themes
Plug 'lukas-reineke/indent-blankline.nvim'  " indent guide
Plug 'junegunn/fzf'                         " file finder
" Plug 'vimsence/vimsence'                    " lol

call plug#end()
"-----------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------
" COLOR SCHEME

set termguicolors
let g:sonokai_style = "shusia"
let g:airline_theme = "sonokai"
let g:sonokai_disable_italic_comment = 1
colorscheme sonokai

" set termguicolors
" colorscheme tokyonight
" let g:tokyonight_style = 'night'
" let g:tokyonight_enable_italic = 1

" colorscheme gruvbox
" set bg=dark

" set termguicolors
" colorscheme monokai_pro
" let g:lightline = {
" \   'colorscheme': 'monokai_pro'
" \}

" colorscheme onedark
" let g:airline_theme = 'onedark'
" let g:lightline = {
" \   'colorscheme': 'onedark'
" \}
"-----------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------
" BRACKET PAIR COLORIZING
let g:rainbow_active = 1
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#max_level = 3

" for monokai pro
let g:rainbow_conf = {
\   'guifgs': ['#ffae00', 'Orchid', 'LightSkyBlue'],
\	'separately': {
\		'nerdtree': 0,
\	}
\} 
"-----------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------
" AUTOCOMPLETE SETTINGS
set pumheight=10
set completeopt-=preview
let g:ycm_show_diagnostics_ui = 0
let g:ycm_max_num_candidates = 2 
let g:ycm_filetype_specific_completion_to_disable = {
\   'cpp': 1,
\   'c': 1
\}
"-----------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------
" TERMDEBUG SETTINGS
let g:termdebug_wide=1
"-----------------------------------------------------------------------------------


"-----------------------------------------------------------------------------------
" NERDTREE SETTINGS

" Display hidden files
let NERDTreeShowHidden=1

let g:NERDTreeSortOrder = ['foo','\/$','[[extension]]']

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) &&
    \ !exists('s:std_in') | execute 'NERDTree' argv()[0] | wincmd p |
    \ enew | execute 'cd '.argv()[0] | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" Refresh on focus
autocmd BufEnter NERD_tree_* | execute 'normal R' | execute "normal R"
"-----------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------
" STATUSLINE
let g:airline#extensions#tabline#enabled = 0

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
"-----------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------
" indent blankline
lua <<EOF
require("indent_blankline").setup {
    char = "¦",
    buftype_exclude = {"terminal"}
}
vim.wo.colorcolumn = "99999"
EOF
"-----------------------------------------------------------------------------------

"-----------------------------------------------------------------------------------
" lmao
let g:vimsence_small_text = 'NeoVim'
let g:vimsence_small_image = 'neovim'

"-----------------------------------------------------------------------------------

autocmd BufWinEnter,BufNewFile,BufRead,VimEnter,FileType,OptionSet * set formatoptions=jql
autocmd BufWinEnter,BufNewFile,BufRead,VimEnter,FileType,OptionSet * setlocal formatoptions=jql
autocmd BufRead,BufNewFile project/*.c setlocal formatoptions-=cro

autocmd VimLeave,VimLeavePre * :set guicursor=n:ver100-iCursor
autocmd VimLeave,VimLeavePre * :set guicursor+=a:blinkon1

autocmd FileChangedRO * echohl WarningMsg | echo "File changed RO." | echohl None
autocmd FileChangedShell * echohl WarningMsg | echo "File changed shell." | echohl None

autocmd BufWinEnter,WinEnter term://* startinsert
" autocmd BufLeave term://* stopinsert


