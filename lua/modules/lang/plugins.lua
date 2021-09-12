local lang = {}
local function conf(config_name)
  return require(string.format("modules.lang.%s", config_name))
end

lang['nvim-treesitter/nvim-treesitter'] = {
  event = 'BufRead',
  after = 'telescope.nvim',
  config = conf("treesitter"),
}

lang['nvim-treesitter/nvim-treesitter-textobjects'] = {
  after = 'nvim-treesitter'
}

return lang

