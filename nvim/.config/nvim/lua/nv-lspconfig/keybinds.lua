local function map(...) vim.api.nvim_set_keymap(...) end
local function set_option(...) vim.api.nvim_set_option(...) end

set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

-- Mappings.
local opts = { noremap = true, silent = true }
map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "K", "<Cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "<C-k>", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", opts)
map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
map("n", "<leader>rn", "<cmd>lua require('lspsaga.rename').rename()<CR>", opts)
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
map("n", "<leader>cd", "<cmd>lua require('lspsaga.diagnostic').show_line_diagnostics()<CR>", opts)
map("n", "[d", "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev()<CR>", opts)
map("n", "]d", "<cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>", opts)
map("n", "<leader>xx", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
map("n", "<leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>", opts)
map("v", "<leader>ca", "<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", opts)

map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
map("n", "<leader>f", "<cmd>lua vim.lsp.buff.range_formatting()<CR>", opts)
