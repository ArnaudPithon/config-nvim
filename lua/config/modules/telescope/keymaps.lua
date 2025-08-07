local map = vim.keymap.set
local M = {}

-- 🗃️ Mappings globaux
local base = {
  { "<leader>ff", "<cmd>Telescope find_files<cr>", "Find files" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", "Grep in files" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", "Buffers" },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", "Recent files" },
  { "<leader>fh", "<cmd>Telescope help_tags<cr>", "Help tags" },
}

for _, mapping in ipairs(base) do
  map("n", mapping[1], mapping[2], { desc = mapping[3] })
end

-- 🔌 Extensions (si présentes)
local extensions = {
  undo = { key = "<leader>fu", cmd = "Telescope undo", desc = "Undo history" },
  zoxide = { key = "<leader>fz", cmd = "Telescope zoxide list", desc = "Zoxide folders" },
  project = { key = "<leader>fp", cmd = "Telescope project", desc = "Projects" },
}

for ext, conf in pairs(extensions) do
  local ok = pcall(require, "telescope._extensions." .. ext)
  if ok then
    local cmd = string.format("<cmd>%s<cr>", conf.cmd)
    map("n", conf.key, cmd, { desc = conf.desc })
  end
end

return M
