-- Custom snippets for React, TypeScript, and more
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- Helper functions
local function get_filename_no_ext()
  return vim.fn.expand("%:t:r")
end

local function pascal_case(str)
  return str:gsub("(%a)([%w_]*)", function(first, rest)
    return first:upper() .. rest:lower():gsub("_(%a)", function(c) return c:upper() end)
  end)
end

-- React TypeScript snippets
ls.add_snippets("typescriptreact", {
  -- React Functional Component
  s("rfc", {
    t("import React from 'react';"), t({"", "", "interface "}),
    f(function() return pascal_case(get_filename_no_ext()) end),
    t({"Props {", "  "}), i(1, "// props"), t({"", "}", "", "const "}),
    f(function() return pascal_case(get_filename_no_ext()) end),
    t(": React.FC<"), 
    f(function() return pascal_case(get_filename_no_ext()) end),
    t({"Props> = ({ "}), i(2, ""), t({" }) => {", "  return (", "    <div>", "      "}),
    i(3, "// component content"), t({"", "    </div>", "  );", "};", "", "export default "}),
    f(function() return pascal_case(get_filename_no_ext()) end), t(";")
  }),

  -- TypeScript Interface
  s("tsi", {
    t("export interface "), 
    f(function() return pascal_case(get_filename_no_ext()) end),
    t({" {", "  "}), i(1, "property"), t(": "), i(2, "string"), t(";"),
    t({"", "  "}), i(3, "// additional properties"), t({"", "}"})
  }),
})

-- JavaScript/TypeScript general snippets
local js_snippets = {
  -- Console log
  s("cl", {
    t("console.log("), i(1, ""), t(");")
  }),
  
  -- Console log with label
  s("cll", {
    t("console.log('"), i(1, "label"), t(":', "), i(2, "value"), t(");")
  }),
  
  -- Import statement
  s("imp", {
    t("import "), i(1, "{ }"), t(" from '"), i(2, "module"), t("';")
  }),
  
  -- Export default
  s("exp", {
    t("export default "), i(1, "component"), t(";")
  }),
}

-- Add snippets to multiple filetypes
ls.add_snippets("javascript", js_snippets)
ls.add_snippets("typescript", js_snippets)
ls.add_snippets("typescriptreact", js_snippets)
ls.add_snippets("javascriptreact", js_snippets)

-- MDX snippets
ls.add_snippets("mdx", {
  -- Code block with title
  s("code", {
    t("```"), i(1, "typescript"), t(" title=\""), i(2, "filename.ts"), t({"\"", ""}),
    i(3, "// code here"), t({"", "```"})
  }),
  
  -- Article template (simplified)
  s("article", {
    t({"---", "title: \""}), i(1, "Article Title"), t({"\"", "date: \""}),
    f(function() return os.date("%Y-%m-%d") end),
    t({"\"", "description: \""}), i(2, "Article description"), t({"\"", "author: \"Cary Wolff\"", "---", "", "# "}),
    rep(1), t({"", "", ""}), i(3, "Article content goes here...")
  }),
})

-- Load existing friendly snippets
require("luasnip.loaders.from_vscode").lazy_load()