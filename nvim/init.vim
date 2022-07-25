call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'majutsushi/tagbar'

Plug 'terryma/vim-multiple-cursors'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'tpope/vim-surround'

Plug 'airblade/vim-gitgutter'

Plug 'ryanoasis/vim-devicons'

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-commentary'

Plug 'neomake/neomake'

Plug 'sheerun/vim-polyglot'

Plug 'puremourning/vimspector'

Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }

Plug 'lotabout/skim.vim'

" Initialize plugin system
call plug#end()

" === General ===

" Cosmetic changes
let g:airline_powerline_fonts = 1
let g:airline_theme='angr'
let g:airline#extensions#tabline#enabled = 1
let g:airline_solarized_bg='dark'
colorscheme delek

set encoding=utf-8
set mouse=a

syntax on
filetype plugin indent on

" Automatic relative number
set number relativenumber

" === Keyboard mappings ===
let mapleader = ","

" Make Y behave like C or D
nnoremap Y y$
noremap H ^
noremap L $

" Disable space and backspace
noremap <Space> <nop>
noremap <BS> <nop>

" Fzf navigation
let g:fzf_command_prefix = 'Fzf'
nnoremap <leader>g <Cmd>FzfFiles<CR>
nnoremap go <Cmd>FzfGFiles<CR>
nnoremap gb <Cmd>FzfBuffers<CR>
nnoremap gh <Cmd>FzfHistory<CR>
nnoremap <C-w>/ <Cmd>FzfWindows<CR>
nnoremap <leader>rg <Cmd>FzfRg<CR>
nnoremap <leader>,<space> <Cmd>FzfMaps<CR>

" Copy and paste shortcut
nnoremap <Space>c "+yy
vnoremap <Space>c "+y
nnoremap <Space>v "+p
vnoremap <Space>v "+p

" Buffer navigation
nmap ]b :bnext<CR>
nmap [b :bprevious<CR>
nmap <leader>bd :bdelete<cr>  

" === CoC ===
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use `[g` and `]g` to navigate diagnostics
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> <Space><CR> <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nnoremap <silent> gd <Plug>(coc-definition)
nnoremap <silent> g[ <Plug>(coc-type-definition)
nnoremap <silent> gD <Plug>(coc-implementation)
nnoremap <silent> gr <Plug>(coc-references)

" Coc commands
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" " Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Use [[ to show documentation in preview window.
nnoremap <silent> [[ :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Symbol renaming.
nnoremap <leader>r <Plug>(coc-rename)

" Formatting selected code.
xnoremap <leader>f <Plug>(coc-format)
nnoremap <leader>f <Plug>(coc-format)

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dx :VimspectorReset<CR>
nnoremap <leader>de :VimspectorEval
nnoremap <leader>dw :VimspectorWatch
nnoremap <leader>do :VimspectorShowOutput

nnoremap - :Explore<CR>

let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB' ] 
