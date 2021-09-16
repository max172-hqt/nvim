local function check_back_space()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end




--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
-- _G.tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-n>"
--   elseif vim.fn.call("vsnip#available", {1}) == 1 then
--     return t "<Plug>(vsnip-expand-or-jump)"
--   elseif check_back_space() then
--     return t "<Tab>"
--   else
--     return vim.fn['compe#complete']()
--   end
-- end

-- _G.s_tab_complete = function()
--   if vim.fn.pumvisible() == 1 then
--     return t "<C-p>"
--   elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
--     return t "<Plug>(vsnip-jump-prev)"
--   else
--     return t "<S-Tab>"
--   end
-- end

_G.expand_snip = function()
  -- local cmp = require('cmp')

  -- if vim.fn.call("vsnip#available", {1}) == 1 then
  return t "<Plug>(vsnip-expand-or-jump)"
  -- else
  --   return cmp.mapping.confirm({
  --     behavior = cmp.ConfirmBehavior.Replace,
  --     select = true,
  --   })
  -- end
end

-- _G.on_enter = function()
--   if vim.fn.pumvisible() == 1 then
--     return vim.fn['coc#_select_confirm']()
--   else
--     return t "<C-g>u<CR><c-r>=coc#on_enter()<CR>"
--   end
-- end

_G.enhance_jk_move = function(key)
  if packer_plugins['accelerated-jk'] and not packer_plugins['accelerated-jk'].loaded then
    vim.cmd [[packadd accelerated-jk]]
  end
  local map = key == 'j' and '<Plug>(accelerated_jk_gj)' or '<Plug>(accelerated_jk_gk)'
  return t(map)
end

_G.enhance_ft_move = function(key)
  if not packer_plugins['vim-eft'].loaded then
    vim.cmd [[packadd vim-eft]]
  end
  local map = {
    f = '<Plug>(eft-f)',
    F = '<Plug>(eft-F)',
    [';'] = '<Plug>(eft-repeat)'
  }
  return t(map[key])
end

_G.enhance_nice_block = function (key)
  if not packer_plugins['vim-niceblock'].loaded then
    vim.cmd [[packadd vim-niceblock]]
  end
  local map = {
    I = '<Plug>(niceblock-I)',
    ['gI'] = '<Plug>(niceblock-gI)',
    A = '<Plug>(niceblock-A)'
  }
  return t(map[key])
end


_G.cmp_source_list = function(arr)
	local config = {
		buffer = {
			name = 'buffer',
			opts = {
				-- Use all visible buffers
				get_bufnrs = function()
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						bufs[vim.api.nvim_win_get_buf(win)] = true
					end
					return vim.tbl_keys(bufs)
				end,
			},
		},
		nvim_lsp = { name = 'nvim_lsp' },
		nvim_lua = { name = 'nvim_lua' },
		path  = { name = 'path' },
		emoji = { name = 'emoji' },
		vsnip = { name = 'vsnip' },
		tmux  = { name = 'tmux', opts = { all_panes = true }},
		latex = { name = 'latex_symbols' },
	}
	local sources = {}
	for _, name in ipairs(arr) do
		sources[#sources + 1] = config[name]
	end
	return sources
end

_G.cmp_setup_markdown = function()
	require('cmp').setup.buffer{ sources = cmp_source_list(
		{ 'emoji', 'nvim_lsp', 'buffer', 'path', 'vsnip', 'tmux' })}
end

_G.cmp_setup_lua = function()
	require('cmp').setup.buffer{ sources = cmp_source_list(
		{ 'nvim_lua', 'nvim_lsp', 'buffer', 'path', 'vsnip', 'tmux' })}
end

_G.cmp_setup_org = function()
	require('cmp').setup.buffer{ sources = cmp_source_list(
		{ 'orgmode', 'emoji', 'nvim_lsp', 'buffer', 'path', 'vsnip', 'tmux' })}
end

vim.api.nvim_exec([[
	augroup user_cmp
		autocmd!
		autocmd FileType markdown,text call v:lua.cmp_setup_markdown()
		autocmd FileType lua call v:lua.cmp_setup_lua()
		autocmd FileType org call v:lua.cmp_setup_org()
	augroup END
]], false)

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.cmd('command! -nargs=0 Prettier :CocCommand prettier.formatFile')
