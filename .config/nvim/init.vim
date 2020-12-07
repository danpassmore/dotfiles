set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

" let Vundle manage Vundle, required
"Plug 'VundleVim/Vundle.vim'

" Javascript stuff 
"Plug 'ternjs/tern_for_vim'
"Plug 'pangloss/vim-javascript'

" json stuff 
Plug 'elzr/vim-json'

" colorscheme stuff 
Plug 'joshdick/onedark.vim'

" usability stuff 
Plug 'tpope/vim-unimpaired'
Plug 'itchyny/lightline.vim'
Plug 'milkypostman/vim-togglelist'

""""Plug 'scrooloose/nerdtree'
""""Plug 'majutsushi/tagbar'
""""Plug 'vim-airline/vim-airline'

Plug 'vim-scripts/DoxygenToolkit.vim'
""""Plug 'mileszs/ack.vim'

Plug 'ngemily/vim-vp4'
Plug 'nfvs/vim-perforce'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'



" language-server-protocol stuff
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

""""Plug 'neoclide/coc.nvim', {'branch': 'release'}
""""Plug 'vim-syntastic/syntastic'
""""Plug 'w0rp/ale'
""""Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh', }

" Initialize plugin system
call plug#end()

" ----------------------------------------
" ------- General Purpose Settings -------
" ----------------------------------------
filetype plugin indent on

colorscheme desert
if &t_Co > 2 || has("gui_running")
  syntax on
endif
if &t_Co == 256
  if globpath(&runtimepath, 'colors/onedark.vim', 1) !=# ''
    colorscheme onedark
  endif
endif

" enable mouse support (primarily for resizing windows 
set mouse=a

" make backspace in insert mode only work on certain characters
set backspace=indent,eol

" Allows buffers to remain open when not in the foreground.
set hidden

" Enhance command-line completion
set wildmenu

" Optimize for fast terminal connections
set ttyfast

" --  This was failing for some reason in neovim and I don't want to debug further --
" Centralize backups, swapfiles and undo history
"if !isdirectory($HOME."/.local/share/nvim/backups")
"  call mkdir($HOME."/.local/share/nvim/backups", "p")
"endif
"set backupdir=$HOME/.local/share/nvim/backups//
"
"if !isdirectory($HOME."/.local/share/nvim/swaps")
"  call mkdir($HOME."/.local/share/nvim/swaps", "p")
"endif
"set directory=$HOME/.local/share/nvim/swaps//

" Highlight current line
set cursorline

" Set the default tab/indentation widths
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" default textwidth
set textwidth=120
set colorcolumn=+1

" Enable line numbers
set number
set relativenumber

" Show “invisible” characters
"set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
"set list

" Highlight searches
set hlsearch
" Highlight dynamically as pattern is typed
set incsearch

" Ignore case of searches
set ignorecase

" Always show status line
set laststatus=2

" Don’t reset cursor to start of line when moving around.
set nostartofline

" Show the cursor position
set ruler

" Don’t show the intro message when starting Vim
set shortmess=atI

" Show the filename in the window titlebar
set title

" Show the (partial) command as it’s being typed
set showcmd

" Start scrolling x lines before the horizontal window border
set scrolloff=7

" Search options
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*/.git/*     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe               " Windows

" Use rg or ag over grep
if executable('rg')
  set grepprg=rg\ --vimgrep
elseif executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

"makes text show up at cursor as you cycle through PUM options
set completeopt+=preview                     

" describe how spacing works in source files
autocmd FileType c,cpp setlocal comments=s:/*,mb:\ ,ex-2:*/,://

" trim whitespace whenever we're saving certain kinds of source files
fun! TrimWhitespace()
    let l:save = winsaveview()
    %s/\s\+$//e
    call winrestview(l:save)
endfun
autocmd FileType c,cpp,java,php autocmd BufWritePre <buffer> call TrimWhitespace()

function! IwhiteToggle()
  if &diffopt =~ 'iwhite'
    set diffopt-=iwhite
    echo "all significant"
  else
    set diffopt+=iwhite
    echo "ignore whitespace"
  endif
endfunction

