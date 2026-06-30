local M = {}

local function current_socket_name()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
end

function M.run_file()
  local file = vim.fn.expand("%")
  require("tmux").send_to_tmux(
    "scratch",
    "bundle exec rspec " .. file,
    current_socket_name()
  )
end

function M.run_line()
  local file = vim.fn.expand("%")
  local line = vim.fn.line(".")
  require("tmux").send_to_tmux(
    "scratch",
    string.format("bundle exec rspec %s:%d", file, line),
    current_socket_name()
  )
end

return M
