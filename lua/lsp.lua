-- LSP configuration (neovim/nvim-lspconfig)
local lspconfig = require("lspconfig")

-- Autocompletion capabilities for nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Servers à activer (ajoute ceux dont tu as besoin)
-- "tsserver", "pyright", "gopls", "rust_analyzer", "html", "cssls"

lspconfig.ts_ls.setup {
    capabilities = capabilities,
}

-- Keymaps LSP globales
local map = vim.keymap.set
map('n', 'gd', vim.lsp.buf.definition, { desc = "LSP: Go to definition" })
map('n', 'gi', vim.lsp.buf.implementation, { desc = "LSP: implementation" })
map('n', 'gl', vim.diagnostic.open_float, { desc = "LSP: Show diagnostics" })
map('n', 'gD', vim.lsp.buf.declaration, { desc = "LSP: Go to declaration" })
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "LSP: Select a code action" })
map('n', '<leader>rn', vim.lsp.buf.rename, { desc = "LSP: Rename symbol" })
map('n', 'gr', vim.lsp.buf.references, { desc = "LSP: List references" })
map('n', 'K', vim.lsp.buf.hover, { desc = "LSP: Hover documentation" })

map('n', '[d', function() vim.diagnostic.jump({count=-1, float=true}) end, { desc = "Move to previous diagnostic" })
map('n', ']d', function() vim.diagnostic.jump({count=1, float=true}) end, { desc = "Move to next diagnostic" })

-- Formatage automatique avant sauvegarde
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.format({ async = false })
  end
})

-- Diagnostic display settings
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})
