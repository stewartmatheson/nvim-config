local M = {}

function M.send_to_tmux(window_name, command, socket_name, debug)
  local debug = debug or false
  local session_name = "0"
  socket_name = socket_name or "default"

  -- Build the lookup command, scoped to the given socket

  local find_cmd = string.format(
    [[tmux -L %s list-windows -a -F '#{session_name}:#{window_name}:#{window_id}' | grep '^%s:%s:' | cut -d: -f3 | head -n1]],
    socket_name,
    session_name,
    window_name
  )

  if debug then
    print("[send_to_tmux] find_cmd: " .. find_cmd)
  end

  local raw_output = vim.fn.system(find_cmd)

  if debug then
    print("[send_to_tmux] raw window_id output: [" .. raw_output .. "]")
  end

  if vim.v.shell_error ~= 0 then
    vim.notify(
      string.format("[send_to_tmux] shell command failed with exit code %d", vim.v.shell_error),
      vim.log.levels.ERROR
    )
    return
  end

  local window_id = raw_output:gsub("%s+$", "")

  if debug then
    print("[send_to_tmux] trimmed window_id: [" .. window_id .. "]")
  end

  if window_id:find("\n") then
    vim.notify(
      string.format(
        "[send_to_tmux] multiple windows matched '%s:%s' on socket '%s' — window_id contains newline(s): [%s]",
        session_name,
        window_name,
        socket_name,
        window_id:gsub("\n", "\\n")
      ),
      vim.log.levels.ERROR
    )
    return
  end

  if window_id == "" then
    vim.notify(
      string.format(
        "[send_to_tmux] tmux window '%s' not found in session '%s' on socket '%s'",
        window_name,
        session_name,
        socket_name
      ),
      vim.log.levels.ERROR
    )
    return
  end

  local in_mode_cmd = string.format(
    [[tmux -L %s display-message -p -t %s '#{pane_in_mode}']],
    socket_name,
    window_id
  )
  local in_mode = vim.fn.system(in_mode_cmd):gsub("%s+$", "")

  if debug then
    print("[send_to_tmux] pane_in_mode: [" .. in_mode .. "]")
  end

  if in_mode == "1" then
    if debug then
      print("[send_to_tmux] pane is in copy mode, cancelling before send-keys")
    end

    vim.fn.system({
      "tmux",
      "-L",
      socket_name,
      "send-keys",
      "-t",
      window_id,
      "-X",
      "cancel",
    })

    if vim.v.shell_error ~= 0 then
      vim.notify(
        string.format("[send_to_tmux] failed to cancel copy mode for window_id=%s on socket '%s'", window_id, socket_name),
        vim.log.levels.ERROR
      )
      return
    end
  end

  if debug then
    print(string.format("[send_to_tmux] sending command to window_id=%s: %s", window_id, command))
  end

  local result = vim.fn.system({
    "tmux",
    "-L",
    socket_name,
    "send-keys",
    "-t",
    window_id,
    command,
    "C-m",
  })

  if vim.v.shell_error ~= 0 then
    vim.notify(
      string.format(
        "[send_to_tmux] tmux send-keys failed (exit %d) for window_id=%s on socket '%s': %s",
        vim.v.shell_error,
        window_id,
        socket_name,
        result
      ),
      vim.log.levels.ERROR
    )
    return
  end

  if debug then
    print("[send_to_tmux] send-keys succeeded")
  end
end

return M
