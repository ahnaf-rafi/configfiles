return {
  'ibhagwan/fzf-lua',
  config = function()
    local FzfLua = require('fzf-lua')
    local keyopts = { silent = true, noremap = true }
    local keymap = vim.keymap.set
    local nv = {'n', 'v'}

    -- Wrapper that returns a function call for easy passage to vim.keymap.set.
    local fzflua_files = function(opts)
      return function()
        FzfLua.files(opts)
      end
    end

    FzfLua.setup()

    keymap(nv, '<leader><leader>', FzfLua.files, keyopts)
    keymap(nv, '<leader>ff', fzflua_files({ no_ignore = true }), keyopts)
    keymap(nv, '<leader>fp', fzflua_files({ cwd = '~/configfiles/'}), keyopts)
    keymap(nv, '<leader>fr', FzfLua.oldfiles, keyopts)
    keymap(nv, '<leader>bb', FzfLua.buffers, keyopts)
  end
}
