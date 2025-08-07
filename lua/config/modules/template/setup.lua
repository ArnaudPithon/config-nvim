local M = {}

local safe_require = require("config.utils.require").safe_require
local template = safe_require("template")

function M.setup()
  template.setup({
    temp_dir = vim.fn.stdpath("config") .. "/templates",
  })
end

return M
