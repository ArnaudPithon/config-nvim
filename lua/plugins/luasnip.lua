return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    --"rafamadriz/friendly-snippets", -- désactivé dans `./_disabled.lua`
  },
  config = function()
    require("user.luasnip-helper").setup()
  end,
}
