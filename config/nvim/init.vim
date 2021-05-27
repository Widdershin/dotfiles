" -- Plugins --
call plug#begin('~/.nvim/plugged')

" Editing
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'Shougo/vimproc.vim'
Plug 'FooSoft/vim-argwrap'
Plug 'osyo-manga/vim-over'
Plug 'junegunn/vim-easy-align'
Plug 'chrisbra/NrrwRgn'
Plug 'sjl/gundo.vim'
Plug 'BurntSushi/ripgrep'
Plug 'fiatjaf/neuron.vim'

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
if has('win32') || has('win64')
  Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
else
  Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
endif

" Navigation
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'

" Linting
Plug 'dense-analysis/ale'

" UI
Plug 'bling/vim-airline'
Plug 'ap/vim-css-color'
Plug 'ntpeters/vim-better-whitespace'
Plug 'roman/golden-ratio'
" Plug 'jszakmeister/vim-togglecursor'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/vim-peekaboo'

" Theme
Plug 'nanotech/jellybeans.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'jgdavey/tslime.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'sjl/vitality.vim'

" Ruby
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'thoughtbot/vim-rspec'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'osyo-manga/vim-monster'
Plug 'jgdavey/vim-blockle'
Plug 'dermusikman/sonicpi.vim'

" Elm
Plug 'ElmCast/elm-vim'

" Typescript
Plug 'leafgarland/typescript-vim'

" Rust
Plug 'rust-lang/rust.vim'

" Nix
Plug 'LnL7/vim-nix'

call plug#end()

" Set the theme
colorscheme jellybeans


" -- Options --

" No wrapping please
set nowrap

" Redraw less for vroom vroom
" set lazyredraw

" Encoding
set encoding=utf-8

" Linenumbers
set number
set relativenumber

" Better seaching
set hlsearch
set ignorecase
set smartcase

" Preview replace
set inccommand=nosplit

" 2 space tabs
set expandtab
set tabstop=2
set shiftwidth=2

" Splits
set splitright
set splitbelow

" Mouse
set mouse=a
set ttyfast
set t_Co=256

" History
set nowritebackup
set history=10000
set noswapfile
set nobackup

" Use system clipboard
set clipboard=unnamed

" Highlight long lines
set synmaxcol=512

" Watch files
set autoread

" Save on changing buffers
set autowrite

" Display command

" visual autocomplete for command menu
set wildmenu
"
" stay in the middle of the screen
set scrolloff=999
set sidescrolloff=0

" Extend our undoable steps and preserve over restart (if available)
if has('persistent_undo')
  set undodir=$TMPDIR,~/tmp,~/.vim/tmp,/tmp,/var/tmp
  set undofile
  set undoreload=10000
end
set undolevels=10000

set hidden

let g:LanguageClient_serverCommands = {
    \ 'typescript': ['/Users/nick/Projects/apm-nodejs/node_modules/.bin/typescript-language-server', '--stdio']
    \ }

" Use K to show documentation in preview window
nnoremap  K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" vim-spec options
let g:rspec_command = ':call Send_to_Tmux("spec {spec}\n")'

" airline
let g:airline_powerline_fonts = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline#extensions#hunks#enabled = 0
let g:airline_section_y = ''
let g:airline#extensions#ale#enabled = 0
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

"Navigator
let g:tmux_navigator_save_on_switch = 1

" Set leader to space
nmap <space> <leader>
nmap <space><space> <leader><leader>
" xmap includes Visual mode but not Select mode (which we don't often use, but
" if we did we'd expect hitting space to replace the selected text with a
" space char).
xmap <space> <leader>

" -- Shortcuts --

" kj to exit insert mode and save
inoremap kj <Esc>

" format the entire file
nmap <leader>fef ggVG=

" close buffer
nmap <leader>x :q<CR>

vmap <leader>s :sort<CR>

" FZF
noremap <c-p> :Files<CR>
let $FZF_DEFAULT_COMMAND = 'ag --ignore ".git/*" --hidden -l -g ""'
let g:fzf_buffers_jump = 1

" Use v to expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Tagbar
nmap <leader>t :TagbarToggle<CR>

" insert lines without entering insert mode
noremap <leader>o o<Esc>k
noremap <leader>O O<Esc>j

" Arg wrap
nnoremap <silent> <leader>a :ArgWrap<CR>

" Run specs
noremap <BS> :call RunCurrentSpecFile()<CR>

nnoremap <leader>{ :ALEPreviousWrap<CR>
nnoremap <leader>} :ALENextWrap<CR>

" Explore
noremap <leader>n :NERDTreeFind<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Restore the enter key in the quick fix panel
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Add a ruler at 80 characters
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set colorcolumn=80
    autocmd WinLeave * set colorcolumn=0
augroup END

" Save on focus lost
au FocusLost * silent! wa

au BufRead,BufNewFile *.es6 set filetype=javascript

augroup Markdown
  autocmd!
  autocmd FileType markdown set wrap
  autocmd FileType markdown set linebreak
augroup END

nmap <leader><leader> :w <cr>
nmap <leader>w :w <cr>

noremap <leader>E :e!<cr>

" Autocomplete tags
iabbrev </<leader> </<C-X><C-O>

" Add a semicolon to end of line when pressing ;
nmap ; mzA;kj`z

" Add a comma to end of line when pressing ,
nmap , mzA,kj`z

nmap <leader>9 ysiw(
nmap <leader>0 ysiw{

" Set async completion.
let g:monster#completion#rcodetools#backend = "async_rct_complete"

" Sublime style find and replace
nmap <leader>d :%s/<c-r><c-w>/<c-r><c-w>/g<Left><Left>
nmap <leader>D :s/<c-r><c-w>/<c-r><c-w>/g<Left><Left>
vmap <leader>d :s/<c-r><c-w>/<c-r><c-w>/g<Left><Left>

" Allow . in visual mode
vnoremap . :norm.<CR>

" Easy align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Folding
" set foldmethod=indent

let g:ale_completion_enabled = 0
let g:ale_lint_on_text_changed = 0
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\}

nmap <leader>h :ALEHover<CR>

let g:deoplete#enable_at_startup = 1

function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()

set completeopt-=preview
call deoplete#custom#source('ale', 'rank', 999)
autocmd FileType gitcommit  let b:deoplete_disable_auto_complete = 1

let g:node_host_prog = expand('~/.npm/bin/neovim-node-host')
let g:fzf_preview_floating_window_rate = 1

let g:fzf_layout = { 'down': '~30%' }
let g:neuron_dir = expand('~/zettelkasten/')
