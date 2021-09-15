local editor = {}
local function conf(config_name)
  return require(string.format("modules.editor.%s", config_name))
end

editor['tpope/vim-surround'] = {}
editor['christoomey/vim-tmux-navigator'] = {}

editor['Raimondi/delimitMate'] = {
  event = 'InsertEnter',
  config = conf("delimimate"),
}

editor['norcalli/nvim-colorizer.lua'] = {
  ft = { 'html','css','sass','vim','typescript','typescriptreact'},
  config = conf("nvim_colorizer")
}

editor['hrsh7th/vim-eft'] = {
  opt = true,
  config = function()
    vim.g.eft_ignorecase = true
  end
}

editor["ggandor/lightspeed.nvim"]= {
  event = "BufReadPost",
  config = conf("lightspeed")
}

return editor

