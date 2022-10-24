local status, null_ls = pcall(require, "null-ls")
if (not status) then
  print "null-ls not installed"
  return
end

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    })
  },
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.format()<CR>")
      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format()")
    end

    if client.server_capabilities.documentRangeFormattingProvider then
      vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.range_formatting({})<CR>")
    end
  end,
})

-- null_ls.setup {
--   sources = {
--     null_ls.builtins.diagnostics.eslint_d.with({
--       diagnostics_format = '[eslint] #{m}\n(#{c})'
--     }),
--     null_ls.builtins.diagnostics.fish
--   },
--   on_attach = function(client, bufnr)
--     if client.server_capabilities.documentFormattingProvider then
--       vim.api.nvim_clear_autocmds { buffer = 0, group = augroup_format }
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = augroup_format,
--         buffer = 0,
--         callback = function() vim.lsp.buf.formatting_seq_sync() end
--       })
--     end
--   end,
-- }
