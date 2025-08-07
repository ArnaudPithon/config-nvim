local M = {}

--- Charge un module Lua en sécurité avec une erreur lisible si raté
---@param module string Le nom du module à require (ex: "telescope.builtin")
---@return any|nil Le module ou nil en cas d’échec
function M.safe_require(module)
  local ok, result = pcall(require, module)

  if not ok then
    vim.notify(
      string.format("❌ Impossible de charger le module '%s'\n\n%s", module, result),
      vim.log.levels.ERROR,
      { title = "Erreur require()" }
    )
    return nil
  end

  return result
end

return M
