""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colemak-Vim Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MNEI arrows.
noremap m h|noremap n j|noremap e k|noremap i l|noremap gn gj|noremap ge gk
" Undo in the same location as u
noremap l u
" Insert same place as insert.
noremap u i|noremap U I
" Last search.
noremap k n|noremap K N
" _r_ = inneR text objects.
onoremap r i
" End of word.
noremap j e|noremap J E


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other Colemak Arrow-Based Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Switch tabs.
nnoremap <C-i> <C-PageDown>|nnoremap <C-h> <C-PageUp>
" Switch panes.
noremap M <C-w>h|noremap I <C-w>l|noremap N <C-w>j|noremap E <C-w>k
" Moving windows around.
noremap <C-w>M <C-w>H|noremap <C-w>N <C-w>J|noremap <C-w>E <C-w>K|noremap <C-w>I <C-w>L
" High/Low/Mid. Note that <C-m> is equivalent to the enter key.
noremap <C-e> H|noremap <C-n> L|noremap <C-m> M
" Scroll up/down.
noremap zn <C-y>|noremap ze <C-e>
