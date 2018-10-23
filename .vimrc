" Settings
" ==============================

" Leader
noremap   <space>    <NOP>
let mapleader="\<space>"

" Packages
if filereadable(expand("~/.vim/plugins"))
  source ~/.vim/plugins
endif

" Clipboard
set clipboard+=unnamed

" Git Gutter
let g:gitgutter_realtime=1
set updatetime=250

" Syntax
syntax on
set background=dark
let g:onedark_termcolors=16
colorscheme onedark

" Formatting
filetype plugin indent on
set nofoldenable

" Javascript
let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

" Markdown
let g:vim_markdown_follow_anchor = 1

" Completion
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_at_startup = 1

" Search
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
set grepprg=rg\ --vimgrep
set wildignore+=*/tmp/*,*.swp,*/node_modules/*

" Lightline
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \   'active': {
  \     'left': [
  \       ['mode', 'paste'],
  \       ['relativepath']
  \     ],
  \     'right': [
  \       ['lineinfo'],
  \       ['percent'],
  \       ['filetype']
  \     ]
  \   }
  \}

set complete=.,w,t
set expandtab
set hidden
set history=50
set hlsearch
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set list listchars=tab:»·,trail:·
set nowrap
set number
set numberwidth=5
set shiftwidth=2
set showcmd       " display incomplete commands
set splitbelow
set splitright
set tabstop=2
set wildmode=list:longest,list:full
set textwidth=80
set colorcolumn=+1
set tags=tags;~
set noshowmode
set noruler

set nocompatible  " Use Vim settings, rather then Vi settings
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287

" Functions
function! StripTrailingWhitespace()
  " Don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  %s/\s\+$//e
endfun

" Auto Commands
autocmd QuickFixCmdPost *grep* cwindow
autocmd BufWritePre * call StripTrailingWhitespace()

" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']

" Rubocop and eslint autofix
autocmd FileType javascript map <silent> <buffer> <leader>p :NeomakeSh!eslint --fix %<CR>:sleep 1<CR>:e<CR>
autocmd FileType ruby map <silent> <buffer> <leader>p :NeomakeSh!rubocop --auto-correct %<CR>:sleep 1<CR>:e<CR>
autocmd! BufWritePost,BufEnter * Neomake

" Bindings
if filereadable(expand("~/.vim/bindings"))
  source ~/.vim/bindings
endif
