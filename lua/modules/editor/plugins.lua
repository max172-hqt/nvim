local editor = {}
local function conf(config_name)
  return require(string.format("modules.editor.%s", config_name))
end

-- editor['windwp/nvim-autopairs'] = {
--   config = conf("nvim-autopairs"),
--   after = 'nvim-cmp'
-- }

-- editor['hrsh7th/nvim-cmp'] = {
--   config = conf('nvim-cmp'),
--   module = 'cmp',
--   event = 'InsertEnter',
--   requires = {
--     'hrsh7th/cmp-buffer',
--     'hrsh7th/cmp-emoji',
--     'hrsh7th/cmp-nvim-lsp',
--     'hrsh7th/cmp-path',
--     'hrsh7th/cmp-vsnip',
--     { 'hrsh7th/vim-vsnip', requires = { 'rafamadriz/friendly-snippets' } },
--   },
-- }

editor['tpope/vim-surround'] = {}
editor['christoomey/vim-tmux-navigator'] = {}

return editor

