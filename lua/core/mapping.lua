local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_vs

-- default map
local def_map = {
    ["n|<C-h>"]      = map_cmd('<C-w>h'):with_noremap(),
    ["n|<C-l>"]      = map_cmd('<C-w>l'):with_noremap(),
    ["n|<C-j>"]      = map_cmd('<C-w>j'):with_noremap(),
    ["n|<C-k>"]      = map_cmd('<C-w>k'):with_noremap(),
    ["n|,<Space>"]   = map_cmd(':noh<CR><CR>'):with_noremap(),
  -- Insert
    -- ["i|<C-w>"]      = map_cmd('<C-[>diwa'):with_noremap(),
  -- command line
    -- ["c|<C-b>"]      = map_cmd('<Left>'):with_noremap(),
  -- Visual
}

bind.nvim_load_mapping(def_map)