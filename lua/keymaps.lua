local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

vim.g.mapleader = ","
vim.g.maplocalleader = ";"

-- Tab fait Esc, Shift-Tab fait Tab
map("i", "<Tab>", "<Esc>", default_opts)
map("i", "<S-Tab>", "<Tab>", default_opts)
map("v", "<Tab>", "<Esc>", default_opts)
map("v", "<S-Tab>", "<Tab>", default_opts)

-- Défilement du texte avec les touches fléchées.
map("n", "<Up>", "<C-y>", default_opts)
map("n", "<Down>", "<C-e>", default_opts)
map("n", "<Left>", "3zh", default_opts)
map("n", "<Right>", "3zl", default_opts)

-- Déplacements facilités dans les tags
--noremap é <C-J>
map("n", "ê", "<C-T>", default_opts)
map("n", "à", "<C-O>", default_opts)

-- [HJKL] -> {CTSR}
-- ————————————————
-- {cr} = « gauche / droite »
map("n", "c", "h", default_opts)
map("n", "r", "l", default_opts)
-- {ts} = « haut / bas »
map("n", "t", "j", default_opts)
map("n", "s", "k", default_opts)
-- {CR} = « haut / bas de l'écran »
map("n", "C", "H", default_opts)
map("n", "R", "L", default_opts)
-- Corollaire : repli suivant / précédent
map("n", "zt", "zj", default_opts)
map("n", "zs", "zk", default_opts)
-- Déplacement entre fenêtres
map("n", "ét", "<C-w>j", default_opts)
map("n", "és", "<C-w>k", default_opts)
map("n", "éc", "<C-w>h", default_opts)
map("n", "ér", "<C-w>l", default_opts)
map("n", "éw", "<C-w>w", default_opts)
map("n", "éW", "<C-w>W", default_opts)
map("n", "éè", "<C-w>t", default_opts)
map("n", "éb", "<C-w>b", default_opts)
map("n", "ép", "<C-w>p", default_opts)
map("n", "éP", "<C-w>P", default_opts)
-- Déplacement des fenêtres
map("n", "éC    ", "<C-w>H", default_opts)
map("n", "<C-W>C", "<C-w>H", default_opts)
map("n", "éR    ", "<C-w>L", default_opts)
map("n", "<C-W>R", "<C-w>L", default_opts)
map("n", "éT    ", "<C-w>J", default_opts)
map("n", "<C-W>T", "<C-w>J", default_opts)
map("n", "éS    ", "<C-w>K", default_opts)
map("n", "<C-W>S", "<C-w>K", default_opts)
map("n", "éÈ    ", "<C-w>T", default_opts)
map("n", "<C-W>È", "<C-w>T", default_opts)

--  {HJKL} <- [CTSR]
--  ————————————————
--  {J} = « Jusqu'à »            (j = suivant, J = précédant)
map("n", "j", "t", default_opts)
map("n", "J", "T", default_opts)
--  {H} = « Change »             (h = attend un mvt, H = jusqu'à la fin de ligne
map("n", "h", "c", default_opts)
map("n", "H", "C", default_opts)
--  {L} = « Remplace »           (l = un caractère slt, L = reste en « Remplace
map("n", "l", "r", default_opts)
map("n", "L", "R", default_opts)
--  {K} = « Substitue »          (k = caractère, K = ligne)
map("n", "k", "s", default_opts)
map("n", "K", "S", default_opts)
--  Corollaire : correction orthographique
map("n", "]k", "]s", default_opts)
map("n", "[k", "[s", default_opts)
--  <URL:vimhelp:K>
map("n", "S", "K", default_opts)
--  Évite un conflit avec le plugin manpageview
vim.api.nvim_del_keymap('n', 'K')

--  Désambiguation de {g}
--  —————————————————————
--  ligne écran précédente / suivante (à l'intérieur d'une phrase)
map("n", "gs", "gk", default_opts)
map("n", "gt", "gj", default_opts)
--  tab suivant / précédent
map("n", "gè", "gt", default_opts)
map("n", "gÈ", "gT", default_opts)

--  <url:vimhelp:J>
map("n", "T", "J", default_opts)
map("n", "gT", "gJ", default_opts)

--  Défilement du texte avec les touches fléchées.
map("n", "<Up>", "<C-y>", default_opts)
map("n", "<Down>", "<C-e>", default_opts)
map("n", "<Left>", "3zh", default_opts)
map("n", "<Right>", "3zl", default_opts)

-- Mappings pour Plugins --

-- nvim-tree
map("n", "<leader>n", ":NvimTreeToggle<CR>", default_opts)

-- Denite
map("n", ";", ":Denite buffer<CR>", default_opts)
map("n", "<leader>t", ":DeniteProjectDir file/rec<CR>", default_opts)
map("n", "<leader>g", ":Denite grep:. -no-empty<CR>", default_opts)
map("n", "<leader>j", ":DeniteCursorWord grep:.<CR>", default_opts)

-- COC.nvim
--   <leader>dd    - Jump to definition of current symbol
--   <leader>dr    - Jump to references of current symbol
--   <leader>dj    - Jump to implementation of current symbol
--   <leader>ds    - Fuzzy search current project symbols
map("n", "<leader>dd", "<Plug>(coc-definition", default_opts)
map("n", "<leader>dr", "<Plug>(coc-references", default_opts)
map("n", "<leader>dj", "<Plug>(coc-implementation", default_opts)
map("n", "<leader>ds", ":<C-u>CocList -I -N --top symbols<CR>", default_opts)

-- copilot
-- Esc à la place de Tab pour accepter la suggestion de Copilot
map("i", "<Esc>", 'copilot#Accept("<CR>")', { expr = true, silent = true, script = true })

-- Dismiss noice message
map("n", "<leader>nd", "NoiceDismiss<CR>", {silent = true})
