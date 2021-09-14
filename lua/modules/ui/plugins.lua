local ui = {}
local function conf(config_name)
  return require(string.format("modules.ui.%s", config_name))
end

ui['navarasu/onedark.nvim'] = {
  config = [[vim.cmd('colorscheme onedark')]]
}

-- ui['glepnir/dashboard-nvim'] = {
--   config = conf.dashboard
-- }

ui['glepnir/galaxyline.nvim'] = {
  branch = 'main',
  config = conf("galaxyline"),
  requires = 'kyazdani42/nvim-web-devicons'
}

-- ui['lukas-reineke/indent-blankline.nvim'] = {
--   event = 'BufRead',
--   branch = 'lua',
--   config = conf.indent_blakline
-- }


ui['romgrk/barbar.nvim'] = {
  requires = {'kyazdani42/nvim-web-devicons'},
  config = conf("barbar"),
}

ui['kyazdani42/nvim-tree.lua'] = {
  cmd = {'NvimTreeToggle','NvimTreeOpen'},
  config = conf("nvim-tree"),
  requires = 'kyazdani42/nvim-web-devicons'
}

ui['lewis6991/gitsigns.nvim'] = {
  event = {'BufRead','BufNewFile'},
  config = conf("gitsigns"),
  requires = {'nvim-lua/plenary.nvim',opt=true}
}

-- ui['ThePrimeagen/harpoon'] = {
--   opt = true,
--   event = { 'VimEnter' },
--   setup = conf('harpoon').setup,
--   config = conf('harpoon').config,
--   requires = {'nvim-lua/plenary.nvim',opt=true}
-- }

return ui
