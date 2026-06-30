vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.termguicolors = true

require("config.lazy")

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 
    'ruby', 
    'eruby', 
    'html', 
    'css', 
    'scss', 
    'markdown', 
    'typescript', 
    'javascript', 
    'javascriptreact', 
    'lua',
  },
  callback = function() vim.treesitter.start() end,
})

vim.lsp.enable('ruby-lsp')
vim.lsp.enable('eslint')
vim.lsp.enable('ts_ls')
vim.lsp.enable('bashls')
vim.lsp.enable('html')

vim.diagnostic.config({
  virtual_text = false, -- less clutter
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = {
        "BufLeave",
        "CursorMoved",
        "InsertEnter",
        "FocusLost",
      },
      border = "rounded",
      source = "if_many",
      scope = "cursor",
    })
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.rb", "*.js", "*.mjs", "*.ts", "*.tsx" },
  callback = function()
    local ft = vim.bo.filetype
    if ft == "javascript" or ft == "typescript" or ft == "typescriptreact" then
      vim.lsp.buf.code_action({
        apply = true,
        context = { only = { "source.fixAll.eslint" } },
      })
    else
      vim.lsp.buf.format({ async = false })
    end
  end,
})


vim.cmd("colorscheme tokyonight-storm")
require('lualine').setup()

