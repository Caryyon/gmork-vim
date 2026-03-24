local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
  return
end

indent_blankline.setup {
  indent = {
    char = "▏",
    highlight = "IblIndent",
  },
  scope = {
    enabled = true,
    char = "▏",
    show_start = true,
    show_end = false,
    highlight = "IblScope",
    include = {
      node_type = {
        ["*"] = { "function", "method", "class", "if_statement", "for_statement", "while_statement", "try_statement", "match_expression", "object", "table" },
      },
    },
  },
  exclude = {
    filetypes = {
      "NvimTree",
      "help",
      "alpha",
      "dashboard",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
      "trouble",
    },
  },
}
