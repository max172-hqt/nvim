local completion = {}
local function conf(config_name)
  return require(string.format("modules.completion.%s", config_name))
end

completion['tpope/vim-commentary'] = {}

completion['kabouzeid/nvim-lspinstall'] = {}

completion['neovim/nvim-lspconfig'] = {
  event = 'BufReadPre',
  config = conf("nvim_lsp"),
}

completion['glepnir/lspsaga.nvim'] = {
  cmd = 'Lspsaga',
}

completion['onsails/lspkind-nvim'] = {
  config = conf("lspkind")
}

completion["hrsh7th/nvim-cmp"] = {
  config = conf("nvim-cmp"),
  requires = {
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-nvim-lsp",
  }
}

completion['hrsh7th/vim-vsnip'] = {
  event = 'InsertCharPre',
  config = conf("vim_vsnip"),
}

completion['rafamadriz/friendly-snippets'] = {}

completion['nvim-telescope/telescope.nvim'] = {
  cmd = 'Telescope',
  config = conf("telescope"),
  requires = {
    {'nvim-lua/popup.nvim', opt = true},
    {'nvim-lua/plenary.nvim',opt = true},
    {'nvim-telescope/telescope-fzy-native.nvim',opt = true},
  }
}


completion['mattn/emmet-vim'] = {
  event = 'InsertEnter',
  ft = {'html','css','javascript','javascriptreact','vue','typescript','typescriptreact'},
  config = conf("emmet"),
}

return completion
