-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local default_opts = { noremap = true, silent = true }

-- Tab fait Esc, Shift-Tab fait Tab
map({ "i", "v" }, "<Tab>", "<Esc>", default_opts)
map({ "i", "v" }, "<S-Tab>", "<Tab>", default_opts)

-- Défilement du texte avec les touches fléchées.
map("n", "<Up>", "<C-y>", default_opts)
map("n", "<Down>", "<C-e>", default_opts)
map("n", "<Left>", "3zh", default_opts)
map("n", "<Right>", "3zl", default_opts)

-- Déplacements facilités dans les tags
--noremap é <C-J>
map("n", "ê", "<C-T>", default_opts)
map("n", "à", "<C-O>", default_opts)

-- Modes où on veut que ça marche :
-- - normal (n)
-- - visual (v)
-- - select (x)
-- - operator-pending (o) → pour d, y, c + mouvement
local movement_modes = { "n", "v", "x", "o" }

-- Déplacement ergonomique : ctsr ↔ hjkl
local function map_ctsr(lhs, rhs, desc)
  map(
    movement_modes,
    lhs,
    rhs,
    vim.tbl_extend("force", default_opts, {
      desc = desc or ("Move " .. lhs .. " → " .. rhs),
    })
  )
end

-- Déplacement : c = gauche, r = droite
map_ctsr("c", "h", "Left")
map_ctsr("r", "l", "Right")
-- Déplacement : t = bas, s = haut
map_ctsr("t", "j", "Down")
map_ctsr("s", "k", "Up")
-- Écran : C = tout en haut, R = tout en bas
map_ctsr("C", "H", "Top of screen")
map_ctsr("R", "L", "Bottom of screen")

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
map_ctsr("k", "s", "Up")
map_ctsr("K", "S", "Up")
--  Corollaire : correction orthographique
map("n", "]k", "]s", default_opts)
map("n", "[k", "[s", default_opts)
--  <URL:vimhelp:K>
map("n", "S", "K", default_opts)
--  Évite un conflit avec le plugin manpageview
--vim.api.nvim_del_keymap("n", "K")

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
