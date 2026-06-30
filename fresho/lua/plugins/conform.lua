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

    format_on_save = {
      timeout_ms = 1000,
      lsp_format = "fallback",
    },
  },
}
