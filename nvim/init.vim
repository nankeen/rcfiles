call plug#begin()

Plug 'neovim/nvim-lspconfig'

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

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'junegunn/fzf.vim'

Plug 'hrsh7th/nvim-cmp' " Autocompletion plugin

Plug 'hrsh7th/cmp-nvim-lsp' " LSP source for nvim-cmp

Plug 'saadparwaiz1/cmp_luasnip' " Snippets source for nvim-cmp

Plug 'L3MON4D3/LuaSnip' " Snippets plugin

" Initialize plugin system
call plug#end()

" === General ===

" Cosmetic changes
let g:airline_powerline_fonts = 1
let g:airline_theme='angr'
let g:airline#extensions#tabline#enabled = 1
let g:airline_solarized_bg='dark'

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
nnoremap <leader><leader><space> <Cmd>FzfMaps<CR>

" Copy and paste shortcut
nnoremap <Space>c "+yy
vnoremap <Space>c "+y
nnoremap <Space>v "+p
vnoremap <Space>v "+p

" Buffer navigation
nmap ]b :bnext<CR>
nmap [b :bprevious<CR>
nmap <leader>bd :bdelete<cr>  

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Vimspector
let g:vimspector_enable_mappings = 'HUMAN'

nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dx :VimspectorReset<CR>
nnoremap <leader>de :VimspectorEval
nnoremap <leader>dw :VimspectorWatch
nnoremap <leader>do :VimspectorShowOutput

nnoremap - :Explore<CR>

let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB' ] 

" Required for autocompletion
set completeopt=menu,menuone,noselect

" VIM LSP
lua << EOF
-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space><cr>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader><leader>t', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader><leader>T', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', 'g[', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

require'lspconfig'.pyright.setup{
    on_attach = on_attach,
    flags = lsp_flags,
}
require'lspconfig'.tsserver.setup{
    on_attach = on_attach,
}
require'lspconfig'.rust_analyzer.setup{
    on_attach = on_attach,
}
require'lspconfig'.hls.setup{
    on_attach = on_attach,
}
require'lspconfig'.ocamllsp.setup{
    on_attach = on_attach,
}
require'lspconfig'.clangd.setup{
		on_attach = on_attach,
}

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
})
EOF
