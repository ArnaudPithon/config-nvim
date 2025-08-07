local ls = require("luasnip")
local i = ls.insert_node
local s = ls.snippet
local fmt = require("luasnip.extras.fmt").fmt
local u = require("config.utils.snippet_utils")
local conds = require("luasnip.extras.expand_conditions")

return {
  -- React function component
  s(
    {
      trig = "rc",
      name = "React Component",
      dscr = "Create a React component with TypeScript",
    },
    fmt(
      [[
    //import {{ {}Props }} from '../../@types';

    interface {}Props {{
      children?: React.ReactNode;
      {};
    }}

    function {}({{ children, {} }}: {}Props) {{
      return (
        <div className="{}" {}>
          {}
        </div>
      );
    }};

    export default {};{}
  ]],
      {
        u.create_pascal_node(),
        u.create_pascal_node(),
        i(1, "[prop: string]: unknown"),
        u.create_pascal_node(),
        i(2, "...props"),
        u.create_pascal_node(),
        u.create_kebab_node(),
        i(3, "{...props}"),
        i(4, "{children}"),
        u.create_pascal_node(),
        i(0),
      }
    ),
    {
      condition = conds.line_begin,
    }
  ),
}
