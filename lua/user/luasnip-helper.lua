local M = {}

local ls = require("luasnip")
local loader = require("luasnip.loaders.from_lua")

-- Chemin vers le dossier de snippets persos
M.snippets_path = vim.fn.stdpath("config") .. "/lua/snippets"

function M.reload_snippets()
  -- Recharger les snippets
  loader.lazy_load({ paths = M.snippets_path })
  vim.notify("[LuaSnip] Snippets reloaded", vim.log.levels.INFO)
end

function M.setup_extends()
  -- ⛓️ Partage des snippets entre langages
  ls.filetype_extend("typescript", { "javascript" })
  ls.filetype_extend("typescriptreact", { "typescript", "javascript" })
  ls.filetype_extend("javascriptreact", { "javascript" })
end

function M.setup_commands()
  -- éditer le fichier de snippets en fonction du filetype
  vim.api.nvim_create_user_command("LuaSnipEdit", function()
    require("luasnip.loaders").edit_snippet_files({
      paths = M.snippets_path,
      filetype = vim.bo.filetype,
    })
  end, { desc = "Edit LuaSnip snippet file for current filetype" })

  -- ouvrir le dossier de snippets
  vim.api.nvim_create_user_command("LuaSnipBrowse", function()
    vim.cmd("edit " .. M.snippets_path)
  end, { desc = "Browse all LuaSnip snippet files" })

  vim.api.nvim_create_user_command("LuaSnipReload", M.reload_snippets, { desc = "Reload LuaSnip personal snippets" })
end

function M.setup_autocommands()
  -- recharger automatiquement les snippets à la sauvegarde
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = M.snippets_path .. "/*.lua",
    callback = M.reload_snippets,
  })
end

function M.setup_keymaps()
  -- keymaps
  vim.keymap.set("i", "<C-t>", function()
    if ls.expand_or_locally_jumpable() then
      ls.expand_or_jump()
    else
      -- Si pas de snippet, on insère un espace
      vim.api.nvim_feedkeys(" ", "n", true)
    end
  end, { desc = "Expand or jump in snippet" })

  vim.keymap.set({ "i", "s" }, "<M-t>", function()
    if ls.jumpable(1) then
      ls.jump(1)
    end
  end, { desc = "Jump to next snippet node" })

  vim.keymap.set({ "i", "s" }, "<M-s>", function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { desc = "Jump to previous snippet node" })

  -- Choisir dans un choix multiple
  vim.keymap.set({ "i", "s" }, "<M-'>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { desc = "Cycle snippet choices" })
end

function M.setup()
  -- Chargement initial
  loader.lazy_load({ paths = M.snippets_path })

  ls.config.setup({
    enable_autosnippets = true,
  })

  M.setup_extends()
  M.setup_commands()
  M.setup_autocommands()
  M.setup_keymaps()

  -- End
  --vim.notify("[LuaSnip] Chargé depuis " .. M.snippets_path, vim.log.levels.INFO)
end

return M
