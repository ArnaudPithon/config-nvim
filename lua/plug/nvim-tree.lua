local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  --vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', {noremap = true})
  vim.keymap.set('n', '<leader>n', api.tree.toggle, opts('Open or close the tree'))
  vim.keymap.set('n', '<C-s>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', 'T',     api.node.navigate.sibling.last,        opts('Last Sibling'))
  vim.keymap.set('n', 'S',     api.node.navigate.sibling.first,       opts('First Sibling'))
  vim.keymap.set('n', 's',     api.tree.search_node,                  opts('Search'))
  vim.keymap.set('n', 'é',     api.node.run.system,                   opts('Run System'))
end

require("nvim-tree").setup({
  on_attach = my_on_attach,
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
