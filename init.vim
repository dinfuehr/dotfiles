call plug#begin('~/.local/share/nvim/plugged')
Plug 'icyMind/NeoSolarized'
Plug 'cloudhead/neovim-fuzzy'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'weynhamz/vim-plugin-minibufexpl'
call plug#end()

" allows switching from unsaved buffer
set hidden

" use relative line numbers
set number
set relativenumber

" use perl regexes for searching
nnoremap / /\v
vnoremap / /\v

" use ctrl-p to load files
noremap <C-p> :FuzzyOpen<CR>

" switch between buffers with tab and shift-tab
nmap <tab> :bn<CR>
nmap <S-tab> :bp<CR>

" allow undo even after file was closed
set undofile

" j jumps one line down
" inconvenient for long lines
" use 'normal' j with count but gj without count
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" use , as leader
let mapleader = ","

" remove highlighting
nnoremap <leader><space> :noh<cr>

" space means :
nmap <space> :

set termguicolors
colorscheme NeoSolarized

" better completion
set wildmode=longest,list,full
set wildmenu

" show invisible characters (tabs, eol,..)
set list
set listchars=tab:▸\ ,eol:¬

