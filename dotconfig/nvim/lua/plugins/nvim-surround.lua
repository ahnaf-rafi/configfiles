return {
  "nvim-mini/mini.surround",
  version = false,
  event = "VeryLazy",
  config = function()
    -- Set up mini.surround to emulate tpope/vim-surround.
    require('mini.surround').setup({
      mappings = {
        add = 'ys',
        delete = 'ds',
        find = '',
        find_left = '',
        highlight = '',
        replace = 'cs',
        update_n_lines = '',
        -- Add this to avoid extended mappings.
        -- suffix_last = '',
        -- suffix_next = '',
      },
      search_method = 'cover_or_next',
    })

    -- Remap adding surrounding to Visual mode selection
    vim.keymap.del('v', 'ys')
    vim.keymap.set(
      'v', 'S', [[:<C-u>lua MiniSurround.add('visual')<CR>]], { silent = true }
    )

    -- Make special mapping for "add surrounding for line"
    vim.keymap.set('n', 'yss', 'ys_', { remap = true })
  end
}
