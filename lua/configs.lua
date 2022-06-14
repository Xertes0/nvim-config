local configs = {}

function configs.config()
	local map_opts = { noremap = true, silent = true }

	-- Keymaps
	---- LSP
	vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', map_opts)
	vim.api.nvim_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
	vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', map_opts)
	vim.api.nvim_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.format { async=true }<CR>', map_opts)

	---- Telescope
	vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>', map_opts)
	vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<CR>', map_opts)

	-- Hover window with rounded border
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
	})
end

function configs.treesitter()
	require('nvim-treesitter').setup {
		ensure_installed = { 'all' },
		sync_install = false, -- install async
	}

	require('nvim-treesitter.configs').setup {
		highlight = {
			enable = true,
		},

		indent = {
			enable = true,
		},

		-- Plugin
		rainbow = {
			enable = true,
			extended_mode = true,
			max_file_lines = nil,
		},

		-- Plugin
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",
					["ak"] = "@comment.outer",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
					["aa"] = "@call.outer",
					["ia"] = "@call.inner",
					["ao"] = "@conditional.outer",
					["io"] = "@conditional.inner",
					["ar"] = "@frame.outer",
					["ir"] = "@frame.inner",
					["ap"] = "@parameter.outer",
					["ip"] = "@parameter.inner",
					["is"] = "@scopename.inner",
					["as"] = "@statement.outer",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
					["]p"] = "@parameter.outer",
					["]b"] = "@block.outer",
					["]s"] = "@statement.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
					["]P"] = "@parameter.outer",
					["]B"] = "@block.outer",
					["]S"] = "@statement.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
					["[p"] = "@parameter.outer",
					["[b"] = "@block.outer",
					["[s"] = "@statement.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
					["[P"] = "@parameter.outer",
					["[B"] = "@block.outer",
					["[S"] = "@statement.outer",
				},
			},
			lsp_interop = {
				enable = true,
				border = 'none',
				peek_definition_code = {
					["<leader>df"] = "@function.outer",
					["<leader>dF"] = "@class.outer",
				},
			},
		},
	}
end

function configs.lspconfig()
	local lsp_installer = require('nvim-lsp-installer')
	lsp_installer.setup {
		automatic_installation = true,
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗"
			}
		}
	}

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

	local settings = nil

	local servers = lsp_installer.get_installed_servers()
	for _, server in ipairs(servers) do
		if server.name == 'sumneko_lua' then
			settings = {
				Lua = {
					diagnostics = {
						enable = true,
						globals = {
							"vim", "use"
						}
					}
				}
			}
		end

		require('lspconfig')[server.name].setup {
			--on_attach = on_attach,
			capabilities = capabilities,
			settings = settings
		}
	end
end

function configs.cmp()
	local luasnip = require 'luasnip'
	local cmp = require 'cmp'

	cmp.setup {
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered()
		},
		mapping = cmp.mapping.preset.insert({
			['<C-d>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<CR>'] = cmp.mapping.confirm {
				behavior = cmp.ConfirmBehavior.Replace,
				select = true,
			},
			['<Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { 'i', 's' }),
			['<S-Tab>'] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { 'i', 's' }),
		}),
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			{ name = 'buffer' },
			--{ name = 'nuspell' },
		},
	}

	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
		sources = cmp.config.sources({
			{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
		}, {
			{ name = 'buffer' },
		})
	})

	-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline('/', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = {
			{ name = 'buffer' }
		}
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		})
	})
end

return configs