" ----------------------------------------
" --------- Vim Plugin Settings ----------
" ----------------------------------------
"
" ------- vim-lsp plugin settings ---------
let g:lsp_signs_enabled = 1           " enable signs
let g:lsp_diagnostics_echo_cursor = 1 " enable echo under cursor when in normal mode
let g:lsp_textprop_enabled = 0
let g:lsp_highlights_enabled = 1
let g:lsp_virtual_text_enabled = 0
" makes all versions of symbol under cursor highlight as yellow
let g:lsp_highlight_references_enabled = 1
highlight lspReference ctermfg=lightyellow ctermbg=none

"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('/tmp/vim-lsp.log')

        "\ 'cmd': {server_info->['clangd', '--background-index', '-j=8', '--query-driver=/pkg/qct/software/hexagon/releases/tools/8.3.05/Tools/bin/*','-resource-dir=/pkg/qct/software/hexagon/releases/tools/8.3.05/Tools/bin']},
if executable('clangd')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '--background-index=true', '-j=8', '--pch-storage=disk']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

if 0 "executable('ccls')
  au User lsp_setup call lsp#register_server({
        \ 'name': 'ccls',
        \ 'cmd': {server_info->['ccls']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': {},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
        \ })
endif


"------ asyncomplete.vim plugin options --------
let g:asyncomplete_auto_popup = 1            "makes the PUM pop up automatically as you type symbols
let g:asyncomplete_popup_delay = 1 "in ms    "sets the delay for the above


" ------- lightline plugin settings ---------
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left':  [ [ 'mode', 'paste' ],
      \              [ 'readonly', 'filename2', 'modified'],['curfunc'] ],
      \   'right': [ [ 'filetype'],
      \              [ 'percent' ],
      \              [ 'lineinfo'] ]
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B',
      \   'filename2': '%<%f'
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFileName',
      \   'curfunc': 'ShowFuncName'
      \ },
      \ }

" not used currently but represent an alternative to 'filename2'
function! LightlineFileName()
  let root = getcwd()
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

function! ShowFuncName()
  return getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bWn'))
endfunction

" ------- 'milkypostman/vim-togglelist' settings ----- 
" gets rid of default mappings
let g:toggle_list_no_mappings = 1
" specify which command you want to use to open a quickfix list(in case you are using some plugin)
let g:toggle_list_copen_command="copen"


" ------- fzf plugin settings ---------
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --threads 24 --fixed-strings -g "!*.{config,git,html,elf,map,sym,code_coverage,node_modules}" -g "!{html,node_modules,code_coverage,tags,elf,map,sym}/*" -g "*.{yml,py,cpp,c,h,cc,S,scons,gscons,api,pl,pm,pyc,sh,bat}" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)


" ------- gCtrlP plugin settings ---------
let g:ctrlp_extensions = ['tag', 'mixed']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" ------- NERDtree plugin settings -------
" How to close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"let NERDTreeQuitOnOpen=1

" ------ TagBar Plugin settings -------
let g:tagbar_compact = 1
" prevents line highlights in the tagbar window.  Without this line it can
" slow down considerably
autocmd FileType tagbar setlocal nocursorline nocursorcolumn


" ------ DoxygenToolkit Plugin settings -------
let g:DoxygenToolkit_returnTag = "@return"
let g:DoxygenToolkit_briefTag_pre = "@brief"
let g:DoxygenToolkit_startCommentTag = "/*!"
let g:DoxygenToolkit_startCommentBlock = "/*"
let g:DoxygenToolkit_interCommentTag = " "
let g:DoxygenToolkit_interCommentBlock = "%"
let g:DoxygenToolkit_endCommentTag = "\b*/"
let g:DoxygenToolkit_endCommentBlock = "\b*/"

" ------- ack.vim plugin settings -------
if executable('rg')
  let g:ackprg = 'rg --column --no-heading'
  "nnoremap <leader>s :Ack -g '*.{c,h,cc,cpp,scons,gscons,api,sh,py,yml,S,json}' -w <cword> 
  nnoremap <leader>s :grep! -g '*\.{c,h,cpp,cc,scons,gscons,api,sh,py,yml,S,json}' -w <cword> 
elseif executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
  " Quick reference finding
  nnoremap <leader>s :Ack -G '\.(c\|cpp\|cc\|h)\b' -w <cword> 
else
  nnoremap <leader>s :Grep -G '\.(c\|cpp\|cc\|h)\b' -w <cword> 
endif

" ------- 'ngemily/vim-vp4' plugin settings -------
let g:vp4_prompt_on_write = 0

" ------- 'nfvs/vim-perforce' plugin settings -------
let g:perforce_use_relative_paths = 0
let g:perforce_open_on_change = 0
let g:perforce_open_on_save = 1
let g:perforce_prompt_on_open = 1


