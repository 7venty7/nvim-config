local lsp_zero = require('lsp-zero')
lsp_zero.preset("recommended")


lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = {
		'tsserver',
		'eslint',
		'pylsp',
		'jsonls',
		'html',
		'tailwindcss',
        'clang-format',
        'clangd',
	},

handlers = {
	lsp_zero.default_setup,
},
})

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	sources = {
		{name = 'nvim_lsp'},
		{name = 'luasnip'},
		{name = 'buffer'},
	},
	mapping = {
		['<C-y>'] = cmp.mapping.confirm({select = false}),
		['<C-e>'] = cmp.mapping.abort(),
		['<C-p>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
		['<C-n>'] = cmp.mapping.select_next_item({behavior = 'select'}),
		['<Tab>'] = cmp_action.tab_complete(),
		['<S-Tab>'] = cmp_action.select_prev_or_fallback(),
		['<C-Space>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item({behavior = 'insert'})
			else
				cmp.complete()
			end
		end),
		['<C-n>'] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_next_item({behavior = 'insert'})
			else
				cmp.complete()
			end
		end),
	},
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})
lsp_zero.setup()
