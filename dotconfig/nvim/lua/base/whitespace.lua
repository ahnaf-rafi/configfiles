-- Whitespace highlights
local opt = vim.opt
-- Enable the list mode to show special characters.
opt.list = true
-- Define the characters to use for specific whitespace types
opt.listchars = {
  -- Tabs shown as a double arrow followed by a dot.
  tab = '»·',
  -- Leading spaces shown as a middle dot.
  lead = '·',
  -- Trailing spaces shown as a bullet point.
  trail = '•',
  -- End of line marker.
  eol = '↵',
  -- Non-breaking space marker.
  nbsp = '␣',
  -- Non-breaking space marker.
  multispace = '␣␣',
}

-- Highlight trailing whitespaces.
vim.api.nvim_set_hl(0, 'TrailingWhitespace', { bg='LightRed' })
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.buftype ~= "terminal" then
      vim.cmd([[
      syntax clear TrailingWhitespace |
      syntax match TrailingWhitespace "\_s\+$" containedin=ALL display
      ]])
    end
  end
})

-- Strip trailing whitespaces before save.
-- Note: this only strips spaces at the end of a line. It does not get rid of
-- unnecessary new lines. The highlighting above does highlight unnecessary new
-- lines, but automatic stripping can some unintended consequences (e.g.
-- killing all empty lines, which can be unwanted behavior - you may want empty
-- new lines between function definitions for example).
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Save cursor position
    local save_cursor = vim.api.nvim_win_get_cursor(0)

    -- Check if there are trailing whitespaces to avoid unnecessary undo-joins
    local last_line = vim.api.nvim_buf_line_count(0)
    local lines = vim.api.nvim_buf_get_lines(0, 0, last_line, false)
    local has_trailing = false
    for _, line in ipairs(lines) do
      if line:match("%s+$") or line == "" then
        has_trailing = true
        break
      end
    end

    -- Strip trailing whitespaces.
    if has_trailing then
      -- Notes: 'undojoin' merges the next command into the previous change
      -- so the stripping isn't a separate 'undo' step; 'keeeeppatterns'
      -- prevents the search history (/) from being cluttered.
      vim.cmd([[silent! undojoin | keeppatterns %s/\s\+$//e]])
    end

    -- Restore cursor position
    vim.api.nvim_win_set_cursor(0, save_cursor)
  end,
})

-- Highlight multiple spaces between words, except before comment character,
-- for certain filetypes.
vim.api.nvim_set_hl(0, 'MultiSpace', { bg = 'LightGreen' })
vim.api.nvim_create_autocmd({ 'BufEnter', 'FileType' }, {
  pattern = { '*.tex', '*.bib', '*.typ', '*.md', '*.txt' },
  callback = function()
    local cms = vim.bo.commentstring
    local comment_char = cms:gsub('%%s', ''):gsub('%s+', '')
    if comment_char == "" then
      comment_char = "%"
    end
    local escaped_char = vim.fn.escape(comment_char, '/\\*^$.')
    local regex = [[\S\zs \{2,}\ze\(\s*]] .. escaped_char .. [[\)\@!\S]]
    -- The 'containedin=ALL' forces the highlight to work even inside strings
    -- or comments.
    local cmd = string.format(
      'syntax match MultiSpace /%s/ containedin=ALL display',
      regex
    )
    vim.cmd('syntax clear MultiSpace')
    vim.cmd(cmd)

  end,
})
