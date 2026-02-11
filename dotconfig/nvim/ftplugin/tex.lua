vim.opt_local.spelllang = 'en_us'
vim.opt_local.spell = true
vim.opt_local.cindent = false
vim.opt_local.textwidth = 80

local opts = { silent = true, noremap = true, buffer = true }

vim.keymap.set('i', '_', '_{}<left>', opts)
vim.keymap.set('i', '^', '^{}<left>', opts)
vim.keymap.set('i', '$', '\\(\\)<left><left>', opts)
vim.keymap.set('i', '\"', '``\'\'<left><left>', opts)
vim.keymap.set('i', "<C-'>", '\\', opts)

-- lua vim.keymap.set('i', '\"', '``\'\'<left><left>', { silent = true, noremap = true, buffer = true })
