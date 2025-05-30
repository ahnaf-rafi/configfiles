vim.opt_local.spelllang = 'en_us'
vim.opt_local.spell     = true
vim.opt_local.cindent   = false
vim.opt_local.textwidth = 80

local keymap = vim.keymap.set
local opts = {silent = true, noremap = true, buffer = true}

keymap('i', '_', '_{}<left>', opts)
keymap('i', '^', '^{}<left>', opts)
keymap('i', '$', '\\(\\)<left><left>', opts)
keymap('i', '\"', '``\'\'<left><left>', opts)
keymap('i', "<C-'>", '\\', opts)

keymap('n', '<localleader>t', ':call vimtex#fzf#run()<cr>', opts)
keymap('n', '<localleader>a', ':w<cr>:VimtexCompileSS<cr>', opts)

-- Map (save + single shot compilation) and viewer commands.
-- opts.desc = "Save and compile"
-- keymap('n', '<localleader>a', ':<c-u>w<cr>:<c-u>VimtexCompileSS<cr>', opts)
--
-- opts.desc = "View"
-- keymap('n', '<localleader>v', '<cmd> VimtexView<cr>', opts)
--
-- opts.desc = "Clean"
-- keymap('n', '<localleader>c', '<cmd> VimtexClean<cr>', opts)
--
-- opts.desc = "Table of contents"
-- keymap('n', '<localleader>;', '<cmd> VimtexTocToggle<cr>', opts)
