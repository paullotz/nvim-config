local ls = require("luasnip")
local extras = require("luasnip.extras")

require("luasnip").filetype_extend("typescript", {"typescriptreact"})
require("luasnip").filetype_extend("javascript", {"typescriptreact"})

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = extras.rep

return {
  s("rafce", {
    t("import { type FC } from 'react';"),
    t({ "", "", "" }),
    t("type "),
    i(1, "Props"),
    t(" = {"),
    t({ "", "  " }),
    i(2, "// props"),
    t({ "", "}" }),
    t({ "", "", "" }),
    t("export const "),
    i(3, "ComponentName"),
    t(": FC<"),
    rep(1),
    t("> = ({ "),
    i(4),
    t("}) => {"),
    t({ "", "  return (" }),
    t({ "", "    <div>" }),
    t({ "", "      " }),
    i(0),
    t({ "", "    </div>" }),
    t({ "", "  );" }),
    t({ "", "}" }),
    t({ "", "", "" }),
  }),
  s("useState", {
    t("const ["),
    i(1, "state"),
    t(", set"),
    -- CHANGED BELOW: t -> f, and 1 -> {1}
    f(function(args) return args[1][1]:gsub("^%l", string.upper) end, {1}),
    t("] = useState<"),
    i(2, "Type"),
    t(">("),
    i(0),
    t(");"),
  }),
  s("useEffect", {
    t("useEffect(() => {"),
    t({ "", "  " }),
    i(0),
    t({ "", "" }),
    t("}, ["),
    i(1, ""),
    t("]);"),
  }),
  s("useRef", {
    t("const "),
    i(1, "ref"),
    t(" = useRef<"),
    i(2, "Type"),
    t(">(null);"),
  }),
  s("fc", {
    t("const "),
    i(1, "ComponentName"),
    t(": React.FC = () => {"),
    t({ "", "  return (" }),
    t({ "", "    <div>" }),
    t({ "", "      " }),
    i(0),
    t({ "", "    </div>" }),
    t({ "", "  );" }),
    t({ "", "};", "" }),
  }),
  s("page", {
    t("import React from 'react';"),
    t({ "", "" }),
    t("export default function "),
    i(1, "PageName"),
    t("() {"),
    t({ "", "  return (" }),
    t({ "", "    <div>" }),
    t({ "", "      " }),
    i(0),
    t({ "", "    </div>" }),
    t({ "", "  );" }),
    t({ "", "}", "" }),
  }),
  s("layout", {
    t("import React from 'react';"),
    t({ "", "" }),
    t("export default function RootLayout({"),
    t({ "  children," }),
    t("}: {"),
    t({ "  children: React.ReactNode;" }),
    t("}) {"),
    t({ "  return (" }),
    t({ "    <html>" }),
    t({ "      <body>" }),
    t({ "        {children}" }),
    t({ "      </body>" }),
    t({ "    </html>" }),
    t({ "  );" }),
    t({ "}", "" }),
  }),
}