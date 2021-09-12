local tools = {}
local function conf(config_name)
  return require(string.format("modules.tools.%s", config_name))
end

tools['tpope/vim-fugitive'] = {}

return tools
