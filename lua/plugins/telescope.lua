return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = vim.fn.executable("make") == 1 },
    { "debugloop/telescope-undo.nvim" },
    { "jvgrootveld/telescope-zoxide" },
    { "nvim-telescope/telescope-project.nvim" },
  },
}
