local safe_require = require("config.utils.require").safe_require

local zk = safe_require("zk")
local commands = require("zk.commands")

--- Génère une fonction pour éditer des notes
---@param defaults table
---@param picker_options table
local function make_edit_fn(defaults, picker_options)
  return function(options)
    options = vim.tbl_extend("force", defaults, options or {})
    zk.edit(options, picker_options)
  end
end

-- Commandes personnalisées
commands.add("ZkOrphans", make_edit_fn({ orphan = true }, { title = "Zk Orphans" }))
commands.add("ZkRecents", make_edit_fn({ createdAfter = "2 weeks ago" }, { title = "Zk Recents" }))

-- Création rapide de notes avec templates spécifiques
local new_cmds = {
  ZkNewFleet = { template = "fleeting.md", dir = "fleeting", label = "Fleeting", desc = "Nouvelle note : flottante" },
  ZkNewPerm = { template = "permanent.md", dir = "permanent", label = "Permanent", desc = "Nouvelle note : permanente" },
  ZkNewLit = {
    template = "literature.md",
    dir = "literature",
    label = "Literature",
    desc = "Nouvelle note : litérature",
  },
  ZkNewDaily = { template = "daily.md", dir = "journal", label = "Daily", desc = "Nouvelle note de journal" },
  ZkNewBug = { template = "issue-bug.md", dir = "issues/bug", label = "Bug", desc = "Nouvelle issue : bug" },
  ZkNewEnhancement = {
    template = "issue-enhancement.md",
    dir = "issues/enhancement",
    label = "Enhancement: ",
    desc = "Nouvelle issue : enhancement",
  },
  ZkNewDoc = {
    template = "issue-doc.md",
    dir = "issues/documentation",
    label = "Documentation: ",
    desc = "Nouvelle issue : documentation",
  },
  ZkNewIssue = {
    template = "issue.md",
    dir = "issues",
    label = "Question: ",
    desc = "Nouvelle issue : questionnement",
  },
}

local function make_zk_new_command(name, opts)
  vim.api.nvim_create_user_command(name, function()
    local ok, err = pcall(function()
      commands.get("ZkNew")({
        title = vim.fn.input((opts.label or "Note") .. ": "),
        template = opts.template,
        dir = opts.dir,
      })
    end)

    if not ok then
      vim.notify(string.format("❌ Erreur [%s] : %s", name, err), vim.log.levels.ERROR)
    end
  end, { desc = opts.desc })
end

for name, opts in pairs(new_cmds) do
  make_zk_new_command(name, opts)
end
