# nvim-lsp-setup

To batch configurations that are distributed in |lsp.handlers| and |vim.diagnostic.config()|.

# Example

The types are defined in types.lua, it is recommended that they be loaded into LSP.

```lua
require("nvim_lsp_setup").setup({
  hover = {
    border = "single",
    title = "Hover",
  },
  diagnostic = {
    float = {
      border = "single",
      title = "Diagnostics",
      header = {},
      format = function(diag)
        vim.pretty_print(diag)
        if diag.code then
          return ("[%s](%s): %s"):format(diag.source, diag.code, diag.message)
        else
          return ("[%s]: %s"):format(diag.source, diag.message)
        end
      end,
    },
  },
  signature_help = {
    border = "single"
  },
})

-- Highlights
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1d3b53" })
vim.api.nvim_set_hl(0, "Title", { bg = "#1d3b53" })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = "white", bg = "#1d3b53" })
```
