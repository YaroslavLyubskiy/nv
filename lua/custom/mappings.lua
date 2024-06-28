local M = {}

M.abc = {
  n = {
    ["<leader>t"] = {"<cmd> Telescope lsp_document_symbols <CR>", "LSP document symbols"},

    ["<leader>f"] = { "<cmd> Telescope git_files <CR>", "Git files" },
    ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
    ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },

    ["<leader>r"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
    ["<leader>g"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },

    ["<leader><Tab>"] = { "<cmd> Telescope buffers <CR>", "Buffers" },

    ["<leader>gs"] = { "<cmd> Telescope git_status <CR>", "Git status" },
    ["<leader>gb"] = {"<cmd> Telescope git_branches <CR>", "Git branches"},
    ["<leader>gc"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },

    ["<leader>d"] = { "<cmd> DiffviewOpen <CR>", "Diffview open" },
    ["<leader>dc"] = { "<cmd> DiffviewClose <CR>", "Diffview close" },
    ["<leader>df"] = { "<cmd> DiffviewFileHistory % <CR>", "Diffview current file history" },
    ["<leader>de"] = { "<cmd> DiffviewFileHistory <CR>", "Diffview current branch history" },

    ["<leader>ee"] = { "<cmd> DapStepOver <CR>zz", "Debug step over" },
    ["<leader>EE"] = { "<cmd> DapStepInto <CR>zz", "Debug step into" },
    ["<leader>eb"] = { "<cmd> DapToggleBreakpoint <CR>", "Debug toggle breakpoint" },
    ["<leader>et"] = { "<cmd> lua require('dapui').toggle() <CR>", "Debug toggle ui" },

    ["<leader>y"] = { "<plug>OSCYankOperator", "Yank over ssh" },
    ["<leader>R"] = { "<plug>RestNvim", "REST client" },

    ["<leader>s"] = { "<cmd> !echo % <CR>", "Print current file name" },
    ["<leader>S"] = { "<cmd> !cat % <CR>", "Print current file content" },

    ["<leader>o"] = { "<cmd> Lspsaga outline <CR>", "Outline" },

    ["<leader>q"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    -- ["<leader>/"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

    ["<leader>p"] = { "<cmd> Telescope terms <CR>", "Pick hidden terminal" },
    ["<leader>m"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },

    ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

    ["<leader>w"] = { "<cmd> wa <CR> <cmd> q <CR>", "Write and close" },

    ["<S-Up>"] = {"<cmd> m-2<CR>=<CR>"},
    ["<S-Down>"] = {"<cmd> m+1<CR>=<CR>"},

    ["<C-d>"] = {"<C-d>zz"},
    ["<C-u>"] = {"<C-u>zz"},

    ["r"] = {[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]},

    ["F"] = { "<cmd> HopCamelCaseMW <CR>", "Hop anywhere" },
    ["T"] = { "<cmd> HopWordCurrentLine <CR>", "Hop current line" },

    ["n"] = { "nzz" },
    ["<S-n>"] = { "Nzz" },

    ["-"] = { "<cmd> NvimTreeFocus <CR>", "NVTree focus" },

    ["<leader><leader>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },
  },

  v = {
    ["F"] = { "<cmd> HopCamelCaseMW <CR>", "Hop anywhere" },
    ["T"] = { "<cmd> HopWordCurrentLine <CR>", "Hop current line" },
    ["<leader>y"] = { "<cmd> OSCYankVisual <CR>", "Yank over ssh" },
  },

  i = {
    ["<C-c>"] = {"<Esc>", "Exit from input mode"},
  }
}

return M
