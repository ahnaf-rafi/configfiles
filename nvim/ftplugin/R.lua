local keymap = vim.keymap.set
local opts = {silent = true, noremap = true, buffer = true}

opts.desc = "Open R REPL"
keymap(
  "n",
  "<localleader>r",
  -- ":<c-u>vsp|term://julia<cr>:lua print(vim.b.terminal_job_id)<cr>",
  ":<c-u>vnew |call termopen('R')<cr>:lua print(vim.b.terminal_job_id)<cr>",
  opts
)
