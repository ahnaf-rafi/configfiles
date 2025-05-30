return {
  "justinmk/vim-sneak",
  config = function()
    local keymap = vim.keymap -- for conciseness
    local opts = { noremap = true, silent = true }

    keymap.set("n", "f", "<Plug>Sneak_f", opts)
    keymap.set("n", "F", "<Plug>Sneak_F", opts)
    keymap.set("n", "t", "<Plug>Sneak_t", opts)
    keymap.set("n", "T", "<Plug>Sneak_F", opts)
  end
}
