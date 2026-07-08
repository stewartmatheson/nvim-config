return {
  "stevearc/conform.nvim",
  opts = {
    formatters = {
      pandoc = {
        command = "pandoc",
        args = {
          "-f",
          "markdown",
          "-t",
          "markdown",
        },
        stdin = true,
      },
    },

    formatters_by_ft = {
      markdown = { "pandoc" },
      sh = { "shfmt" },
      bash = { "shfmt" },
    },

    format_on_save = function(bufnr)
      local ft = vim.bo[bufnr].filetype
      local eslint_handles = {
        javascript = true,
        javascriptreact = true,
        typescript = true,
        typescriptreact = true,
      }
      -- eslint's own BufWritePre autocmd (lsp/eslint.lua) already fixes/formats
      -- these; letting conform's LSP fallback also format them means two
      -- formatters (tsserver vs eslint) fight over style on every save.
      if eslint_handles[ft] then
        return nil
      end
      return { timeout_ms = 1000, lsp_format = "fallback" }
    end,
  },
}
