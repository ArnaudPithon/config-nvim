return function(snippets_path)
  local safe_require = require("config.utils.require").safe_require
  safe_require("luasnip")

  local function reload_snippets()
    require("luasnip.loaders.from_lua").lazy_load({ paths = snippets_path })
    vim.notify("[LuaSnip] Snippets rechargés", vim.log.levels.INFO)
  end

  local user_command = vim.api.nvim_create_user_command

  user_command("LuaSnipEdit", function()
    require("luasnip.loaders").edit_snippet_files({
      paths = snippets_path,
      filetype = vim.bo.filetype,
    })
  end, { desc = "Edit snippet du filetype courant" })

  user_command("LuaSnipBrowse", function()
    vim.cmd("edit " .. snippets_path)
  end, { desc = "Ouvrir tous les snippets persos" })

  user_command("LuaSnipReload", reload_snippets, { desc = "Recharger les snippets persos" })

  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = snippets_path .. "/*.lua",
    callback = reload_snippets,
  })
end
