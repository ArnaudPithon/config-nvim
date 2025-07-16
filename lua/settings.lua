-- vim: foldmethod=marker
vim.g.mapleader = ','
vim.g.maplocalleader = ';'

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


XDG_CACHE_HOME = os.getenv("XDG_CACHE_HOME")
vim.opt.undodir = XDG_CACHE_HOME/vim/undo
vim.opt.encoding = 'utf-8'
vim.cmd("set cpoptions += W") -- empèche l'écriture sur un fichier en lecture seule
vim.cmd("set backspace&") -- Restaure le réglage par défaut
vim.opt.history = 500

-- Files with these suffixes get a lower priority when multiple files match a wildcard.
vim.cmd([[
set suffixes+=.aux,.log,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set suffixes+=.dvi,.ps,.pdf
" image formats
set suffixes+=.jpg,.jpeg,.gif,.bmp,.pbm,.pgm,.ppm,.tga,.xbm,.xpm,.tif,.tiff,.png,.fli,.gl,.dl,.xcf,.xwd,.svg
" audio formats
set suffixes+=.ogg,.mp3,.wav,.mka,.flac
" video formats
set suffixes+=.mpg,.mpeg,.avi,.ogm,.ogv,.m2v,.wmv,.VOB,.mkv,.m2t,.ts,.flv,.mp4
]])

-- ligne de statut {{{1
-- Voir l'option "statusline" pour régler plus en détail.
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.ruler = true
-- }}}1

-- recgerche {{{1
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
-- }}}1
