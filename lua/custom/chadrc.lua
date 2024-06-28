---@type ChadrcConfig
local M = {}

vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 16
vim.opt.pumheight = 32
vim.cmd('set autoindent')
vim.cmd('set fillchars+=diff:╱')
-- vim.cmd('set colorcolumn=120')
vim.cmd('set wildmenu')

local function open_nvim_tree(data)

  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- open the tree
  require("nvim-tree.api").tree.open({ focus = false, find_file = true, })
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

function FixDiff()
  vim.api.nvim_set_hl(0, 'DiffviewDiffAddAsDelete', { bg = "#361c28" })
  vim.api.nvim_set_hl(0, 'DiffDelete', { bg = "#361c28" })
  vim.api.nvim_set_hl(0, 'DiffviewDiffDelete', { bg = "#361c28" })
  vim.api.nvim_set_hl(0, 'DiffAdd', { bg = "#122f2f" })
  vim.api.nvim_set_hl(0, 'DiffChange', { bg = "#222a39" })
  vim.api.nvim_set_hl(0, 'DiffText', { bg = "#2f3f5c" })
end
FixDiff()

vim.api.nvim_create_autocmd(
  "ColorScheme",
    { callback = FixDiff }
)

M.ui = {
  theme = 'oxocarbon',
  theme_toggle = { "oxocarbon", "one_light" },
  statusline = {
    theme = "vscode_colored"
  },
  cmp = {
    style = "flat_light",
  },
}
M.plugins = 'custom.plugins'
M.mappings = require "custom.mappings"

return M
