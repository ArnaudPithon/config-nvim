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
" syntax highlighting plugin for JavaScript and Flow.js
Plug 'yuezk/vim-js'

" Typescript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'

" ReactJS JSX syntax highlighting
Plug 'maxmellon/vim-jsx-pretty'

" Generate JSDoc commands based on function signature
Plug 'heavenshell/vim-jsdoc', {
      \ 'for': ['javascript', 'javascript.jsx','typescript'],
      \ 'do': 'make install'
      \}

" Syntax highlighting for javascript libraries
Plug 'othree/javascript-libraries-syntax.vim'

" === Syntax Highlighting === "

" Syntax highlighting for nginx
Plug 'chr4/nginx.vim'

" Improved syntax highlighting and indentation
Plug 'othree/yajs.vim'
" Recommended for OceanicNext
Plug 'othree/html5.vim'

Plug 'nikvdp/ejs-syntax'

" postgres
Plug 'lifepillar/pgsql.vim'


" === UI === "
" File explorer
"Plug 'scrooloose/nerdtree'
Plug 'nvim-tree/nvim-tree.lua'

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

" === Others ===
Plug 'vimwiki/vimwiki'

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
let g:gutentags_cache_dir = expand('~/.cache/nvim/ctags')

" Noice - https://github.com/folke/noice.nvim
Plug 'folke/noice.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'nvim-treesitter/nvim-treesitter', { 'branch': 'main' }

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" GitHub Copilot
"Plug 'github/copilot.vim'
Plug 'zbirenbaum/copilot.lua'
"Plug 'zbirenbaum/copilot-cmp'

" Initialize plugin system
call plug#end()

lua require("noice").setup()
"lua require("copilot_cmp").setup()
lua require("copilot").setup({ panel = { enabled = false }, suggestion = { enabled = true, keymap = { prev = "<M-]>", next = "<M-~>", }, }, filetypes = { gitcommit = true }, })
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

        -- For `mini.snippets` users:
        -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
        -- insert({ body = args.body }) -- Insert at cursor
        -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
        -- require("cmp.config").set_onetime({ sources = {} })
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      -- { name = 'copilot', group_index = 2 },
      { name = 'nvim_lsp', group_index = 2  },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips', group_index = 2  }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
  -- Set configuration for specific filetype.
  --[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]]-- 

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    capabilities = capabilities
  }
EOF