"------------------------------------------
"              Key Maps
"------------------------------------------

" use <leader>q to close buffer (will never exit vim)
nnoremap <leader>x :bp<bar>sp<bar>bn<bar>bd<CR>

" open modem_proc/build/ms/build-log.txt (or build.log) in quickfix and jump to first error
nnoremap <leader>eg :cf modem_proc/build/ms/build_client.log<CR>:bd<CR>:copen<CR>/<bar> \(fatal \)\?error:\<bar>undefined reference to\<bar>Fatal: <CR>
nnoremap <leader>ec :cf modem_proc/build/ms/build.log<CR>:bd<CR>:copen<CR>/<bar> \(fatal \)\?error:\<bar>undefined reference to\<bar>Fatal: <CR>
nnoremap <leader>er :cf modem_proc/build/ms/build_sdx55.rmtefs.test.log<CR>:bd<CR>:copen<CR>/<bar> \(fatal \)\?error:\<bar>undefined reference to\<bar>Fatal: <CR>

" save with leader w
nnoremap <leader>w :w<CR>

" ------- 'milkypostman/vim-togglelist' maps ----- 
nnoremap <script> <silent> <leader>l :call ToggleLocationList()<CR>:wincmd p<CR>
nnoremap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>:wincmd p<CR>

" ------- NERDtree plugin maps -------
" make ctrl-n open the NERDTree
map <c-n> :NERDTreeFind<CR>
map <leader>n :NERDTreeToggle<CR>

" ------- fzf plugin maps ---------
nnoremap <leader>o :Files modem_proc/rf<CR>
nnoremap <leader>a :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>/ :Lines<CR>
nnoremap <leader>c :Commands<CR>

" ------- lsp plugin maps ---------
nnoremap sd :LspDefinition<CR>
nnoremap sr :LspRename<CR>
nnoremap ss :LspReferences<CR>
nnoremap sj :LspNextReference<CR>
nnoremap sk :LspPreviousReference<CR>
nnoremap sh :LspHover<CR>
nnoremap sp :LspPeekDefinition<CR>
nnoremap <leader>de :LspDocumentDiagnostics<CR>
nnoremap <leader>dj :LspNextError<CR>
nnoremap <leader>dk :LspPreviousError<CR>
nnoremap <leader>ds :LspDocumentSymbol<CR>
nnoremap <leader>df :LspCodeAction<CR>



" ------ maps for diff mode -------
nnoremap cj ]c
nnoremap ck [c

" ------ TagBar Plugin settings -------
map <leader>t :TagbarToggle<CR>

" make J and K do half page down and half page up
noremap J <C-d>
noremap K <C-u>
noremap M J

" make shift-u do redo
noremap U <C-r>

" make tab fill in for jump forward and jump back
noremap <tab> <C-o>
noremap <S-tab> <C-i>

" ------ Completion Pop Up Menu (PUM) settings ------
"makes tab cycle down through PUM options or open the PUM if not already open
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : asyncomplete#force_refresh()  
"makes shift-tab cycle up through PUM options
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"                             
"makes <CR> (enter key) select the PUM item
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"                             

" diff mode options shortcuts
nmap ds :call IwhiteToggle()<CR>

" copy-paste shortcuts
if executable('xclip')
  vnoremap <leader>y "+y
  vnoremap <leader>d "+d
  vnoremap <leader>p "+p
  vnoremap <leader>P "+P
  nnoremap <leader>y "+y
  nnoremap <leader>d "+d
  nnoremap <leader>p "+p
  nnoremap <leader>P "+P
else
  vnoremap <leader>y "*y
  vnoremap <leader>d "*d
  vnoremap <leader>p "*p
  vnoremap <leader>P "*P
  "nnoremap <leader>y "*y
  "nnoremap <leader>d "*d
  "nnoremap <leader>p "*p
  "nnoremap <leader>P "*P
endif

" P4 mappings
nnoremap <leader>pe :P4edit<CR>
nnoremap <leader>pa :Vp4Add<CR>
nnoremap <leader>pr :Vp4Revert<CR>
nnoremap <leader>pd :Vp4Diff<CR>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" ----- make sure this is at the bottom!!! -----------
" use space as vim <leader> but have it show up as "\" with showcmd on
let mapleader="\\"
map <Space> <leader>

