local on_attach = function(client, bufnr)
  require('nv-lspconfig.keybinds')
end

G.completion_enable_snippet = 'snippets.nvim'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local lspconf = require "lspconfig"
local servers = { "clangd" , "pyright", "eslint", "tsserver"}

-- Load language servers
for _, lang in ipairs(servers) do
    lspconf[lang].setup {
        on_attach = on_attach,
        root_dir = vim.loop.cwd,
        capabilities = capabilities
    }
end

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
