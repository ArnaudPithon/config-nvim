local ls = require("luasnip")
local f = ls.function_node

local M = {}

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

local function name(snip)
  return snip.env.TM_FILENAME_BASE or "ComponentName"
end

function M.create_pascal_node()
  return f(function(_, snip)
    return to_pascal_case(name(snip))
  end)
end

function M.create_kebab_node()
  return f(function(_, snip)
    return to_kebab_case(name(snip))
  end)
end

return M
