return {
  -- 'echasnovski/mini.trailspace',
  -- version = false,
  -- config = function ()
  --   require('mini.trailspace').setup()
  -- end
  "johnfrankmorgan/whitespace.nvim",
  config = function ()
    require('whitespace-nvim').setup({
      -- `highlight` configures which highlight is used to display
      -- trailing whitespace
      highlight = 'DiffDelete',

      -- `ignored_filetypes` configures which filetypes to ignore when
      -- displaying trailing whitespace
      ignored_filetypes = { 'TelescopePrompt', 'Trouble', 'help' },

      -- `ignore_terminal` configures whether to ignore terminal buffers
      ignore_terminal = true,
    })

    -- remove trailing whitespace with a keybinding
    vim.keymap.set('n', '<leader>fw', require('whitespace-nvim').trim)
  end
}
