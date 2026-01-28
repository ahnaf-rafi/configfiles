-- Whitespace highlights
-- Enable the list mode to show special characters.
opt.list = true

-- Define the characters to use for specific whitespace types
opt.listchars = {
  tab = '»·',     -- Tabs shown as a double arrow followed by a dot.
  lead = '·',     -- Leading spaces shown as a middle dot.
  trail = '•',    -- Trailing spaces shown as a bullet point.
  eol = '↵',      -- End of line marker.
  nbsp = '␣',     -- Non-breaking space marker.
}
