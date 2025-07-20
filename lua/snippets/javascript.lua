local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local conds = require("luasnip.extras.expand_conditions")

return {
  -- log
  s(
    {
      trig = "log",
      name = "console.log",
      descr = "Log en console",
    },
    fmt("console.log({});\n{}", {
      i(1, '"debug"'),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),

  -- error
  s(
    {
      trig = "ler",
      name = "console.error",
      descr = "Log d'erreur en console",
    },
    fmt("console.error({});\n{}", {
      i(1, '"error"'),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),

  -- ex : console.log("app.js", myVar);
  s(
    {
      trig = "logf",
      name = "log contextuel",
      descr = "Log contextuel en console",
    },
    fmt('console.log("{}", {});\n{}', {
      f(function()
        return vim.fn.expand("%:t")
      end, {}),
      i(1, "value"),
      i(0),
    }),
    {
      condition = conds.line_begin,
    }
  ),
}
