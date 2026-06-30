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
      useFlatConfig = false,
    },
    problems = {},
    rulesCustomizations = {},
  },
}
