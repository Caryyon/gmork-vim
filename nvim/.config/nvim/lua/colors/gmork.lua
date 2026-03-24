-- Gmork colorscheme for Neovim
-- Inspired by the black wolf from The Neverending Story
-- A dark, atmospheric theme with luminous green eyes in blue-black darkness
--
-- Palette Philosophy:
-- - Backgrounds: Blue-black tones (Gmork's fur)
-- - Primary accent: Luminous green (Gmork's glowing eyes)
-- - Secondary accent: Storm purple (The Nothing)
-- - Danger: Blood crimson (not neon)
-- - Text: Bone/fang white (slightly warm)

local M = {}

-- Color palette - Gmork inspired from The NeverEnding Story
-- Matching Alacritty and tmux for consistency
local colors = {
  -- === BACKGROUNDS (Gmork's Blue-Black Fur) ===
  void = "#0a0a12",             -- Deepest blue-black
  shadow = "#12121a",           -- Dark blue-black
  cave = "#1c1c26",             -- Cave darkness
  cave_stone = "#2a2a36",       -- Lighter cave
  stone = "#3f3f4a",            -- Cave stone highlight

  -- === GMORK'S EYES (Primary Accent - Luminous Green) ===
  eye_glow = "#3edd78",         -- Main luminous green
  eye_shine = "#4ade80",        -- Brighter eye shine
  eye_dim = "#166534",          -- Dim glow in darkness

  -- === THE NOTHING (Storm & Void - Purple) ===
  storm = "#2d1b4e",            -- Dark storm clouds
  void_purple = "#4c1d95",      -- The Nothing's void
  lightning = "#7c3aed",        -- Lightning flash
  lightning_bright = "#a78bfa", -- Bright lightning

  -- === BLOOD & DANGER (Crimson, not neon) ===
  blood = "#dc2626",            -- Blood crimson
  wound = "#991b1b",            -- Darker wound
  ember = "#ea580c",            -- Ember orange
  ember_bright = "#f97316",     -- Bright ember

  -- === BONE & MIST (Text colors) ===
  fang = "#f4f4f5",             -- Fang white (main text)
  bone = "#d4d4d8",             -- Bone (secondary text)
  mist = "#a1a1aa",             -- Mist gray
  fog = "#71717a",              -- Fog (dimmed)

  -- === EARTH & CAVE ===
  root = "#78350f",             -- Cave roots (brown)
  moss = "#365314",             -- Cave moss

  -- === ADDITIONAL COLORS ===
  cyan = "#22d3ee",             -- Pale cyan (for terminal compat)
  cyan_bright = "#67e8f9",      -- Bright cyan
}

-- Apply the colorscheme
function M.setup()
  -- Clear existing highlighting
  vim.cmd("hi clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  -- Set background
  vim.o.background = "dark"
  vim.g.colors_name = "gmork"

  -- Helper function
  local function hi(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
  end

  -- Base colors (blue-black background to match Alacritty)
  hi("Normal", { fg = colors.fang, bg = colors.void })
  hi("NonText", { fg = colors.stone })

  -- UI Elements (blue-black backgrounds)
  hi("CursorLine", { bg = colors.shadow })
  hi("CursorColumn", { bg = colors.shadow })
  hi("LineNr", { fg = colors.fog })
  hi("CursorLineNr", { fg = colors.mist, bg = colors.shadow, bold = true })
  hi("SignColumn", { fg = colors.fog, bg = colors.void })
  hi("ColorColumn", { bg = colors.shadow })

  -- Selection and search
  hi("Visual", { bg = colors.cave_stone })
  hi("Search", { fg = colors.void, bg = colors.lightning })
  hi("IncSearch", { fg = colors.void, bg = colors.eye_shine })

  -- Splits and statusline
  hi("VertSplit", { fg = colors.cave_stone, bg = colors.void })
  hi("StatusLine", { fg = colors.fang, bg = colors.cave })
  hi("StatusLineNC", { fg = colors.mist, bg = colors.shadow })

  -- Tabs
  hi("TabLine", { fg = colors.mist, bg = colors.shadow })
  hi("TabLineFill", { bg = colors.shadow })
  hi("TabLineSel", { fg = colors.fang, bg = colors.cave, bold = true })

  -- Popup menus
  hi("Pmenu", { fg = colors.fang, bg = colors.cave })
  hi("PmenuSel", { fg = colors.void, bg = colors.eye_shine })
  hi("PmenuSbar", { bg = colors.cave_stone })
  hi("PmenuThumb", { bg = colors.stone })

  -- Folding
  hi("Folded", { fg = colors.mist, bg = colors.shadow })
  hi("FoldColumn", { fg = colors.fog, bg = colors.void })

  -- Syntax highlighting
  hi("Comment", { fg = colors.mist, italic = true })
  hi("String", { fg = colors.eye_glow })
  hi("Character", { fg = colors.eye_shine })
  hi("Number", { fg = colors.ember })
  hi("Boolean", { fg = colors.eye_shine })
  hi("Float", { fg = colors.ember })

  hi("Identifier", { fg = colors.fang })
  hi("Function", { fg = colors.eye_shine })

  hi("Statement", { fg = colors.blood, bold = true })
  hi("Conditional", { fg = colors.blood })
  hi("Repeat", { fg = colors.blood })
  hi("Label", { fg = colors.ember_bright })
  hi("Operator", { fg = colors.mist })
  hi("Keyword", { fg = colors.blood })
  hi("Exception", { fg = colors.wound })

  hi("PreProc", { fg = colors.eye_glow })
  hi("Include", { fg = colors.eye_glow })
  hi("Define", { fg = colors.eye_glow })
  hi("Macro", { fg = colors.eye_glow })
  hi("PreCondit", { fg = colors.eye_glow })

  hi("Type", { fg = colors.eye_shine })
  hi("StorageClass", { fg = colors.eye_shine })
  hi("Structure", { fg = colors.eye_shine })
  hi("Typedef", { fg = colors.eye_shine })

  hi("Special", { fg = colors.ember_bright })
  hi("SpecialChar", { fg = colors.ember })
  hi("Tag", { fg = colors.ember_bright })
  hi("Delimiter", { fg = colors.mist })
  hi("SpecialComment", { fg = colors.mist, italic = true })
  hi("Debug", { fg = colors.wound })
  
  -- Errors and warnings
  hi("Error", { fg = colors.fang, bg = colors.wound })
  hi("ErrorMsg", { fg = colors.fang, bg = colors.wound })
  hi("WarningMsg", { fg = colors.void, bg = colors.ember })

  -- Diff colors
  hi("DiffAdd", { fg = colors.eye_shine, bg = colors.shadow })
  hi("DiffChange", { fg = colors.ember, bg = colors.shadow })
  hi("DiffDelete", { fg = colors.blood, bg = colors.shadow })
  hi("DiffText", { fg = colors.void, bg = colors.ember })

  -- Spell checking
  hi("SpellBad", { fg = colors.blood, underline = true })
  hi("SpellCap", { fg = colors.ember, underline = true })
  hi("SpellLocal", { fg = colors.eye_glow, underline = true })
  hi("SpellRare", { fg = colors.lightning, underline = true })

  -- Git signs and other plugins
  hi("GitSignsAdd", { fg = colors.eye_shine })
  hi("GitSignsChange", { fg = colors.ember })
  hi("GitSignsDelete", { fg = colors.blood })

  -- LSP and diagnostics
  hi("DiagnosticError", { fg = colors.blood })
  hi("DiagnosticWarn", { fg = colors.ember })
  hi("DiagnosticInfo", { fg = colors.eye_glow })
  hi("DiagnosticHint", { fg = colors.mist })

  -- Telescope (if used)
  hi("TelescopeBorder", { fg = colors.cave_stone })
  
  -- MDX and Markdown specific enhancements
  hi("markdownH1", { fg = colors.fang, bold = true })
  hi("markdownH2", { fg = colors.blood, bold = true })
  hi("markdownH3", { fg = colors.eye_shine, bold = true })
  hi("markdownH4", { fg = colors.ember, bold = true })
  hi("markdownH5", { fg = colors.lightning, bold = true })
  hi("markdownH6", { fg = colors.mist, bold = true })

  hi("markdownCode", { fg = colors.ember, bg = colors.shadow })
  hi("markdownCodeBlock", { fg = colors.ember, bg = colors.shadow })
  hi("markdownCodeDelimiter", { fg = colors.stone })

  hi("markdownLink", { fg = colors.eye_glow, underline = true })
  hi("markdownLinkText", { fg = colors.eye_shine })
  hi("markdownLinkDelimiter", { fg = colors.stone })
  hi("markdownUrl", { fg = colors.eye_glow })

  hi("markdownBold", { fg = colors.fang, bold = true })
  hi("markdownItalic", { fg = colors.fang, italic = true })
  hi("markdownBoldItalic", { fg = colors.fang, bold = true, italic = true })

  hi("markdownBlockquote", { fg = colors.mist, italic = true })
  hi("markdownRule", { fg = colors.cave_stone })

  hi("markdownListMarker", { fg = colors.blood })
  hi("markdownOrderedListMarker", { fg = colors.blood })

  -- MDX JSX components
  hi("mdxJSX", { fg = colors.eye_shine })
  hi("mdxJsxBlock", { fg = colors.eye_shine })
  hi("mdxJsxElement", { fg = colors.eye_shine })
  hi("mdxComponent", { fg = colors.eye_glow, bold = true })
  hi("mdxImport", { fg = colors.blood })
  hi("mdxExport", { fg = colors.blood })

  -- Tree-sitter MDX highlighting
  hi("@text.literal.markdown", { fg = colors.ember, bg = colors.shadow })
  hi("@text.title.markdown", { fg = colors.fang, bold = true })
  hi("@text.title.1.markdown", { fg = colors.fang, bold = true })
  hi("@text.title.2.markdown", { fg = colors.blood, bold = true })
  hi("@text.title.3.markdown", { fg = colors.eye_shine, bold = true })
  hi("@text.title.4.markdown", { fg = colors.ember, bold = true })
  hi("@text.title.5.markdown", { fg = colors.lightning, bold = true })
  hi("@text.title.6.markdown", { fg = colors.mist, bold = true })

  hi("@text.quote.markdown", { fg = colors.mist, italic = true })
  hi("@text.uri.markdown", { fg = colors.eye_glow, underline = true })
  hi("@text.emphasis.markdown", { fg = colors.fang, italic = true })
  hi("@text.strong.markdown", { fg = colors.fang, bold = true })

  -- JSX in MDX
  hi("@tag.tsx", { fg = colors.eye_shine })
  hi("@tag.attribute.tsx", { fg = colors.eye_glow })
  hi("@tag.delimiter.tsx", { fg = colors.stone })
  hi("@constructor.tsx", { fg = colors.eye_shine, bold = true })
  hi("TelescopeSelection", { bg = colors.cave_stone })
  hi("TelescopeMatching", { fg = colors.blood, bold = true })
  
  -- Tree-sitter highlights
  hi("@variable", { fg = colors.fang })
  hi("@function", { fg = colors.eye_shine })
  hi("@keyword", { fg = colors.blood })
  hi("@string", { fg = colors.eye_glow })
  hi("@comment", { fg = colors.mist, italic = true })
  hi("@type", { fg = colors.eye_shine })
  hi("@constant", { fg = colors.ember })
  hi("@number", { fg = colors.ember })
  hi("@operator", { fg = colors.mist })

  -- TypeScript/JavaScript specific
  hi("@keyword.import", { fg = colors.blood })
  hi("@keyword.export", { fg = colors.blood })
  hi("@keyword.function", { fg = colors.blood })
  hi("@variable.builtin", { fg = colors.lightning })
  hi("@function.builtin", { fg = colors.eye_shine })
  hi("@type.builtin", { fg = colors.eye_shine })
  hi("@constructor", { fg = colors.eye_shine })
  hi("@parameter", { fg = colors.fang })
  hi("@property", { fg = colors.bone })

  -- React/JSX specific
  hi("@tag", { fg = colors.eye_shine })
  hi("@tag.attribute", { fg = colors.eye_glow })
  hi("@tag.delimiter", { fg = colors.stone })
  hi("@tag.builtin", { fg = colors.eye_shine })

  -- Modern Tree-sitter groups (for newer versions)
  hi("@lsp.type.class", { fg = colors.eye_shine })
  hi("@lsp.type.interface", { fg = colors.eye_shine })
  hi("@lsp.type.type", { fg = colors.eye_shine })
  hi("@lsp.type.function", { fg = colors.eye_shine })
  hi("@lsp.type.method", { fg = colors.eye_shine })
  hi("@lsp.type.variable", { fg = colors.fang })
  hi("@lsp.type.property", { fg = colors.bone })
  hi("@lsp.type.parameter", { fg = colors.fang })
  hi("@lsp.type.keyword", { fg = colors.blood })

  -- Nvim-tree
  hi("NvimTreeNormal", { fg = colors.fang, bg = colors.void })
  hi("NvimTreeFolderIcon", { fg = colors.lightning })
  hi("NvimTreeFolderName", { fg = colors.fang })
  hi("NvimTreeIndentMarker", { fg = colors.cave_stone })
  hi("NvimTreeOpenedFolderName", { fg = colors.eye_shine })

  -- Which-key
  hi("WhichKey", { fg = colors.blood })
  hi("WhichKeyGroup", { fg = colors.eye_glow })
  hi("WhichKeyDesc", { fg = colors.fang })
  hi("WhichKeySeperator", { fg = colors.mist })
  hi("WhichKeySeparator", { fg = colors.mist })
  hi("WhichKeyFloat", { bg = colors.cave })
  hi("WhichKeyValue", { fg = colors.eye_glow })
  
  -- Enhanced Tree-sitter groups for better syntax definition
  -- Punctuation and delimiters
  hi("@punctuation.delimiter", { fg = colors.mist })
  hi("@punctuation.bracket", { fg = colors.stone })
  hi("@punctuation.special", { fg = colors.ember })

  -- Enhanced markup groups
  hi("@markup.heading", { fg = colors.fang, bold = true })
  hi("@markup.heading.1", { fg = colors.fang, bold = true })
  hi("@markup.heading.2", { fg = colors.blood, bold = true })
  hi("@markup.heading.3", { fg = colors.eye_shine, bold = true })
  hi("@markup.heading.4", { fg = colors.ember, bold = true })
  hi("@markup.heading.5", { fg = colors.lightning, bold = true })
  hi("@markup.heading.6", { fg = colors.mist, bold = true })
  hi("@markup.list", { fg = colors.blood })
  hi("@markup.list.checked", { fg = colors.eye_shine })
  hi("@markup.list.unchecked", { fg = colors.blood })
  hi("@markup.link", { fg = colors.eye_glow, underline = true })
  hi("@markup.link.label", { fg = colors.eye_shine })
  hi("@markup.link.url", { fg = colors.eye_glow })
  hi("@markup.raw", { fg = colors.ember })
  hi("@markup.raw.block", { fg = colors.ember, bg = colors.shadow })
  hi("@markup.quote", { fg = colors.mist, italic = true })
  hi("@markup.math", { fg = colors.ember })
  hi("@markup.environment", { fg = colors.eye_shine })
  hi("@markup.environment.name", { fg = colors.eye_shine })
  hi("@markup.strikethrough", { fg = colors.mist, strikethrough = true })
  hi("@markup.strong", { fg = colors.fang, bold = true })
  hi("@markup.italic", { fg = colors.fang, italic = true })
  hi("@markup.underline", { fg = colors.fang, underline = true })

  -- Enhanced attribute groups
  hi("@attribute", { fg = colors.cyan })
  hi("@attribute.builtin", { fg = colors.lightning })

  -- Enhanced variable groups
  hi("@variable.member", { fg = colors.bone })
  hi("@variable.parameter.builtin", { fg = colors.lightning })

  -- Enhanced function groups
  hi("@function.method", { fg = colors.eye_shine })
  hi("@function.method.call", { fg = colors.eye_shine })
  hi("@function.macro", { fg = colors.eye_glow })

  -- Enhanced type groups
  hi("@type.qualifier", { fg = colors.blood })
  hi("@type.definition", { fg = colors.eye_shine })

  -- Namespace and module groups
  hi("@module", { fg = colors.lightning })
  hi("@module.builtin", { fg = colors.lightning_bright })
  hi("@namespace", { fg = colors.lightning })
  hi("@namespace.builtin", { fg = colors.lightning_bright })

  -- Enhanced constant groups
  hi("@constant.builtin", { fg = colors.ember_bright })
  hi("@constant.macro", { fg = colors.ember_bright })

  -- Enhanced keyword groups
  hi("@keyword.modifier", { fg = colors.blood })
  hi("@keyword.type", { fg = colors.blood })
  hi("@keyword.coroutine", { fg = colors.lightning })
  hi("@keyword.debug", { fg = colors.wound })
  hi("@keyword.directive", { fg = colors.eye_glow })
  hi("@keyword.directive.define", { fg = colors.eye_glow })
  hi("@keyword.exception", { fg = colors.wound })

  -- Enhanced string groups
  hi("@string.documentation", { fg = colors.eye_glow, italic = true })
  hi("@string.regexp", { fg = colors.ember })
  hi("@string.escape", { fg = colors.ember_bright })
  hi("@string.special", { fg = colors.ember_bright })
  hi("@string.special.symbol", { fg = colors.ember_bright })
  hi("@string.special.url", { fg = colors.eye_glow, underline = true })
  hi("@string.special.path", { fg = colors.eye_glow })

  -- Enhanced comment groups
  hi("@comment.documentation", { fg = colors.mist, italic = true })
  hi("@comment.error", { fg = colors.blood, italic = true })
  hi("@comment.warning", { fg = colors.ember, italic = true })
  hi("@comment.todo", { fg = colors.eye_shine, italic = true, bold = true })
  hi("@comment.note", { fg = colors.eye_glow, italic = true })

  -- Additional LSP semantic tokens
  hi("@lsp.type.namespace", { fg = colors.lightning })
  hi("@lsp.type.enum", { fg = colors.ember_bright })
  hi("@lsp.type.enumMember", { fg = colors.ember })
  hi("@lsp.type.decorator", { fg = colors.cyan })
  hi("@lsp.type.macro", { fg = colors.eye_glow })
  hi("@lsp.type.generic", { fg = colors.eye_shine })
  hi("@lsp.type.typeParameter", { fg = colors.eye_shine })
  hi("@lsp.type.selfKeyword", { fg = colors.lightning })
  hi("@lsp.type.builtinType", { fg = colors.eye_shine })
  hi("@lsp.mod.declaration", { bold = true })
  hi("@lsp.mod.definition", { bold = true })
  hi("@lsp.mod.readonly", { italic = true })
  hi("@lsp.mod.static", { bold = true })
  hi("@lsp.mod.deprecated", { strikethrough = true })
  
  -- Modern UI elements
  hi("FloatBorder", { fg = colors.cave_stone, bg = colors.cave })
  hi("FloatTitle", { fg = colors.fang, bg = colors.cave, bold = true })
  hi("WinSeparator", { fg = colors.cave_stone })
  hi("WinBar", { fg = colors.fang, bg = colors.shadow })
  hi("WinBarNC", { fg = colors.mist, bg = colors.shadow })

  -- Enhanced Telescope groups
  hi("TelescopeTitle", { fg = colors.fang, bold = true })
  hi("TelescopePromptTitle", { fg = colors.blood, bold = true })
  hi("TelescopeResultsTitle", { fg = colors.eye_shine, bold = true })
  hi("TelescopePreviewTitle", { fg = colors.ember, bold = true })
  hi("TelescopePromptBorder", { fg = colors.blood })
  hi("TelescopeResultsBorder", { fg = colors.eye_shine })
  hi("TelescopePreviewBorder", { fg = colors.ember })
  hi("TelescopePromptNormal", { fg = colors.fang, bg = colors.cave })
  hi("TelescopeResultsNormal", { fg = colors.fang, bg = colors.shadow })
  hi("TelescopePreviewNormal", { fg = colors.fang, bg = colors.shadow })
  hi("TelescopeSelectionCaret", { fg = colors.blood })
  hi("TelescopeMultiSelection", { fg = colors.eye_shine })
  
  -- nvim-cmp completion menu
  hi("CmpItemAbbrDeprecated", { fg = colors.mist, strikethrough = true })
  hi("CmpItemAbbrMatch", { fg = colors.eye_shine, bold = true })
  hi("CmpItemAbbrMatchFuzzy", { fg = colors.eye_shine })
  hi("CmpItemKindText", { fg = colors.fang })
  hi("CmpItemKindMethod", { fg = colors.eye_shine })
  hi("CmpItemKindFunction", { fg = colors.eye_shine })
  hi("CmpItemKindConstructor", { fg = colors.eye_shine })
  hi("CmpItemKindField", { fg = colors.bone })
  hi("CmpItemKindVariable", { fg = colors.fang })
  hi("CmpItemKindClass", { fg = colors.eye_shine })
  hi("CmpItemKindInterface", { fg = colors.eye_shine })
  hi("CmpItemKindModule", { fg = colors.lightning })
  hi("CmpItemKindProperty", { fg = colors.bone })
  hi("CmpItemKindEnum", { fg = colors.ember_bright })
  hi("CmpItemKindKeyword", { fg = colors.blood })
  hi("CmpItemKindSnippet", { fg = colors.ember })
  hi("CmpItemKindColor", { fg = colors.ember })
  hi("CmpItemKindFile", { fg = colors.eye_glow })
  hi("CmpItemKindReference", { fg = colors.eye_glow })
  hi("CmpItemKindFolder", { fg = colors.lightning })
  hi("CmpItemKindEnumMember", { fg = colors.ember })
  hi("CmpItemKindConstant", { fg = colors.ember_bright })
  hi("CmpItemKindStruct", { fg = colors.eye_shine })
  hi("CmpItemKindEvent", { fg = colors.ember })
  hi("CmpItemKindOperator", { fg = colors.mist })
  hi("CmpItemKindTypeParameter", { fg = colors.eye_shine })
  
  -- Enhanced NvimTree groups
  hi("NvimTreeRootFolder", { fg = colors.blood, bold = true })
  hi("NvimTreeGitDirty", { fg = colors.ember })
  hi("NvimTreeGitNew", { fg = colors.eye_shine })
  hi("NvimTreeGitDeleted", { fg = colors.blood })
  hi("NvimTreeGitRenamed", { fg = colors.ember_bright })
  hi("NvimTreeGitStaged", { fg = colors.eye_shine })
  hi("NvimTreeSpecialFile", { fg = colors.ember, underline = true })
  hi("NvimTreeImageFile", { fg = colors.ember })
  hi("NvimTreeMarkdownFile", { fg = colors.eye_shine })
  hi("NvimTreeExecFile", { fg = colors.blood, bold = true })
  hi("NvimTreeSymlink", { fg = colors.cyan, italic = true })
  hi("NvimTreeBookmark", { fg = colors.lightning })

  -- Terminal colors for integrated terminal (matching Alacritty)
  vim.g.terminal_color_0 = colors.shadow           -- black
  vim.g.terminal_color_1 = colors.blood            -- red
  vim.g.terminal_color_2 = colors.eye_glow         -- green
  vim.g.terminal_color_3 = colors.ember            -- yellow
  vim.g.terminal_color_4 = colors.lightning        -- blue
  vim.g.terminal_color_5 = colors.void_purple      -- magenta
  vim.g.terminal_color_6 = colors.cyan             -- cyan
  vim.g.terminal_color_7 = colors.fang             -- white
  vim.g.terminal_color_8 = colors.cave_stone       -- bright black
  vim.g.terminal_color_9 = "#ef4444"               -- bright red
  vim.g.terminal_color_10 = colors.eye_shine       -- bright green
  vim.g.terminal_color_11 = colors.ember_bright    -- bright yellow
  vim.g.terminal_color_12 = colors.lightning_bright -- bright blue
  vim.g.terminal_color_13 = colors.lightning       -- bright magenta
  vim.g.terminal_color_14 = colors.cyan_bright     -- bright cyan
  vim.g.terminal_color_15 = "#fafafa"              -- bright white
  
  -- Bufferline plugin support
  hi("BufferLineFill", { bg = colors.shadow })
  hi("BufferLineBackground", { fg = colors.mist, bg = colors.shadow })
  hi("BufferLineBufferSelected", { fg = colors.fang, bg = colors.cave, bold = true })
  hi("BufferLineBufferVisible", { fg = colors.mist, bg = colors.shadow })
  hi("BufferLineSeparator", { fg = colors.cave_stone, bg = colors.shadow })
  hi("BufferLineSeparatorSelected", { fg = colors.cave_stone, bg = colors.cave })
  hi("BufferLineSeparatorVisible", { fg = colors.cave_stone, bg = colors.shadow })
  hi("BufferLineIndicatorSelected", { fg = colors.blood, bg = colors.cave })
  hi("BufferLineModified", { fg = colors.ember, bg = colors.shadow })
  hi("BufferLineModifiedSelected", { fg = colors.ember, bg = colors.cave })
  hi("BufferLineModifiedVisible", { fg = colors.ember, bg = colors.shadow })

  -- Rainbow delimiters (nested brackets)
  hi("RainbowDelimiterRed", { fg = colors.blood })
  hi("RainbowDelimiterYellow", { fg = colors.ember })
  hi("RainbowDelimiterGreen", { fg = colors.eye_shine })
  hi("RainbowDelimiterCyan", { fg = colors.cyan })
  hi("RainbowDelimiterViolet", { fg = colors.lightning })
  hi("RainbowDelimiterOrange", { fg = colors.ember_bright })
  hi("RainbowDelimiterBlue", { fg = colors.lightning_bright })

  -- Flash.nvim
  hi("FlashBackdrop", { fg = colors.stone })
  hi("FlashLabel", { fg = colors.void, bg = colors.eye_shine, bold = true })
  hi("FlashMatch", { fg = colors.fang, bg = colors.cave_stone })
  hi("FlashCurrent", { fg = colors.void, bg = colors.ember })
  hi("FlashPrompt", { fg = colors.fang, bg = colors.cave })

  -- Trouble.nvim
  hi("TroubleNormal", { fg = colors.fang, bg = colors.shadow })
  hi("TroubleNormalNC", { fg = colors.mist, bg = colors.shadow })
  hi("TroubleText", { fg = colors.fang })
  hi("TroubleCount", { fg = colors.void, bg = colors.eye_shine, bold = true })
  hi("TroubleFile", { fg = colors.lightning })
  hi("TroubleFoldIcon", { fg = colors.blood })
  hi("TroubleLocation", { fg = colors.mist })
  hi("TroubleIndent", { fg = colors.cave_stone })
  hi("TroubleCode", { fg = colors.mist, italic = true })
  hi("TroubleSource", { fg = colors.mist, italic = true })

  -- Todo-comments
  hi("TodoBgTODO", { fg = colors.void, bg = colors.lightning, bold = true })
  hi("TodoFgTODO", { fg = colors.lightning })
  hi("TodoBgFIX", { fg = colors.void, bg = colors.blood, bold = true })
  hi("TodoFgFIX", { fg = colors.blood })
  hi("TodoBgHACK", { fg = colors.void, bg = colors.ember, bold = true })
  hi("TodoFgHACK", { fg = colors.ember })
  hi("TodoBgWARN", { fg = colors.void, bg = colors.ember_bright, bold = true })
  hi("TodoFgWARN", { fg = colors.ember_bright })
  hi("TodoBgPERF", { fg = colors.void, bg = colors.lightning_bright, bold = true })
  hi("TodoFgPERF", { fg = colors.lightning_bright })
  hi("TodoBgNOTE", { fg = colors.void, bg = colors.eye_shine, bold = true })
  hi("TodoFgNOTE", { fg = colors.eye_shine })
  hi("TodoBgTEST", { fg = colors.void, bg = colors.cyan, bold = true })
  hi("TodoFgTEST", { fg = colors.cyan })

  -- Indent-blankline scope
  hi("IblIndent", { fg = colors.cave })
  hi("IblScope", { fg = colors.blood })
  hi("IblWhitespace", { fg = colors.cave })

  -- Nvim-notify
  hi("NotifyERRORBorder", { fg = colors.wound })
  hi("NotifyERRORIcon", { fg = colors.blood })
  hi("NotifyERRORTitle", { fg = colors.blood, bold = true })
  hi("NotifyWARNBorder", { fg = colors.ember })
  hi("NotifyWARNIcon", { fg = colors.ember_bright })
  hi("NotifyWARNTitle", { fg = colors.ember_bright, bold = true })
  hi("NotifyINFOBorder", { fg = colors.eye_shine })
  hi("NotifyINFOIcon", { fg = colors.eye_glow })
  hi("NotifyINFOTitle", { fg = colors.eye_glow, bold = true })
  hi("NotifyDEBUGBorder", { fg = colors.mist })
  hi("NotifyDEBUGIcon", { fg = colors.mist })
  hi("NotifyDEBUGTitle", { fg = colors.mist, bold = true })
  hi("NotifyTRACEBorder", { fg = colors.lightning })
  hi("NotifyTRACEIcon", { fg = colors.lightning })
  hi("NotifyTRACETitle", { fg = colors.lightning, bold = true })
  hi("NotifyBackground", { bg = colors.shadow })

  -- Dressing.nvim
  hi("DressingInputBorder", { fg = colors.blood })
  hi("DressingInputNormal", { fg = colors.fang, bg = colors.cave })
  hi("DressingInputPrompt", { fg = colors.eye_shine, bold = true })

  -- Crates.nvim (Rust Cargo.toml)
  hi("CratesNvimLoading", { fg = colors.mist })
  hi("CratesNvimVersion", { fg = colors.eye_shine })
  hi("CratesNvimPreRelease", { fg = colors.ember })
  hi("CratesNvimYanked", { fg = colors.blood })
  hi("CratesNvimNoMatch", { fg = colors.wound })
  hi("CratesNvimUpgrade", { fg = colors.eye_glow })
  hi("CratesNvimError", { fg = colors.blood })

  -- Rustaceanvim
  hi("RustaceanInlayHint", { fg = colors.stone, italic = true })
end

-- Custom lualine theme
M.lualine_theme = {
  normal = {
    a = { fg = colors.void, bg = colors.eye_shine, gui = "bold" },
    b = { fg = colors.fang, bg = colors.cave_stone },
    c = { fg = colors.mist, bg = colors.shadow },
  },
  insert = {
    a = { fg = colors.void, bg = colors.blood, gui = "bold" },
    b = { fg = colors.fang, bg = colors.cave_stone },
    c = { fg = colors.mist, bg = colors.shadow },
  },
  visual = {
    a = { fg = colors.void, bg = colors.lightning, gui = "bold" },
    b = { fg = colors.fang, bg = colors.cave_stone },
    c = { fg = colors.mist, bg = colors.shadow },
  },
  replace = {
    a = { fg = colors.void, bg = colors.ember, gui = "bold" },
    b = { fg = colors.fang, bg = colors.cave_stone },
    c = { fg = colors.mist, bg = colors.shadow },
  },
  command = {
    a = { fg = colors.void, bg = colors.cyan, gui = "bold" },
    b = { fg = colors.fang, bg = colors.cave_stone },
    c = { fg = colors.mist, bg = colors.shadow },
  },
  inactive = {
    a = { fg = colors.mist, bg = colors.shadow },
    b = { fg = colors.mist, bg = colors.shadow },
    c = { fg = colors.stone, bg = colors.shadow },
  },
}

return M