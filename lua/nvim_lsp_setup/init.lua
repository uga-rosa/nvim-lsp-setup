local M = {}

--- To batch configurations that are distributed in |lsp.handlers| and |vim.diagnostic.config()|.
---@param opts nvimLspSetupOption
function M.setup(opts)
  vim.validate({ opts = { opts, "t" } })

  if opts.hover then
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, opts.hover)
  end

  if opts.diagnostic then
    vim.diagnostic.config(opts.diagnostic)
  end

  if opts.signature_help then
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, opts.signature_help)
  end
end

return M
