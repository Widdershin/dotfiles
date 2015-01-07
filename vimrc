set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-obsession'
Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/matchit.zip'
Plugin 'vim-scripts/ruby-matchit'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'

Plugin 'SirVer/ultisnips'
Plugin 'Valloric/YouCompleteMe'
Plugin 'ervandew/supertab'
Plugin 'honza/vim-snippets'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'

Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'
Plugin 'kana/vim-textobj-user'
Plugin 'nelstrom/vim-textobj-rubyblock'
Plugin 'tpope/vim-rails'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'jgdavey/vim-blockle'
Plugin 'lucapette/vim-ruby-doc'

Plugin 'tpope/vim-cucumber'

Plugin 'moll/vim-node'
Plugin 'kchmck/vim-coffee-script'

"Plugin 'geekjuice/vim-spec'
Plugin 'thoughtbot/vim-rspec'
Plugin 'jgdavey/tslime.vim'
Plugin 'christoomey/vim-tmux-navigator'

Plugin 'flazz/vim-colorschemes'

Plugin 'vim-auto-save'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'sjl/vitality.vim'
Plugin 'terryma/vim-expand-region'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'djoshea/vim-autoread'
call vundle#end()            " required

"set terminal to 256 colors
set t_Co=256
color Monokai

filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"

set number
set expandtab
set modelines=0
set shiftwidth=2
set clipboard=unnamed
set synmaxcol=512
set ttyscroll=10
set encoding=utf-8
set tabstop=2
set mouse=a
set wrap
set nowritebackup
set history=1000
set noswapfile
set nobackup
set hlsearch
set ignorecase
set smartcase
set showcmd
set splitright
set splitbelow
set autoread
set relativenumber
set number
set nowrap

" Extend our undoable steps and preserve over restart (if available)
if has('persistent_undo')
  set undodir=$TMPDIR,~/tmp,~/.vim/tmp,/tmp,/var/tmp
  set undofile
  set undoreload=10000
end
set undolevels=10000

au BufNewFile * set noeol
au FocusLost * silent! wa

nmap <space> <leader>
nmap <space><space> <leader><leader>
" xmap includes Visual mode but not Select mode (which we don't often use, but
" if we did we'd expect hitting space to replace the selected text with a
" space char).
xmap <space> <leader>

" ;; to exit insert mode
inoremap kj <Esc>:w<CR>

" format the entire file
nmap <leader>fef ggVG=

" close buffer
nmap <leader>x :bd<CR>

" reload current file
nmap <leader>r :e!<CR>

" reload all open files
nmap <leader>R :tabdo bufdo e!<CR>

" reopen tests
nmap <leader>rt <c-l>:bw<CR>:AV<CR>

nmap t :CtrlP :pwd<CR>
nmap Tc :CtrlP $(:pwd)/controllers<CR>

" insert lines by cursor
noremap <leader>o o<Esc>k
noremap <leader>O O<Esc>j

" Open new buffers
nmap <leader>v  :rightbelow vsp<cr>
nmap <leader>h   :rightbelow sp<cr>

"disable nav keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Yank text to the OS X clipboard
noremap <leader>y "*y
noremap <leader>yy "*Y

" Preserve indentation while pasting text from the OS X clipboard
noremap <leader>p :set paste<CR>:put  *<CR>:set nopaste<CR>

" vim-spec
nmap <BS> :call RunCurrentSpecFile()<CR>
nmap \ :call RunNearestSpec()<CR>
nmap <CR> :call RunLastSpec()<CR>
map <leader>s :AV<CR>
map <leader>a :Dispatch bundle exec rake<CR>
map <leader>A :call Send_to_Tmux("rspec\n")<CR>
map <leader>re :call Send_to_Tmux("r\n")<CR>
map <leader>cu :call Send_to_Tmux("cucumber %\n")<CR>

let g:rspec_command = ':call Send_to_Tmux("spec {spec}\n")'
let g:mocha_js_command = ':call Send_to_Tmux("mocha --recursive {spec}\n")'
let g:mocha_coffee_command = ':call Send_to_Tmux("mocha -b --recursive --compilers coffee:coffee-script/register {spec}\n")'

" tmux shortcuts
map <leader>b :call Send_to_Tmux("bundle\n")<CR>
map <leader>c :call Send_to_Tmux("clear\n")<CR>

" NERDTree
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['tmp', '.yardoc', 'pkg', 'node_modules']

" Syntastic
let g:syntastic_mode_map = { 'mode': 'active' }

" CtrlP
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
set wildignore+=node_modules
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_max_files = 15000
let g:ctrlp_max_depth = 40

"matchit
runtime macros/matchit.vim

"airline
let g:airline_powerline_fonts = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"ruby-refactoring
noremap <leader>el :RExtractLet<CR>

"vim-auto-save
let g:auto_save = 1  " enable AutoSave

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_path_to_python_interpreter = '/usr/local/bin/python'

let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

nmap <leader>t :noautocmd vimgrep TODO **/*.rb<CR>:cw<CR>
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

augroup BgHighlight
    autocmd!
    autocmd WinEnter * set colorcolumn=80
    autocmd WinLeave * set colorcolumn=0
augroup END
