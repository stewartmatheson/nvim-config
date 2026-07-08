return {
  cmd = { "vscode-eslint-language-server", "--stdio" },

  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
  },

  root_markers = {
    ".eslintrc",
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.json",
    ".eslintrc.cjs",
    "eslint.config.mjs",
  },

  settings = {
    nodePath = "",
    experimental = {
      useFlatConfig = true,
    },
    problems = {},
    rulesCustomizations = {},
    run = "onType",
    validate = "on",
  },

  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        client:request_sync("workspace/executeCommand", {
          command = "eslint.applyAllFixes",
          arguments = {
            {
              uri = vim.uri_from_bufnr(bufnr),
              version = vim.lsp.util.buf_versions[bufnr],
            },
          },
        }, 1000, bufnr)
      end,
    })
  end,
}
