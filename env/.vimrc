syntax on
set background=dark
colorscheme badwolf

"help 'tabstop'
"help 'shiftwidth'
"help 'expandtab'
set ts=2
set sw=2
set expandtab

"autoindent option
set autoindent
set smartindent
set cindent

set ruler

"preserve-last-editing-position-in-vim
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif
