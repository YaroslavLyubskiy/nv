require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }

require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

local actions = require("diffview.actions")

require("diffview").setup({
  enhanced_diff_hl = true,
  keymaps = {
    disable_defaults = false,
    view = {
      { "n", "<leader>cf",  actions.conflict_choose("ours"),        { desc = "Choose the OURS version of a conflict" } },
      { "n", "<leader>cj",  actions.conflict_choose("theirs"),      { desc = "Choose the THEIRS version of a conflict" } },
      { "n", "<leader>ca",  actions.conflict_choose("all"),         { desc = "Choose all the versions of a conflict" } },
      { "n", "<leader>cF",  actions.conflict_choose_all("ours"),    { desc = "Choose the OURS version of a conflict for the whole file" } },
      { "n", "<leader>cJ",  actions.conflict_choose_all("theirs"),  { desc = "Choose the THEIRS version of a conflict for the whole file" } },
      { "n", "<leader>cA",  actions.conflict_choose_all("all"),     { desc = "Choose all the versions of a conflict for the whole file" } },
    }
  }
})

require('lint').linters_by_ft = {
  php = {'phpcs'}
}

require('dapui').setup()

local dap = require 'dap'

dap.adapters.php = {
  type = 'executable',
  command = 'node',
  args = { '/home/asdf/vscode-php-debug/out/phpDebug.js' }
}

dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = 'Listen for Xdebug',
    port = 9003,
    cwd = '/home/asdf/project/site/express/public_html',
    pathMappings = {
      ['/var/www/public_html'] = "/home/asdf/project/site/express/public_html",
    }
  }
}

local severities = {
  ERROR = vim.diagnostic.severity.ERROR,
  WARNING = vim.diagnostic.severity.WARN,
}

require('lint').linters.phpcs = {
  cmd = 'phpcs',
  stdin = true,
  args = {
    '--standard=PSR12',
    '-q',
    '--report=json',
    '-', -- need `-` at the end for stdin support
  },
  ignore_exitcode = true,
  parser = function(output, _)
    if vim.trim(output) == '' or output == nil then
      return {}
    end

    if not vim.startswith(output,'{') then
      vim.notify(output)
      return {}
    end

    local decoded = vim.json.decode(output)
    local diagnostics = {}
    local messages = decoded['files']['STDIN']['messages']

    for _, msg in ipairs(messages or {}) do
      table.insert(diagnostics, {
        lnum = msg.line - 1,
        end_lnum = msg.line - 1,
        col = msg.column - 1,
        end_col = msg.column - 1,
        message = msg.message,
        code = msg.source,
        source = 'phpcs',
        severity = assert(severities[msg.type], 'missing mapping for severity ' .. msg.type),
      })
    end

    return diagnostics
  end
}

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

require('telescope').load_extension('media_files')
