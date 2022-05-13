local on_attach = function(client, bufnr)
  require('nv-lspconfig.keybinds')
  
  if client.resolved_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end

G.completion_enable_snippet = 'snippets.nvim'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconf = require "lspconfig"
local servers = { "clangd" , "pyright", "eslint"}

-- Load language servers
for _, lang in ipairs(servers) do
    lspconf[lang].setup {
        on_attach = on_attach,
        root_dir = vim.loop.cwd,
        capabilities = capabilities
    }
end

lspconf.tsserver.setup({
    on_attach = function(client, bufnr)
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false

        local ts_utils = require("nvim-lsp-ts-utils")
        ts_utils.setup({})
        ts_utils.setup_client(client)

        on_attach(client, bufnr)
    end,
})

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
        null_ls.builtins.formatting.prettier
    },
    on_attach = on_attach
})

-- Lua LSP Specific
-- USER = "/home/" .. vim.fn.expand("$USER")
-- 
-- local sumneko_root_path = USER .. "/.config/lua-language-server"
-- local sumneko_binary = USER .. "/.config/lua-language-server/bin/Linux/lua-language-server"
-- 
-- lspconf.sumneko_lua.setup {
--   cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
--   root_dir = function()
--     return vim.loop.cwd()
--   end,
--   settings = {
--     Lua = {
--       runtime = {
--         version = "LuaJIT",
--         path = vim.split(package.path, ";")
--       },
--       diagnostics = {
--         globals = {"vim"}
--       },
--       workspace = {
--         library = {
--           [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--           [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
--         }
--       },
--       telemetry = {
--         enable = false
--       }
--     }
--   }
-- }

vim.fn.sign_define("LspDiagnosticsSignError", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = ""})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = ""})
