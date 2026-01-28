return {
  "ibhagwan/fzf-lua", 
  config = function()
    local keyopts = { silent = true, noremap = true }
    local keymap = vim.keymap.set
    require('fzf-lua').setup()
    keymap({"n", "v"}, "<leader>ff", FzfLua.files, keyopts)
    keymap({"n", "v"}, "<leader>fr", FzfLua.oldfiles, keyopts)
    keymap({"n", "v"}, "<leader>bb", FzfLua.buffers, keyopts)
  end
}
