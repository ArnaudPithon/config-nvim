local ls = require("luasnip")
local i = ls.insert_node
local d = ls.dynamic_node
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

local function to_pascal_case(str)
  return str
    :gsub("[_-]+", " ") -- remplace - ou _ par un espace
    :gsub("(%a)(%w*)", function(a, b)
      return a:upper() .. b:lower()
    end)
    :gsub(" ", "")
end

local function to_kebab_case(str)
  return str
    :gsub("_", "-")
    :gsub("([a-z0-9])([A-Z])", "%1-%2") -- insère un tiret entre les minuscules et les majuscules
    :gsub("%s+", "-") -- remplace les espaces par des tirets
    :lower() -- met tout en minuscules
end

local function get_pascal_basename(_, snip)
  local raw = snip.env.TM_FILENAME_BASE or "ComponentName"
  local name = to_pascal_case(raw)
  return sn(nil, { t(name) })
end

local function get_kebab_basename(_, snip)
  local raw = snip.env.TM_FILENAME_BASE or "ComponentName"
  local name = to_kebab_case(raw)
  return sn(nil, { t(name) })
end

return {
  -- React function component
  s({
    trig = "rfc",
    name = "React Component",
    dscr = "Create a React component with TypeScript",
  }, {
    fmt(
      [[
    import React from 'react';

    const {}: React.FC<{}> = ({}) => {{
      return (
        <div className="{}">
          {}
        </div>
      );
    }};

    export default {};
  ]],
      {
        d(1, get_pascal_basename),
        i(2, "PropsType"),
        i(3, "props"),
        d(4, get_kebab_basename),
        i(5, "/* content */"),
        d(6, get_pascal_basename),
      }
    ),
  }),
}
