-- local nvim_lsp = require('lspconfig')
return function()
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    -- lspsaga
    -- buf_set_keymap('n', '<Leader>f', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', opts)
    -- buf_set_keymap('n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
    -- buf_set_keymap('n', ',s', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
    -- buf_set_keymap('n', ',rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
    -- buf_set_keymap('n', '<Leader>ca', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
    -- buf_set_keymap('v', '<Leader>ca', ':<C-u>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)
    -- buf_set_keymap('n', '[d', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_prev()<CR>', opts)
    -- buf_set_keymap('n', ']d', '<cmd>lua require("lspsaga.diagnostic").lsp_jump_diagnostic_next()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
      buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec([[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]], false)
    end
  end

  -- Diagnostics signs and highlights
--   Error:   ✘
--   Warning:  ⚠ 
--   Hint:  
--   Information:   ⁱ
local signs = { Error = '✘', Warning = '', Hint = '', Information = 'ⁱ'}
for type, icon in pairs(signs) do
	local hl = 'LspDiagnosticsSign' .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

  -- Configure lua language server for neovim development
  local lua_settings = {
    Lua = {
      runtime = {
        -- LuaJIT in the case of Neovim
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    }
  }

    -- Combine base config for each server and merge user-defined settings.
  local function make_config(server_name)
    -- Setup base config for each server.
    local c = {}
    c.on_attach = on_attach
    c.capabilities = vim.lsp.protocol.make_client_capabilities()
    c.capabilities = require('cmp_nvim_lsp').update_capabilities(c.capabilities)
    -- c.capabilities.textDocument.completion.completionItem.snippetSupport = true
    -- c.capabilities.textDocument.completion.completionItem.resolveSupport = {
    -- 	properties = {
    -- 		'documentation',
    -- 		'detail',
    -- 		'additionalTextEdits',
    -- 	}
    -- }

    -- Merge user-defined lsp settings.
    -- These can be overridden locally by lua/lsp-local/<server_name>.lua
    local exists, module = pcall(require, 'modules.local.completion.'..server_name)
    if not exists then
      exists, module = pcall(require, 'modules.completion.'..server_name)
    end
    if exists then
      local user_config = module.config(c)
      for k, v in pairs(user_config) do c[k] = v end
    end

    return c
  end

  -- lsp-install
  local function setup_servers()
    require'lspinstall'.setup()

    local servers = require'lspinstall'.installed_servers()

    for _, server in pairs(servers) do
      local config = make_config(server)
      require'lspconfig'[server].setup(config)
    end
  end

-- -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
  setup_servers()

  require'lspinstall'.post_install_hook = function ()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
  end
end

