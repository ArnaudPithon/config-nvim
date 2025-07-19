local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- log
  s("log", fmt("console.log({});\n{}", {
    i(1, '"debug"'),
    i(2),
  })),

  -- error
  s("ler", fmt("console.error({});\n{}", {
    i(1, '"error"'),
    i(2),
  })),

  -- log contextuel
  -- ex : console.log("app.js", myVar);
  s("logf", fmt('console.log("{}", {});\n{}', {
    f(function()
      return vim.fn.expand("%:t")
    end, {}),
    i(1, "value"),
    i(2),
  }))
}


