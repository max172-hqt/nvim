local editor = {}
local function conf(config_name)
  return require(string.format("modules.editor.%s", config_name))
end

editor['Raimondi/delimitMate'] = {
  event = 'InsertEnter',
  config = conf("delimimate"),
}

editor['tpope/vim-surround'] = {}

return editor

