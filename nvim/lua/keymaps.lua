local keymap = vim.keymap.set
local opts = {silent = true, noremap = true}

--  NOTE: Must happen before plugins are required (otherwise wrong leader will
--  be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " m"

keymap({"n", "v"}, "j", "gj", opts)
keymap({"n", "v"}, "k", "gk", opts)
keymap("v", "<", "<gv", opts)                   -- Better indent in visual
keymap("v", ">", ">gv", opts)                   -- Better dedent in visual
keymap({"i", "v"}, "fd", "<esc>", opts)         -- fd = esc in insert
keymap("t", "<c-f><c-d>", "<c-\\><c-n>", opts)  -- <c-f><c-d> = esc in term
keymap("i", "<m-b>", "<c-left>", opts)
keymap("i", "<m-f>", "<c-right>", opts)
keymap("i", "<c-b>", "<left>", opts)
keymap("i", "<c-f>", "<right>", opts)
keymap({"n", "v"}, "<leader>fs", ":w<cr>", opts)

opts.desc = "+window"
keymap("n", "<leader>w", "<c-w>", opts)

opts.desc = "delete"
keymap('n', '<c-w>x', ':<c-u>bdel<cr>', opts)
keymap('n', '<leader>wx', ':<c-u>bdel<cr>', opts)

opts.desc = 'Copy Absolute Path'
keymap('n', '<leader>fyy', ':<c-u>let @+=expand("%:p")<cr>', opts)

opts.desc = 'Copy Directory Path'
keymap('n', '<leader>fyd', ':<c-u>let @+=expand("%:p:h")<cr>', opts)

opts.desc = 'Copy File Name'
keymap('n', '<leader>fyn', ':<c-u>let @+=expand("%:t")<cr>', opts)

opts.desc = 'Copy Relative File Name'
keymap('n', '<leader>fyr', ':<c-u>let @+=expand("%")<cr>', opts)

opts.desc = 'Delete Buffer'
keymap('n', '<leader>bd', ':<c-u>bprev<cr>:bdel #<cr>', opts)

opts.desc = 'Previous Buffer'
keymap('n', '<leader>bp', ':<c-u>bprev<cr>', opts)
keymap('n', '<leader>b[', ':<c-u>bprev<cr>', opts)

opts.desc = 'Next Buffer'
keymap('n', '<leader>bn', ':<c-u>bnext<cr>', opts)
keymap('n', '<leader>b]', ':<c-u>bnext<cr>', opts)

opts.desc = 'Clear search'
keymap('n', '<leader>sc', ':nohl<cr>', opts)

opts.desc = 'Terminal Other Window'
keymap('n', '<leader>at', ':<c-u>vsp | term<cr>', opts)

opts.desc = 'Terminal Current Window'
keymap('n', '<leader>aT', ':<c-u>term<cr>', opts)
