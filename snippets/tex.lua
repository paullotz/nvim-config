local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node

return {
	-- Basic document template
	s("doc", {
		t("\\documentclass["),
		c(1, {
			t("12pt"),
			t("11pt"),
			t("10pt"),
		}),
		t("]{"),
		c(2, {
			t("article"),
			t("report"),
			t("book"),
			t("letter"),
		}),
		t("}"),
		t({ "", "" }),

		-- Common packages
		t({ "\\usepackage[utf8]{inputenc}", "" }),
		t({ "\\usepackage[T1]{fontenc}", "" }),
		t({ "\\usepackage{amsmath,amsfonts,amssymb}", "" }),
		t({ "\\usepackage{graphicx}", "" }),
		t({ "\\usepackage[margin=1in]{geometry}", "" }),
		t({ "\\usepackage{hyperref}", "" }),
		t({ "", "" }),

		-- Title information
		t("\\title{"),
		i(3, "Document Title"),
		t("}"),
		t({ "", "" }),
		t("\\author{"),
		i(4, "Your Name"),
		t("}"),
		t({ "", "" }),
		t("\\date{"),
		c(5, {
			t("\\today"),
			i(1, "Custom Date"),
		}),
		t("}"),
		t({ "", "", "" }),

		-- Document body
		t({ "\\begin{document}", "" }),
		t({ "", "\\maketitle", "" }),
		t({ "", "\\begin{abstract}", "" }),
		i(6, "Write your abstract here..."),
		t({ "", "\\end{abstract}", "" }),
		t({ "", "\\section{Introduction}", "" }),
		i(7, "Write your introduction here..."),
		t({ "", "", "\\section{Methods}", "" }),
		i(8, "Describe your methods here..."),
		t({ "", "", "\\section{Results}", "" }),
		i(9, "Present your results here..."),
		t({ "", "", "\\section{Conclusion}", "" }),
		i(0, "Write your conclusion here..."),
		t({ "", "", "\\end{document}" }),
	}),

	-- Simple document template
	s("simpledoc", {
		t("\\documentclass{article}"),
		t({ "", "\\usepackage[utf8]{inputenc}", "" }),
		t({ "\\usepackage{amsmath}", "" }),
		t({ "\\usepackage{graphicx}", "" }),
		t({ "", "\\title{" }),
		i(1, "Title"),
		t("}"),
		t({ "", "\\author{" }),
		i(2, "Author"),
		t("}"),
		t({ "", "\\date{\\today}", "" }),
		t({ "", "\\begin{document}", "" }),
		t({ "\\maketitle", "" }),
		t({ "", "" }),
		i(0, "Content goes here..."),
		t({ "", "", "\\end{document}" }),
	}),

	-- Letter template
	s("letter", {
		t("\\documentclass{letter}"),
		t({ "", "\\usepackage[utf8]{inputenc}", "" }),
		t({ "", "\\address{" }),
		i(1, "Your Address\\\\City, State ZIP"),
		t("}"),
		t({ "", "", "\\begin{document}", "" }),
		t({ "", "\\begin{letter}{" }),
		i(2, "Recipient Address\\\\City, State ZIP"),
		t("}"),
		t({ "", "", "\\opening{Dear " }),
		i(3, "Sir/Madam"),
		t(",}"),
		t({ "", "", "" }),
		i(4, "Letter content goes here..."),
		t({ "", "", "\\closing{Sincerely,}" }),
		t({ "", "\\end{letter}", "" }),
		t({ "\\end{document}" }),
	}),

	-- Beamer presentation template
	s("beamer", {
		t("\\documentclass{beamer}"),
		t({ "", "\\usepackage[utf8]{inputenc}", "" }),
		t({ "\\usepackage{amsmath,amsfonts,amssymb}", "" }),
		t({ "\\usepackage{graphicx}", "" }),
		t({ "", "\\usetheme{" }),
		c(1, {
			t("Madrid"),
			t("Berlin"),
			t("Warsaw"),
			t("Copenhagen"),
		}),
		t("}"),
		t({ "", "", "\\title{" }),
		i(2, "Presentation Title"),
		t("}"),
		t({ "", "\\author{" }),
		i(3, "Your Name"),
		t("}"),
		t({ "", "\\institute{" }),
		i(4, "Your Institution"),
		t("}"),
		t({ "", "\\date{\\today}", "" }),
		t({ "", "\\begin{document}", "" }),
		t({ "", "\\frame{\\titlepage}", "" }),
		t({ "", "\\begin{frame}{Outline}", "" }),
		t({ "\\tableofcontents", "" }),
		t({ "\\end{frame}", "" }),
		t({ "", "\\section{Introduction}", "" }),
		t({ "\\begin{frame}{" }),
		i(5, "Frame Title"),
		t("}"),
		t({ "", "" }),
		i(0, "Frame content goes here..."),
		t({ "", "", "\\end{frame}", "" }),
		t({ "", "\\end{document}" }),
	}),
}
