return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets", -- tu peux le garder ou virer
  },
  config = function()
    local ls = require("luasnip")
    local loader = require("luasnip.loaders.from_lua")

    -- Chemin vers ton dossier perso de snippets
    local my_snippets_path = vim.fn.stdpath("config") .. "/lua/snippets"

    -- Chargement initial
    loader.lazy_load({ paths = my_snippets_path })

    -- ⛓️ Partage des snippets entre langages
    ls.filetype_extend("typescript", { "javascript" })
    ls.filetype_extend("typescriptreact", { "typescript", "javascript" })
    ls.filetype_extend("javascriptreact", { "javascript" })

    -- Commande : éditer le fichier de snippets du filetype courant
    vim.api.nvim_create_user_command("LuaSnipEdit", function()
      local ft = vim.bo.filetype
      local path = vim.fn.stdpath("config") .. "/lua/snippets/" .. ft .. ".lua"
      vim.cmd("edit " .. path)
    end, { desc = "Edit LuaSnip snippet file for current filetype" })

    -- 🔁 Recharger automatiquement tes snippets quand tu sauvegardes
    vim.api.nvim_create_autocmd("BufWritePost", {
      pattern = my_snippets_path .. "/*.lua",
      callback = function()
        loader.lazy_load({ paths = my_snippets_path })
      end,
    })
  end,
  keys = {
      {"<leader>es", "<cmd>LuaSnipEdit<CR>", desc = "Edit snippets"},
  },
}
