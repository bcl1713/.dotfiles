local on_attach = function(clinet, bufnr)
  require 'jdtls.setup'.add_commands()
  require 'nv-lspconfig.keybinds'

  require'lspkind'.init()
  require'lspsaga'.init_lsp_saga()

  local function set_keymap(...) vim.api.nvim_set_keymap(...) end

  local opts = { noremap=true, silent=true }

  -- Java specific
  set_keymap("n", "<leader>di", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
  set_keymap("n", "<leader>dt", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
  set_keymap("n", "<leader>dn", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
  set_keymap("v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
  set_keymap("n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
  set_keymap("v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

  vim.api.nvim_exec([[
    augroup lsp_document_highlight
      autocmd!
      autocmd BufWritePost *.java FormatWrite
    augroup END
  ]], true)

end

local root_markers = {'.git', 'mvnw', 'gradlew', 'project.root', 'pom.xml'}
local root_dir = require('jdtls.setup').find_root(root_markers)
local home = os.getenv('HOME')

local capabilities = {
  workspace = {
    configuration = true
  },
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true
      }
    }
  }
}

local workspace_folder = home .. "/.workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = {
  flags = {
    allow_incremental_sync = true,
  };
  capabilities = capabilities,
  on_attach = on_attach,
}

config.settings = {
  java = {
    signatureHelp = { enabled = true };
  };
}
config.cmd = {'/home/brian/.cache/nvim/nvim_lsp/jdtls/launcher', workspace_folder}
config.on_attach = on_attach

require('jdtls').start_or_attach(config)
