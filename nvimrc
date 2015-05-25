" -- Plugins --

call plug#begin('~/.nvim/plugged')

" Autosave
Plug 'vim-auto-save'

" Editing
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'ervandew/supertab'
Plug 'Shougo/vimproc.vim'

" UI
Plug 'bling/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'ap/vim-css-color'
Plug 'AnsiEsc.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

" Theme
Plug 'tomasr/molokai'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Ruby
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'thoughtbot/vim-rspec'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'osyo-manga/vim-monster'

" Tmux
Plug 'christoomey/vim-tmux-navigator'
Plug 'jgdavey/tslime.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'

Plug 'dermusikman/sonicpi.vim'

call plug#end()

" Set the theme
colorscheme molokai


" -- Options --

" Redraw less for vroom vroom
set lazyredraw

" Encoding
set encoding=utf-8

" Linenumbers
set number
set relativenumber

" Better seaching
set hlsearch
set ignorecase
set smartcase

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

" Display command
set showcmd

" Extend our undoable steps and preserve over restart (if available)
if has('persistent_undo')
  set undodir=$TMPDIR,~/tmp,~/.vim/tmp,/tmp,/var/tmp
  set undofile
  set undoreload=10000
end
set undolevels=10000

" vim-spec options
let g:rspec_command = ':call Send_to_Tmux("spec {spec}\n")'

" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive' }

"airline
let g:airline_powerline_fonts = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"vim-auto-save
let g:auto_save = 1  " enable AutoSave
let g:auto_save_in_insert_mode = 0
let g:auto_save_silent = 0  " do not display the auto-save notification

"Command t
let g:CommandTMaxHeight = 25
let g:CommandTFileScanner = 'watchman'

" Set leader to space
nmap <space> <leader>
nmap <space><space> <leader><leader>
" xmap includes Visual mode but not Select mode (which we don't often use, but
" if we did we'd expect hitting space to replace the selected text with a
" space char).
xmap <space> <leader>


" -- Shortcuts --

" kj to exit insert mode and save
inoremap kj <Esc>:w<CR>

" format the entire file
nmap <leader>fef ggVG=

" close buffer
nmap <leader>x :q<CR>

" Command T
noremap <c-p> :FZF<CR>



" Tagbar
nmap <leader>t :TagbarToggle<CR>

" insert lines without entering insert mode
noremap <leader>o o<Esc>k
noremap <leader>O O<Esc>j

" Run specs
noremap <BS> :call RunCurrentSpecFile()<CR>
noremap \ :call RunNearestSpec()<CR>

" Explore
noremap <leader>n :NERDTreeToggle<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Restore the enter key in the quick fix panel
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Add a linemarker at 80
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set colorcolumn=80
    autocmd WinLeave * set colorcolumn=0
augroup END

" Save on focus lost
au FocusLost * silent! wa



" Set async completion.
let g:monster#completion#rcodetools#backend = "async_rct_complete"
