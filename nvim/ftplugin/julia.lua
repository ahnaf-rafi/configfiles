-- vim.opt_local.foldmethod  = 'indent'
vim.opt_local.expandtab   = true
vim.opt_local.shiftwidth  = 4
vim.opt_local.softtabstop = 4

local keymap = vim.keymap.set
local opts = {silent = true, noremap = true, buffer = true}

keymap(
  'n',
  '<c-c><c-c>',
  ':<c-u>call slime#send(getline(\".\") . \"\\n\")<cr>',
  opts
)

keymap(
  'v',
  '<c-c><c-c>',
  ':<c-u>call slime#send(getline(\".\") . \"\\n\")<cr>',
  opts
)

opts.desc = "Open Julia REPL"
keymap(
  "n",
  "<localleader>r",
  -- ":<c-u>vsp|term://julia<cr>:lua print(vim.b.terminal_job_id)<cr>",
  ":<c-u>vnew |call termopen('julia --project=@.')<cr>:lua print(vim.b.terminal_job_id)<cr>",
  opts
)
