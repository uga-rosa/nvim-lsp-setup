local M = {}

--- To batch configurations that are distributed in |lsp.handlers| and |vim.diagnostic.config()|.
---@param opts nvimLspSetupOption
function M.setup(opts)
  vim.validate({ opts = { opts, "t" } })
  opts.callback = opts.callback or {}

  if opts.hover then
    local callback = opts.callback.hover
    local handler = vim.lsp.with(vim.lsp.handlers.hover, opts.hover)
    vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
      if callback then
        callback(result)
      end
      handler(err, result, ctx, config)
    end
  end

  if opts.diagnostic then
    vim.diagnostic.config(opts.diagnostic)
  end

  if opts.signature_help then
    local callback = opts.callback.signature_help
    local handler = vim.lsp.with(vim.lsp.handlers.signature_help, opts.signature_help)
    vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
      if callback then
        callback(result)
      end
      handler(err, result, ctx, config)
    end
  end
end

return M
