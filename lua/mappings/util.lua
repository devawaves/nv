local M = {}

function M.map(keymaps, keymap_opts, opts)
  opts = opts or {}
  local lazy_keymaps = opts.lazy and {}
  keymap_opts = keymap_opts or {}
  if opts.silent then
    keymap_opts.silent = true
  end
  for modes, maps in pairs(keymaps) do
    for _, m in pairs(maps) do
      local map_opts = vim.tbl_extend("force", keymap_opts, m[3] or {})
      if opts.lazy then
        table.insert(lazy_keymaps, vim.tbl_extend("force", { m[1], m[2], mode = modes }, map_opts))
      else
        vim.keymap.set(modes, m[1], m[2], map_opts)
      end
    end
  end
  return lazy_keymaps
end

function M.fish_style_abbr(abbr, expansion)
  return {
    abbr,
    function()
      local cmdline = vim.fn.getcmdline()
      local first_word = cmdline:match "%S+"
      local typing_command = vim.fn.getcmdtype() == ":" and vim.fn.getcmdpos() == (#first_word + 1)
      if not typing_command then
        return abbr
      end
      if type(expansion) == "function" then
        return expansion() or abbr
      end
      return expansion
    end,
    { remap = false, expr = true },
  }
end

return M
