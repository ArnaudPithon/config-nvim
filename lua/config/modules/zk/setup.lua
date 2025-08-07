local M = {}

local safe_require = require("config.utils.require").safe_require

function M.setup()
  local zk = safe_require("zk")

  zk.setup({
    picker = "telescope",
    lsp = {
      config = {
        name = "zk",
        cmd = { "zk", "lsp" },
        filetypes = { "markdown" },
      },
      auto_attach = {
        enabled = true,
      },
    },
    note = {
      template = "default.md",
    },
  })
end

M.setup()

return M
