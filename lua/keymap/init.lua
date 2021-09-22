local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args
require('keymap.config')

local plug_map = {
    ["i|<C-l>"]      = map_cmd('v:lua.expand_snip()'):with_silent():with_expr(),
    ["s|<C-l>"]      = map_cmd('v:lua.expand_snip()'):with_silent():with_expr(),
    ["n|<Tab>"]          = map_cr("BufferNext"):with_noremap():with_silent(),
    ["n|<S-Tab>"]        = map_cr("BufferPrevious"):with_noremap():with_silent(),
    ["n|<leader>bk"]     = map_cr("BufferMoveNext"):with_noremap():with_silent(),
    ["n|<leader>bj"]     = map_cr("BufferMovePrev"):with_noremap():with_silent(),
    ["n|<leader>1"]      = map_cr("BufferGoto 1"):with_noremap():with_silent(),
    ["n|<leader>2"]      = map_cr("BufferGoto 2"):with_noremap():with_silent(),
    ["n|<leader>3"]      = map_cr("BufferGoto 3"):with_noremap():with_silent(),
    ["n|<leader>4"]      = map_cr("BufferGoto 4"):with_noremap():with_silent(),
    ["n|<leader>5"]      = map_cr("BufferGoto 5"):with_noremap():with_silent(),
    ["n|<leader>6"]      = map_cr("BufferGoto 6"):with_noremap():with_silent(),
    ["n|<leader>7"]      = map_cr("BufferGoto 7"):with_noremap():with_silent(),
    ["n|<leader>8"]      = map_cr("BufferGoto 8"):with_noremap():with_silent(),
    ["n|<leader>9"]      = map_cr("BufferGoto 9"):with_noremap():with_silent(),
    ["n|<leader>0"]      = map_cr("BufferLast"):with_noremap():with_silent(),
    -- ["n|<C-p>"]          = map_cr("BufferPick"):with_noremap():with_silent(),
    ["n|<S-q>"]          = map_cr("BufferClose"):with_noremap():with_silent(),
    ["n|<leader>bd"]     = map_cr("BufferClose"):with_noremap():with_silent(),
    ["n|<leader>bo"]     = map_cr("BufferCloseAllButCurrent"):with_noremap():with_silent(),
    ["n|<leader>bh"]     = map_cr("BufferCloseBuffersLeft"):with_noremap():with_silent(),
    ["n|<leader>bl"]     = map_cr("BufferCloseBuffersRight"):with_noremap():with_silent(),
    -- Packer
    ["n|<leader>pu"]     = map_cr("PackerUpdate"):with_silent():with_noremap():with_nowait();
    ["n|<leader>pi"]     = map_cr("PackerInstall"):with_silent():with_noremap():with_nowait();
    ["n|<leader>pc"]     = map_cr("PackerCompile"):with_silent():with_noremap():with_nowait();
    -- Lsp mapp work when insertenter and lsp start
    ["n|<leader>li"]     = map_cr("LspInfo"):with_noremap():with_silent():with_nowait(),
    ["n|<leader>ll"]     = map_cr("LspLog"):with_noremap():with_silent():with_nowait(),
    ["n|<leader>lr"]     = map_cr("LspRestart"):with_noremap():with_silent():with_nowait(),
    ["n|<C-f>"]          = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>"):with_silent():with_noremap():with_nowait(),
    ["n|<C-b>"]          = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>"):with_silent():with_noremap():with_nowait(),
    ["n|[d"]             = map_cr('Lspsaga diagnostic_jump_next'):with_noremap():with_silent(),
    ["n|]d"]             = map_cr('Lspsaga diagnostic_jump_prev'):with_noremap():with_silent(),
    ["n|K"]              = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
    ["n|ca"]             = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
    ["v|ga"]             = map_cu("Lspsaga range_code_action"):with_noremap():with_silent(),
    ["n|gD"]             = map_cr('Lspsaga preview_definition'):with_noremap():with_silent(),
    -- ["n|gD"]             = map_cmd("<cmd>lua vim.lsp.buf.implementation()<CR>"):with_noremap():with_silent(),
    ["n|gs"]             = map_cr('Lspsaga signature_help'):with_noremap():with_silent(),
    ["n|<leader>rn"]     = map_cr('Lspsaga rename'):with_noremap():with_silent(),
    ["n|gh"]             = map_cr('Lspsaga lsp_finder'):with_noremap():with_silent(),
    ["n|gt"]             = map_cmd("<cmd>lua vim.lsp.buf.type_definition()<CR>"):with_noremap():with_silent(),
    ["n|<Leader>cw"]     = map_cmd("<cmd>lua vim.lsp.buf.workspace_symbol()<CR>"):with_noremap():with_silent(),
    ["n|<Leader>e"]     = map_cr('Lspsaga show_line_diagnostics'):with_noremap():with_silent(),

    -- Plugin nvim-tree
    ["n|,1"]             = map_cr('NvimTreeToggle'):with_noremap():with_silent(),
    -- Plugin Telescope
    ["n|<Leader>,"]      = map_cu('Telescope buffers'):with_noremap():with_silent(),
    -- ["n|<Leader>fa"]     = map_cu('DashboardFindWord'):with_noremap():with_silent(),
    ["n|<Leader><Leader>"]     = map_cu('Telescope find_files'):with_noremap():with_silent(),
    -- ["n|<Leader>ff"]     = map_cu('DashboardFindFile'):with_noremap():with_silent(),
    ["n|<Leader>fg"]     = map_cu('Telescope git_files'):with_noremap():with_silent(),
    ["n|<Leader>ff"]     = map_cu('Telescope live_grep'):with_noremap():with_silent(),
    -- ["n|<Leader>fh"]     = map_cu('DashboardFindHistory'):with_noremap():with_silent(),
    -- ["n|<Leader>fl"]     = map_cu('Telescope loclist'):with_noremap():with_silent(),
    ["n|<Leader>gc"]     = map_cu('Telescope git_commits'):with_noremap():with_silent(),
    -- ["n|<Leader>ft"]     = map_cu('Telescope help_tags'):with_noremap():with_silent(),
    -- ["n|<Leader>fd"]     = map_cu('Telescope dotfiles path='..os.getenv("HOME")..'/.dotfiles'):with_noremap():with_silent(),
    -- ["n|<Leader>fs"]     = map_cu('Telescope gosource'):with_noremap():with_silent(),
    -- Plugin QuickRun
    -- ["n|<Leader>r"]     = map_cr("<cmd> lua require'internal.quickrun'.run_command()"):with_noremap():with_silent(),
    -- Plugin Vista
    -- ["n|<Leader>v"]      = map_cu('Vista'):with_noremap():with_silent(),
    -- Plugin hrsh7th/vim-eft
    ["n|;"]              = map_cmd("v:lua.enhance_ft_move(';')"):with_expr(),
    ["x|;"]              = map_cmd("v:lua.enhance_ft_move(';')"):with_expr(),
    ["n|f"]              = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
    ["x|f"]              = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
    ["o|f"]              = map_cmd("v:lua.enhance_ft_move('f')"):with_expr(),
    ["n|F"]              = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
    ["x|F"]              = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
    ["o|F"]              = map_cmd("v:lua.enhance_ft_move('F')"):with_expr(),
    -- Plugin vim_fugitive
    ["n|<Leader>gs"]     = map_cr('G'):with_noremap():with_silent(),

    ["n|<Leader>wc"]     = map_cr('clo'):with_noremap():with_silent(),
    ["n|<Leader>xx"]     = map_cmd("<cmd>Trouble<CR>"):with_silent():with_noremap(),
    ["n|<Leader>xq"]     = map_cmd("<cmd>Trouble quickfix<CR>"):with_silent():with_noremap(),
    ["n|gR"]             = map_cmd("<cmd>Trouble lsp_references<CR>"):with_silent():with_noremap(),
};

bind.nvim_load_mapping(plug_map)
