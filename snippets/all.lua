local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node

return {
  s('mail', {
    t 'paul.lotz@gmx.at',
  }),
  s('gh', {
    t 'https://github.com/paullotz',
  }),
}
