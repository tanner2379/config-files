"system wide install
let g:nvim_system_wide = 1
"------------------------------------------------
" Plugins START
call plug#begin()
  Plug 'airblade/vim-gitgutter'
  Plug 'cespare/vim-toml'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'itchyny/lightline.vim'
  Plug 'jparise/vim-graphql'
  Plug 'junegunn/vim-easy-align'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'lifepillar/vim-gruvbox8'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'mengelbrecht/lightline-bufferline'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/coc-prettier', { 'do': 'yarn install --frozen-lockfile' }
  Plug 'pangloss/vim-javascript'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'tpope/vim-commentary'
call plug#end()
" Plugins END
"------------------------------------------------
"------------------------------------------------
" Recognize Typescript
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescriptreact
" End Recognize Typescript
" -----------------------------------------------
"------------------------------------------------
" Settings START
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR> 
inoremap jk <ESC>
let mapleader = "'"
filetype plugin indent on
set completeopt=menuone
set mouse=a
set nobackup
set nocompatible
set noswapfile
set nowritebackup
set number
set signcolumn=yes
set title
set wrap
setlocal wrap
set hlsearch
set incsearch
syntax on
" Settings END
"------------------------------------------------
"------------------------------------------------
" persist START
set undofile " Maintain undo history between sessions
set undodir=~/.vim/undodir

" Persist cursor
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif
" persist END
"------------------------------------------------
"------------------------------------------------
" resync buffer in React files
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
" resync end
" -----------------------------------------------
"------------------------------------------------
" Theme START
syntax on
set termguicolors
set cursorline
set cmdheight=1
set laststatus=2
set tabstop=2
set shiftwidth=2
set expandtab
" -----------------------------------------------
" GRUVBOX
" -----------------------------------------------
colorscheme gruvbox8
set background=dark


let g:gruvbox_transp_bg = 1
let g:gruvbox_italicize_strings = 0

set list
set listchars=tab:»·,trail:·

" let buffers be clickable
let g:lightline#bufferline#clickable=1
let g:lightline#bufferline#shorten_path=1
let g:lightline#bufferline#min_buffer_count=1

let g:lightline = {
\  'colorscheme': 'jellybeans',
\  'active': {
\    'left': [ [], [], [ 'relativepath' ] ],
\    'right': [ [], [], [ 'lineinfo', 'percent' ] ]
\  },
\  'inactive': {
\    'left': [ [], [], [ 'relativepath' ] ],
\    'right': [ [], [], [ 'lineinfo', 'percent' ] ]
\  },
\  'subseparator': {
\    'left': '', 'right': ''
\  },
\  'tabline': {
\    'left': [ ['buffers'] ],
\    'right': [ [] ]
\  },
\  'tabline_separator': {
\    'left': "", 'right': ""
\  },
\  'tabline_subseparator': {
\    'left': "", 'right': ""
\  },
\  'component_expand': {
\    'buffers': 'lightline#bufferline#buffers'
\  },
\  'component_raw': {
\    'buffers': 1
\  },
\  'component_type': {
\    'buffers': 'tabsel'
\  }
\}

" Theme END
"------------------------------------------------

"------------------------------------------------
" Remaps START
" Align GitHub-flavored Markdown tables
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

" Toggle between buffers
nmap <Leader>bn :bn<CR>
nmap <Leader>bp :bp<CR>
nnoremap <C-p> :Files<Cr>
nnoremap <C-e> :Ag<Cr>
nmap <Leader>bl :Buffers<CR>
nmap <Leader>g :GFiles<CR>
nmap <Leader>e :Ag<CR>
nmap <Leader>p :Files<CR>
nmap <Leader>g? :GFiles?<CR>
nmap <Leader>H :History<CR>

" Buffer movement
nnoremap bh :bfirst<CR>
nnoremap bj :bprev<CR>
nnoremap bk :bnext<CR>
nnoremap bl :blast<CR>
nnoremap bd :bd<CR>
nnoremap bo :%bd\|e#<CR>

" easier end of line
nmap 9 $
" save with CTRL+S
inoremap <C-s> <ESC>:w<CR>
nnoremap <C-s> :w<CR>
vnoremap <C-s> <ESC>:w<CR>
" move with alt
nnoremap <M-Up> ddkP
nnoremap <M-Down> ddp
vnoremap <M-Up> dkP
vnoremap <M-Down> dp
" unhighlight with Space
nnoremap <Space> :noh<CR>
" remap screen movement keys to shift
nnoremap E <C-e>
nnoremap Y <C-y>
" create an empty line above or below in normal mode
nnoremap s o<ESC>
nnoremap S O<ESC>
"make < > shifts keep selection
vnoremap < <gv
vnoremap > >gv

" snippets
inoremap rhn  <ESC>:execute "r /home/tanner/.config/nvim/snippets/rhn.tsx"<CR>kdd
inoremap rhp  <ESC>:execute "r /home/tanner/.config/nvim/snippets/rhp.tsx"<CR>kdd

" Remaps END
"------------------------------------------------

"------------------------------------------------
" Coc START
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-git', 'coc-prettier']

" eslint
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif
" eslint end
" -----------------------------------------------

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Add cursor position to multi-cursor buffer
nmap <silent> <M-d> <Plug>(coc-cursors-position)

" Select multiple words using ctrl+d like vscode
nmap <expr> <silent> <C-d> <SID>select_current_word()
function! s:select_current_word()
  if !get(b:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

" Select all cases of current word
nnoremap <C-u> :CocCommand document.renameCurrentWord<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ga  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" list diagnostics
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

" ---------------------------------------------------------
"  GitGutter
" ---------------------------------------------------------
"let g:gitgutter_dif_relative_to = 'working_tree'
nmap <Leader>hv :GitGutterPreviewHunk<CR>
nmap <Leader>hu :GitGutterUndoHunk<CR>
nmap ]h :GitGutterNextHunk<CR>
nmap [h :GitGutterPrevHunk<CR>

" ---------------------------------------------------------
"  CoCExplorer
" ---------------------------------------------------------
nmap <Leader>n :CocCommand explorer<CR>
