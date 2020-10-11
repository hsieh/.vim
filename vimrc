" This option has the effect of making Vim either more Vi-compatible, or
" make Vim behave in a more useful way.
set nocp

" autochdir
" When on, Vim will change the current working directory whenever you
" open a file, switch buffers, delete a buffer or open/close a window.
" It will change to the directory containing the file which was opened
" or selected.
set acd

" show number
" Same as :print, but precede each line with its line
" number.  (See also 'highlight' and 'numberwidth'
" option).
" See |ex-flags| for [flags].
set nu
" relativenumber
set rnu

" 80 colorcolumn
set cc=80

" Cursorline, Cursorcolumn Highlight the screen line of the cursor with CursorLine
set nocul nocuc

" Showcmd: Show (partial) command in the last line of the screen.  Set this
" option off if your terminal is slow.
set sc

" no wrap
set nowrap

" tabstop
set ts=2

" shiftwidth
set sw=2

" softtabstop
set sts=0

" expandtab
set et

" smarttab
set sta

" autoindent
set ai

" scrolloff
set so=4

" textwidth
set tw=0

" ttyfast, lazyredraw: should make scrolling faster
set tf
set lz

" splitright
" When on, splitting a window will put the new window right of the current one. 
set spr

" splitbelow
" When on, splitting a window will put the new window below the current one. 
set sb

" encoding
set encoding=UTF-8

" timeout ttimeout
set noto
set nottimeout

" guifont
"set guifont=DroidSansMon\ Nerd\ Font\ 11

" disable toolbar
set guioptions-=T

" disable menu
"set guioptions-=m

" Coc: TextEdit might fail if hidden is not set.
set hidden

" Coc: Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Coc: Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Coc: Don't pass messages to |ins-completion-menu|.
set shortmess+=c

if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Register vim-plug as a plugin.
Plug 'junegunn/vim-plug'

" Theme
Plug 'dracula/vim'

" Undotree
Plug 'mbbill/undotree'

" Git
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } |
                        \ Plug 'Xuyuanp/nerdtree-git-plugin' |
                        \ Plug 'ryanoasis/vim-devicons'

" Tmux
"Plug 'jgdavey/tslime.vim'
Plug 'benmills/vimux'

" status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'itchyny/lightline.vim'

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Grep
Plug 'yegappan/grep'

" Plugin for elixir
Plug 'elixir-lang/vim-elixir'

" Conquer of Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end()

" Theme
colorscheme dracula

" Run Clear
noremap <Leader>rz :call VimuxRunCommand("clear")<CR>

" Run IEx
noremap <Leader>ri :call VimuxRunCommand("clear; iex")<CR>

" Run Mix
noremap <Leader>rx :call VimuxRunCommand("clear; iex -S mix")<CR>

function! s:VimuxOpenRunner()
  source ~/.vim/script/vimux_hook.vim
  call VimuxOpenRunner() 
endfunction

noremap <Leader>rr :call <SID>VimuxOpenRunner() <CR>
let g:VimuxUseNearest=1

" Send Enter
noremap <Leader><Enter> :call VimuxSendKeys("Enter")<CR>

" Prompt for a command to run
noremap <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
noremap <Leader>vl :VimuxRunLastCommand<CR>

" Inspect runner pane
noremap <Leader>vi :VimuxInspectRunner<CR>

" Close vim tmux runner opened by VimuxRunCommand
noremap <Leader>vq :VimuxCloseRunner<CR>

" Interrupt any command running in the runner pane
noremap <Leader>vx :VimuxInterruptRunner<CR>

" Zoom the runner pane (use <bind-key> z to restore runner pane)
noremap <Leader>vz :call VimuxZoomRunner()<CR>

" The percent of the screen the split pane Vimux will spawn should take up.
let g:VimuxHeight = "40"

" The default orientation of the split tmux pane. This tells tmux to make the
" pane either vertically or horizontally, which is backward from how Vim handles
" creating splits.
" Default: "v"
"let g:VimuxOrientation = "h"

" The type of view object Vimux should use for the runner. For reference, a
" tmux session is a group of windows, and a window is a layout of panes.
" Default: "pane"

"let g:VimuxRunnerType = "window"

" Send text to tmux
noremap <Leader>vs "ry :call VimuxSendText(@r)<CR>

" ripgrep
noremap <Leader>rg :Rg<SPACE>

" NERDTreeToggle
noremap <F8> :NERDTreeToggle<CR>

" Automatically close NERDTree when you open a file
let NERDTreeQuitOnOpen=0

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

let g:NERDTreeGitStatusUseNerdFonts = 1

" FZF
noremap <C-p> :FZF<CR>

" undotree
if has("persistent_undo")
        set undodir=$HOME."/.undodir"
        set undofile
endif

nnoremap <F5> :UndotreeToggle<cr>


" coc.nvim
" coc.nvim need vim >= 8.1.1719 to support features like popup and text property.
" Consider upgrade your vim for better experience.
" You can set this to make this error message go away:
let g:coc_disable_startup_warning = 1

" coc.nvim extensions
"\'coc-explorer',
"\'coc-actions',
let g:coc_global_extensions = [
                        \'coc-vimlsp',
                        \'coc-json',
                        \'coc-prettier',
                        \'coc-elixir',
                        \'coc-erlang_ls',
                        \'coc-marketplace']

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
        " Recently vim can merge signcolumn and number column into one
        set signcolumn=number
else
        set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
if has('nvim')
        inoremap <silent><expr> <c-space> coc#refresh()
else
        inoremap <silent><expr> <c-@> coc#refresh()
endif

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

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set laststatus=2

" airline
let g:airline_theme             = 'dracula'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1

" Note: You must define the dictionary first before setting values.
" Also, it's a good idea to check whether it exists as to avoid 
" accidentally overwriting its contents.

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

" showmode
set nosmd

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
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
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" quickfix
nnoremap <leader>qq :call QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction

function! s:reloadModule()
  let pos = getpos(".")
  execute "normal! gg/defmodule\<CR>wvt \"ry"
  call VimuxSendText("r " . @r ."\n")
  call setpos(".", pos)
endfunction

noremap <silent><nowait><Leader>re :call <SID>reloadModule()<CR>

