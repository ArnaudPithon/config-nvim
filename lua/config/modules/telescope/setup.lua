local M = {}

local safe_require = require("config.utils.require").safe_require

local telescope = safe_require("telescope")
local actions = require("telescope.actions")

function M.setup()
  telescope.setup({
    defaults = {
      layout_strategy = "flex",
      prompt_prefix = "   ",
      selection_caret = " ",
      sorting_strategy = "descending",
      layout_config = {
        prompt_position = "bottom",
        width = 0.95,
        height = 0.85,
      },
      winblend = 0,
      mappings = {
        i = {
          ["<M-s>"] = actions.move_selection_previous,
          ["<M-t>"] = actions.move_selection_next,
        },
      },
    },
    pickers = {
      buffers = {
        sort_mru = true,
        previewer = false,
      },
    },
  })
end

return M
