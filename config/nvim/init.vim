" -- Plugins --
call plug#begin('~/.nvim/plugged')

Plug 'Shougo/deoplete.nvim'

if has('win32') || has('win64')
"  Plug 'tbodt/deoplete-tabnine', { 'do': 'powershell.exe .\install.ps1' }
else
"  Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
endif

Plug 'FooSoft/vim-argwrap'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' }
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'nvim-neotest/neotest'
Plug 'olimorris/neotest-rspec'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'nvim-tree/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-rails'
Plug 'folke/trouble.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'dm1try/golden_size'
Plug 'xiyaowong/virtcolumn.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'lukas-reineke/lsp-format.nvim'

Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'github/copilot.vim'

call plug#end()

" -- don't use nvim ruby gems --
unlet $GEM_HOME

lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require("neotest").setup({
  quickfix = {
    enabled = false
  },
  discovery = {
    filter_dir = function(name, rel_path, root)
      return name ~= "node_modules"
    end,
  },
  adapters = {
    require('neotest-rspec')({
      rspec_cmd = function()
        return vim.tbl_flatten({
          "bundle",
          "exec",
          "rspec",
        })
      end
    }),
  }
})

require("catppuccin").setup({
    flavour = "mocha",
    highlight_overrides = {
        all = function(colors)
            return {
                ALEVirtualTextError = { fg = colors.surface2 },
                ALEVirtualTextWarning = { fg = colors.surface2 },
                ALEVirtualTextInfo = { fg = colors.surface2 },
                ALEVirtualTextStyleError = { fg = colors.surface2 },
                ALEVirtualTextStyleWarning = { fg = colors.surface2 },
            }
        end,
    },
    integrations = {
        gitgutter = true,
        telescope = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

require('gitsigns').setup()
require("lsp-format").setup {}

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.rubocop.with({
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
        }),
        null_ls.builtins.formatting.rubocop.with({
            command = "bundle",
            args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.formatting.rubocop._opts.args),
        }),
    },
    on_attach = require("lsp-format").on_attach
})

require('trouble').setup({auto_open = true, auto_close = true})
EOF

lua << EOF
local function ignore_by_buftype(types)
  local buftype = vim.api.nvim_buf_get_option(0, 'buftype')
  for _, type in pairs(types) do
    if type == buftype then
      return 1
    end
  end
end

local golden_size = require("golden_size")
-- set the callbacks, preserve the defaults
golden_size.set_ignore_callbacks({
  { ignore_by_buftype, {'terminal','quickfix', 'nerdtree', 'nofile'} },
  { golden_size.ignore_float_windows }, -- default one, ignore float windows
  { golden_size.ignore_by_window_flag }, -- default one, ignore windows with w:ignore_gold_size=1
})

-- textDocument/diagnostic support until 0.10.0 is released
--_timers = {}
--local function setup_diagnostics(client, buffer)
--  if require("vim.lsp.diagnostic")._enable then
--    return
--  end
--
--  local diagnostic_handler = function()
--    local params = vim.lsp.util.make_text_document_params(buffer)
--    client.request("textDocument/diagnostic", { textDocument = params }, function(err, result)
--      if err then
--        local err_msg = string.format("diagnostics error - %s", vim.inspect(err))
--        vim.lsp.log.error(err_msg)
--      end
--      local diagnostic_items = {}
--      if result then
--        diagnostic_items = result.items
--      end
--      vim.lsp.diagnostic.on_publish_diagnostics(
--        nil,
--        vim.tbl_extend("keep", params, { diagnostics = diagnostic_items }),
--        { client_id = client.id }
--      )
--    end)
--  end
--
--  diagnostic_handler() -- to request diagnostics on buffer when first attaching
--
--  vim.api.nvim_buf_attach(buffer, false, {
--    on_lines = function()
--      if _timers[buffer] then
--        vim.fn.timer_stop(_timers[buffer])
--      end
--      _timers[buffer] = vim.fn.timer_start(200, diagnostic_handler)
--    end,
--    on_detach = function()
--      if _timers[buffer] then
--        vim.fn.timer_stop(_timers[buffer])
--      end
--    end,
--  })
--end

-- require("lspconfig").ruby_ls.setup({
--   on_attach = function(client, buffer)
--     setup_diagnostics(client, buffer)
--   end,
-- })
EOF

set winminwidth=15

autocmd VimEnter * silent! Dotenv .env
" -- Plugins --
" Set the theme
colorscheme catppuccin

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
let g:airline#extensions#tabline#enabled = 0

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

let g:airline#extensions#hunks#enabled = 0
let g:airline_section_y = ''
let g:airline#extensions#ale#enabled = 0
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#whitespace#enabled = 0

" hi colorcolumn guibg='#161623'

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

nmap <CR> :lnext<CR>
nmap <leader>N :lprev<CR>

nmap <leader>cp :!echo % \| pbcopy<CR>

" FZF
noremap <c-p> :Telescope find_files<CR>
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
let $FZF_DEFAULT_COMMAND = 'ag --ignore ".git/*" --hidden -l -g ""'
let g:fzf_buffers_jump = 1
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)

" Use v to expand region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Tagbar
nmap <leader>t :lua require('neotest').run.run()<CR>
nmap <leader>T :lua require('neotest').run.run(vim.fn.expand('%'))<CR>
nmap <leader>/ :lua require('neotest').output.open()<CR>
nmap <leader>? :lua require('neotest').output.open({enter=true})<CR>
nmap <leader>; :lua require('neotest').run.attach()<CR>

" insert lines without entering insert mode
noremap <leader>o o<Esc>k
noremap <leader>O O<Esc>j

" Arg wrap
nnoremap <silent> <leader>a :ArgWrap<CR>


nnoremap <leader>{ :ALEPreviousWrap<CR>
nnoremap <leader>} :ALENextWrap<CR>

" Explore
noremap <leader>n :NERDTreeFind<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e ~/.config/nvim/init.vim<CR>
nmap <silent> <leader>sv :so ~/.config/nvim/init.vim<CR>

" Restore the enter key in the quick fix panel
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" Add a ruler at 100 characters
augroup BgHighlight
    autocmd!
    autocmd WinEnter * set colorcolumn=100
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
nmap <leader><BS> :lua vim.diagnostic.reset()<CR>
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
\   'ruby': ['rubocop'],
\}
let g:ale_ruby_rubocop_executable = 'bundle'

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
