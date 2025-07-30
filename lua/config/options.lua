-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set:
-- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.mapleader = ","
vim.g.maplocalleader = ";"

-- Programme utilisé pour formater le texte avec `gq`.
-- Le formatage habituel de vim peut être obtenu avec `gw`.
--vim.opt.formatprg = "par w55 e1"
vim.opt.formatprg = "~/.dprint fmt --stdin --config ~/.config/dprint/config.json"
vim.opt.textwidth = 72

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.formatprg = "dprint fmt --stdin --config ~/.config/dprint/config.json"
    vim.opt_local.textwidth = 72
  end,
})
