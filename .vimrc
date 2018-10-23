" Settings
" ==============================


" Truecolor Support
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

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
  \       ['gitbranch'],
  \       ['relativepath']
  \     ],
  \     'right': [
  \       ['lineinfo'],
  \       ['percent'],
  \       ['filetype']
  \     ]
  \   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head'
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
