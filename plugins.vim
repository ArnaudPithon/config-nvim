" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vim-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')

" === Editing Plugins === "
" Trailing whitespace highlighting & automatic fixing
"Plug 'ntpeters/vim-better-whitespace'

" auto-close plugin
"Plug 'rstacruz/vim-closer'

" Improved motion in Vim
"Plug 'easymotion/vim-easymotion'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Denite - Fuzzy finding, buffer management
Plug 'Shougo/denite.nvim'

" Snippet support
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Print function signatures in echo area
"Plug 'Shougo/echodoc.vim'
"
" completion (compatible UltiSnips)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" support for expanding abbreviations (CSS, HTML, …)
Plug 'mattn/emmet-vim'
" automatically rename closing HTML/XML tags
Plug 'AndrewRadev/tagalong.vim'
" Attention à ALE - Il serait en conflit avec COC.nvim
" ALE (Asynchronous Lint Engine) provide linting (syntax checking and semantic errors)
" while you edit your text files, and acts as a Vim Language Server Protocol client.
Plug 'dense-analysis/ale'

" === Git Plugins === "
" Enable git changes to be shown in sign column
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'

" === Javascript Plugins === "
" Typescript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'

" ReactJS JSX syntax highlighting
"Plug 'mxw/vim-jsx'

" Generate JSDoc commands based on function signature
"Plug 'heavenshell/vim-jsdoc'

" === Syntax Highlighting === "

" Syntax highlighting for nginx
Plug 'chr4/nginx.vim'

" Syntax highlighting for javascript libraries
Plug 'othree/javascript-libraries-syntax.vim'

" Improved syntax highlighting and indentation
Plug 'othree/yajs.vim'
" Recommended for OceanicNext
Plug 'othree/html5.vim'

Plug 'nikvdp/ejs-syntax'


" === UI === "
" File explorer
Plug 'scrooloose/nerdtree'

" Colorscheme
Plug 'mhartington/oceanic-next'
Plug 'ful1e5/onedark.nvim'
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Customized vim status line
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

" Icons
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" start screen
Plug 'mhinz/vim-startify'

Plug 'vimwiki/vimwiki'

" Initialize plugin system
call plug#end()
