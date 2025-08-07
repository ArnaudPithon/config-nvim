local M = {}

M.snippets_path = vim.fn.stdpath("config") .. "/lua/snippets"

require("config.modules.luasnip.setup")(M.snippets_path)
require("config.modules.luasnip.commands")(M.snippets_path)
require("config.modules.luasnip.keymaps")()

return M
