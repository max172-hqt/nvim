local completion = {}
local function conf(config_name)
  return require(string.format("modules.completion.%s", config_name))
end

completion['tpope/vim-commentary'] = {}

completion['hrsh7th/vim-vsnip'] = {
  event = 'InsertCharPre',
  config = conf("vim_vsnip"),
}

completion['rafamadriz/friendly-snippets'] = {}

completion['neoclide/coc.nvim'] = {
  branch = 'release',
  run = 'yarn install --frozen-lockfile'
}

completion['nvim-telescope/telescope.nvim'] = {
  cmd = 'Telescope',
  config = conf("telescope"),
  requires = {
    {'nvim-lua/popup.nvim', opt = true},
    {'nvim-lua/plenary.nvim',opt = true},
    {'nvim-telescope/telescope-fzy-native.nvim',opt = true},
  }
}

-- completion['glepnir/smartinput.nvim'] = {
--   ft = 'go',
--   config = conf.smart_input
-- }

-- completion['mattn/vim-sonictemplate'] = {
--   cmd = 'Template',
--   ft = {'go','typescript','lua','javascript','vim','rust','markdown'},
--   config = conf.vim_sonictemplate,
-- }

completion['mattn/emmet-vim'] = {
  event = 'InsertEnter',
  ft = {'html','css','javascript','javascriptreact','vue','typescript','typescriptreact'},
  config = conf("emmet"),
}

return completion
