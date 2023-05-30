" ~/.config/nvim/init.vim
" Maintainer: icarios <arnaud AT icarios DOT net>

scriptencoding utf-8

" Destiné à être supprimé quand la transition sera complète.
set runtimepath^=~/.config/vim runtimepath+=~/.config/vim/after
let &packpath = &runtimepath
source ~/.config/vim/vimrc

source ~/.config/nvim/plugins.vim

" highlight current cursor line
set cursorline

" Pour éviter son apparition/disparition contextuelle
set signcolumn=yes

syntax on
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
colorscheme OceanicNext
" Si le terminal est capable de transparence.
"hi Normal guibg=NONE ctermbg=NONE
"hi LineNr guibg=NONE ctermbg=NONE
"hi SignColumn guibg=NONE ctermbg=NONE
"hi EndOfBuffer guibg=NONE ctermbg=NONE

" AutoCommandes {{{1

if has("autocmd")
  filetype plugin indent on

  augroup vimrc
    autocmd!
  augroup END

  autocmd! vimrc BufNewFile * silent! 0r ~/.config/nvim/templates/skeleton.%:e

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd vimrc BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " If buffer modified, update any 'Last modified: ' in the first 20 lines.
  " 'Last modified: ' can have up to 10 characters before (they are
  " retained).
  " Restores cursor and window position using save_cursor variable.
  " source http://vim.wikia.com/wiki/Insert_current_date_or_time
  function! LastModified() " {{{2
    "let s:formatDate = '%a %b %d, %Y  %I:%M%p'
    let s:formatDate = '%F %T%z' " ISO8601
    if &modified
      let save_cursor = getpos(".")
      let n = min([20, line("$")])
      keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
            \ strftime(s:formatDate) . '#e'
      call histdel('search', -1)
      call setpos('.', save_cursor)
    endif
  endfun " }}}2
  autocmd vimrc BufWritePre * call LastModified()

  "autocmd vimrc BufReadCmd *.epub call zip#Browse(expand("<amatch>"))

  " Prend en compte immédiatement les modifications
  autocmd vimrc BufWritePost $XDG_CONFIG_HOME/nvim/init.vim source $XDG_CONFIG_HOME/nvim/init.vim

  " Met en valeur la fenêtre ayant le focus.
  autocmd vimrc WinEnter * :setl cursorline
  autocmd vimrc WinLeave * :setl nocursorline
endif " has("autocmd")

" }}}

" ============================================================================ "
" ===                           PLUGIN SETUP                               === "
" ============================================================================ "

" Wrap in try/catch to avoid errors on initial install before plugin is available
try
" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   split                       - Use floating window for Denite
"   start_filter                - Start filtering on default
"   auto_resize                 - Auto resize the Denite window height automatically.
"   source_names                - Use short long names if multiple sources
"   prompt                      - Customize denite prompt
"   highlight_matched_char      - Matched characters highlight
"   highlight_matched_range     - matched range highlight
"   highlight_window_background - Change background group in floating window
"   highlight_filter_background - Change background group in floating filter window
"   winrow                      - Set Denite filter window to top
"   vertical_preview            - Open the preview window vertically

let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': 'λ ',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

" === Coc.nvim === "
" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" === NERDTree === "
" Show hidden files/directories
let g:NERDTreeShowHidden = 1

" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1

" Custom icons for expandable/expanded directories
let g:NERDTreeDirArrowExpandable = '⬏'
let g:NERDTreeDirArrowCollapsible = '⬎'

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" Emmet {{{
" Limite l'utilisation d'Emmet aux buffers html et css
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
" Changement de la combinaison leader
let g:user_emmet_leader_key=','
let g:emmet_html5 = 0
let g:user_emmet_settings = {
      \ 'indentation' : '  ',
      \ 'variables' : {
      \      'lang': 'fr',
      \},
      \ 'html' : {
      \       'empty_element_suffix': ' />',
      \},
\}
" }}}

" Tagalong
let g:tagalong_verbose = 1

" plugin UltiSnips {{{
let g:UltiSnipsExpandTrigger = "<S-Tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-r>"
let g:UltiSnipsJumpBackwardTrigger  = "<c-c>"
let g:UltiSnips_javascript = {
      \ 'keyword-spacing': 'always',
      \ 'semi': 'always',
      \ 'space-before-function-param': 'never',
      \ }
" }}}

" 
let g:deoplete#enable_at_startup = 1

" Startify
" Éviter un warning lors d'un chargement d'une session oà NERDTree était
" ouvert.
let g:startify_session_before_save = [
      \ 'silent! NERDTreeClose'
      \ ]

function! s:gitModifiedUntracked()
  let files = systemlist('git ls-files -m -o --exclude-standard 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': function('s:gitModifiedUntracked'),  'header': ['   git untracked and modified']},
      \ ]

" don't change the working directory
let g:startify_change_to_dir = 0
let g:startify_update_oldfiles = 1
let g:startify_session_persistence = 1
let g:startify_session_sort = 1


" ============================================================================ "
" ===                             KEY MAPPINGS                             === "
" ============================================================================ "

" === Denite shorcuts === "
"   ;         - Browser currently open buffers
"   <leader>t - Browse list of files in current directory
"   <leader>g - Search current directory for occurences of given term and close window if no results
"   <leader>j - Search current directory for occurences of word under cursor
nmap ; :Denite buffer<CR>
nmap <leader>t :DeniteProjectDir file/rec<CR>
nnoremap <leader>g :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>j :<C-u>DeniteCursorWord grep:.<CR>

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-s>         - Open currently selected file in a horizontal split
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_update)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-s>
  \ denite#do_map('do_action', 'split')
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-s>       - Open currently selected file in a horizontal split
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-s>
  \ denite#do_map('do_action', 'split')
endfunction

" === Nerdtree shorcuts === "
"  <leader>n - Toggle NERDTree on/off
"  <leader>f - Opens current file location in NERDTree
nmap <leader>n :NERDTreeToggle<CR>
nmap <leader>f :NERDTreeFind<CR>

"   <Space> - PageDown
"   -       - PageUp
noremap <Space> <PageDown>
noremap - <PageUp>

let NERDTreeMapActivateNode = 'l'
let NERDTreeMapPreview = 'gl'
let NERDTreeMapOpenInTab = 'è'
let NERDTreeMapOpenInTabSilent = 'È'
let NERDTreeMapOpenSplit = 'h'
let NERDTreeMapPreviewSplit = 'H'
let NERDTreeMapOpenVSplit = 'v'
let NERDTreeMapPreviewVSplit = 'V'
let NERDTreeMapJumpFirstChild = 'S'
let NERDTreeMapJumpLastChild = 'T'
let NERDTreeMapJumpPrevSibling = '<C-s>'
let NERDTreeMapJumpNextSibling = '<C-t>'
let NERDTreeMapRefresh = 'o'
let NERDTreeMapRefreshRoot = 'O'
let NERDTreeMenuUp = 's'
let NERDTreeMenuDown = 't'

" === coc.nvim === "
"   <leader>dd    - Jump to definition of current symbol
"   <leader>dr    - Jump to references of current symbol
"   <leader>dj    - Jump to implementation of current symbol
"   <leader>ds    - Fuzzy search current project symbols
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)
nnoremap <silent> <leader>ds :<C-u>CocList -I -N --top symbols<CR>

set secure
" nvim: foldmethod=marker expandtab ts=2 sw=2 nowrap
