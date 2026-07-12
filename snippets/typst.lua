local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  -- Inline math
  s('mk', {
    t '$',
    i(1),
    t '$',
  }),

  -- Display math (block math in Typst is $ math $ on its own line)
  s('dm', {
    t { '$ ', '\t' },
    i(1),
    t { '', ' $' },
  }),

  -- Code block
  s('code', {
    t '```',
    i(1, 'typst'),
    t { '', '\t' },
    i(2),
    t { '', '```' },
  }),

  -- Image
  s('img', {
    t '#image("',
    i(1, 'path'),
    t '", width: ',
    i(2, '80%'),
    t ')'
  }),
}
