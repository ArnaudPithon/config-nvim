local M = {}

local zk = require("zk")

function M.setup()
  -- Configuration de base
  zk.setup({
    -- Can be "telescope", "fzf", "fzf_lua", "minipick", "snacks_picker",
    -- or select" (`vim.ui.select`).
    picker = "select", -- sélection de notes
    lsp = {
      -- `config` is passed to `vim.lsp.start(config)`.
      config = {
        name = "zk",
        cmd = { "zk", "lsp" }, -- Commande pour le serveur LSP
        filetypes = { "markdown" }, -- Types de fichiers pris en charge
        -- on_attach = ...
        -- etc, see `:h vim.lsp.start()` `:h zk-lsp`
      },
      -- automatically attach buffers in a zk notebook that match the given filetypes
      auto_attach = {
        enabled = true,
      },
    },
    note = {
      template = "default.md", -- Modèle par défaut pour les nouvelles notes
    },
  })

  -- Commandes personnalisées
  vim.api.nvim_create_user_command("ZkNew", function(opts)
    zk.new(opts.args)
  end, { nargs = "*", desc = "Create a new zk note" })
end

return M
