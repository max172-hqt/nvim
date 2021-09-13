local editor = {}
local function conf(config_name)
  return require(string.format("modules.editor.%s", config_name))
end

editor['tpope/vim-surround'] = {}
editor['christoomey/vim-tmux-navigator'] = {}

return editor

