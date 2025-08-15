-- @brief Configuration for dotenv files (.env*)
--
-- @problem:
--   Neovim initially sets .env files as 'sh' filetype for syntax
--   highlighting. This triggers the linter on every variable
--   assignment, creating unwanted alerts.
--
-- @solution:
--   1. Force the filetype to 'dotenv' using `vim.filetype.add` so that
--      the linter ignores it.
--   2. Apply 'sh' syntax manually via an autocmd for proper coloring.
--
-- @note:
--   The separation is necessary because the filetype must be
--   assigned manually to bypass Neovim's automatic detection.

-- @description: Add dotenv filetype
vim.filetype.add({
  pattern = {
    ["%.env"] = "dotenv",
    ["%.env%.local"] = "dotenv",
    ["%.env%.development"] = "dotenv",
    ["%.env%.test"] = "dotenv",
    ["%.env%.production"] = "dotenv",
    ["%.env%.sample"] = "dotenv",
  },
})

-- @description: Set syntax to sh for dotenv buffers
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  callback = function(args)
    if vim.bo[args.buf].filetype == "dotenv" then
      vim.bo.syntax = "sh"
    end
  end,
})
