local M = {}

local base = "config.modules"
local path = vim.fn.stdpath("config") .. "/lua/" .. base:gsub("%.", "/")

local safe_require = require("config.utils.require").safe_require

-- Parcours récursif des sous-dossiers
local function scan_and_require(dir, prefix)
  ---@diagnostic disable-next-line: undefined-field
  local handle = vim.loop.fs_scandir(dir)
  if not handle then
    return
  end

  while true do
    ---@diagnostic disable-next-line: undefined-field
    local name, t = vim.loop.fs_scandir_next(handle)
    if not name then
      break
    end

    local fullpath = dir .. "/" .. name
    if t == "file" and name == "init.lua" and prefix ~= base then
      local module = prefix
      safe_require(module)
    elseif t == "directory" then
      scan_and_require(fullpath, prefix .. "." .. name)
    end
  end
end

-- Lance le scan au chargement
scan_and_require(path, base)

return M
