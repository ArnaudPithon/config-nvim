local opt = vim.opt

opt.encoding = "utf-8"
opt.history = 500
opt.undodir = vim.fn.expand("$XDG_CACHE_HOME") .. "/nvim/undo"
opt.backspace = {"indent", "eol", "start"}
-- ligne de status
opt.showmode = true
opt.showcmd = true
opt.ruler = true
-- recherche
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
-- 
opt.visualbell = true

opt.scrolloff = 3
opt.sidescrolloff = 1
opt.sidescroll = 1

opt.list = true
opt.listchars = {tab = ">·", trail = "·", nbsp = "␣", precedes = "<", extends = ">", eol = "↲"}

opt.showbreak = "~"

opt.spellfile = vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/spell/local.utf-8.add"

-- Indentation
-- (voir la recette "Indenting lines" p.42 du livre vim-recipes)
opt.expandtab = true
opt.tabstop = 8
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smarttab = true

-- Définit quelles bases considérer pour les commandes CTRL-A et CTRL-X
opt.nrformats = "alpha,hex"
-- highlight current cursor line
opt.cursorline = true
-- Pour éviter son apparition/disparition contextuelle
opt.signcolumn = "yes"
-- folding
opt.foldcolumn = "3"

opt.cpoptions:append "W"

-- -- Mode de complétion
opt.wildmenu = true
opt.wildmode = "longest:full,full"
--
-- -- Programme utilisé pour formater le texte avec `gq`.
-- -- Le formatage habituel de vim peut être obtenu avec `gw`.
opt.formatprg="par w55 e1"
--
-- -- portée locale à la fenêtre {{{2
--
opt.list = true
opt.wrap = false
opt.linebreak = true
-- --set relativenumber -- numérote les lignes relativement à la ligne courante

-- 🪶 Suffixes de fichiers à ignorer
vim.opt.suffixes:append {
  ".aux", ".log", ".bbl", ".blg", ".brf", ".cb", ".ind", ".idx", ".ilg", ".inx",
  ".out", ".toc", ".dvi", ".ps", ".pdf",
}
-- formats image
vim.opt.suffixes:append {
  ".jpg", ".jpeg", ".gif", ".bmp", ".pbm", ".pgm", ".ppm", ".tga", ".xbm",
  ".xpm", ".tif", ".tiff", ".png", ".fli", ".gl", ".dl", ".xcf", ".xwd", ".svg",
}
-- formats audio
vim.opt.suffixes:append {
  ".ogg", ".mp3", ".wav", ".mka", ".flac",
}
-- formats vidéo
vim.opt.suffixes:append {
  ".mpg", ".mpeg", ".avi", ".ogm", ".ogv", ".m2v", ".wmv", ".VOB", ".mkv",
  ".m2t", ".ts", ".flv", ".mp4",
}
