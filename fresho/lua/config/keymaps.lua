return {
  {
    "<leader>?",
    function()
      require("which-key").show({ global = false })
    end,
    desc = "Buffer Local Keymaps (which-key)",
  },

  -- File finding
  { "<leader>oo", "<cmd>Oil<cr>", desc = "Oil" },

  -- Telescope fuzzy finding
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
  { "<leader>fw", "<cmd>Telescope live_grep<cr>", desc = "Grep Project" },
  { "<leader>fg", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },

  -- Built in LSP functions
  { "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
  { "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
  { "gi", vim.lsp.buf.implementation, desc = "Go to Implementation" },
  { "gr", vim.lsp.buf.references, desc = "Find References" },
  { "gt", vim.lsp.buf.type_definition, desc = "Type Definition" },

  { "<leader>rf", require("rspec").run_file, desc = "Run Current Spec File" },
  { "<leader>rl", require("rspec").run_line, desc = "Run Current Spec Line" },

  { "<leader>ha", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },
  { "<leader>ho", "<cmd>Lspsaga outline<cr>", desc = "Code Outline" },

  -- Git
  { "<leader>g", "<cmd>Git blame<cr>", desc = "Show Blame" },

  -- Navagation
  { "<tab>", "<cmd>bnext<cr>", desc = "Next Buffer" },
  { "<s-tab>", "<cmd>bprevious<cr>", desc = "Previous Buffer" },
}
