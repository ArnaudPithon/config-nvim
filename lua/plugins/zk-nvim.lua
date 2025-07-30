-- Neovim extension for the zk plain text note-taking assistant.
-- https://github.com/zk-org/zk-nvim

return {
  "zk-org/zk-nvim",
  config = function()
    require("zk").setup({
      -- See Setup section below
    })
  end,
}
