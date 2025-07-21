local M = {}

M.snippets = { preset = "luasnip" } -- indispensable pour avoir la completion de snippets persos

M.keymap = {
  ["<C-v>"] = { "select_next" },
  ["<C-d>"] = { "select_prev" },
}

return M
