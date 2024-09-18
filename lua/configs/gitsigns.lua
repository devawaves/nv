local conf = require 'nvchad.configs.gitsigns'

conf.signcolumn = true
conf.numhl = false
conf.linehl = false
conf.word_diff = false
conf.watch_gitdir = {
  interval = 1000,
  follow_files = true
}
conf.attach_to_untracked = true
conf.current_line_blame = false -- Toggle with `:Gitsigns toggle_current_line_blame`
conf.current_line_blame_conf = {
  virt_text = true,
  virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
  delay = 1000,
  ignore_whitespace = false,
}
conf.current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>"
conf.sign_priority = 6
conf.status_formatter = nil
conf.update_debounce = 200
conf.max_file_length = 40000
conf.preview_config = {
  border = "rounded",
  style = "minimal",
  relative = "cursor",
  row = 0,
  col = 1,
}

return conf
