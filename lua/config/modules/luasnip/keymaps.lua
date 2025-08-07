return function()
  local safe_require = require("config.utils.require").safe_require

  local ls = safe_require("luasnip")

  local map = vim.keymap.set

  map({ "i", "s" }, "<C-o>", function()
    if ls.expand_or_locally_jumpable() then
      ls.expand_or_jump()
    else
      -- Si pas de snippet, on insère un espace
      vim.api.nvim_feedkeys(" ", "n", true)
    end
  end, { desc = "Snippet: expand or jump" })

  map({ "i", "s" }, "<C-p>", function()
    if ls.jumpable(-1) then
      ls.jump(-1)
    end
  end, { desc = "Snippet: jump back" })

  -- Choisir dans un choix multiple
  map({ "i", "s" }, "<M-'>", function()
    if ls.choice_active() then
      ls.change_choice(1)
    end
  end, { desc = "Snippet: next choice" })
end
