return function(snippets_path)
  local safe_require = require("config.utils.require").safe_require

  local ls = safe_require("luasnip")
  local loader = require("luasnip.loaders.from_lua")

  loader.lazy_load({ paths = snippets_path })

  ls.config.setup({
    enable_autosnippets = true,
  })

  -- Filetype inheritance
  ls.filetype_extend("typescript", { "javascript" })
  ls.filetype_extend("typescriptreact", { "typescript", "javascript" })
  ls.filetype_extend("javascriptreact", { "javascript" })
end
