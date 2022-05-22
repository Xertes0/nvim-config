local configs = require('configs')
return require('packer').startup(function()
	-- Packer
	use 'wbthomason/packer.nvim'

	-- Colorschemes
	use 'luisiacc/gruvbox-baby'
	use 'shaunsingh/nord.nvim'
	use 'edeneast/nightfox.nvim'

	-- Treesitter
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = configs.treesitter,
	}

	-- Context after brackets
	use 'haringsrob/nvim_context_vt'

	---- Rainbow brackets
	use 'p00f/nvim-ts-rainbow'

	---- Context on top
	use 'nvim-treesitter/nvim-treesitter-context'

	use 'nvim-treesitter/nvim-treesitter-textobjects'

	---- Spelling
	------ :set spell
	use {
		'lewis6991/spellsitter.nvim',
		config = function()
			require('spellsitter').setup()
		end
	}

	-- LSP, LSP tools
	use {
		'williamboman/nvim-lsp-installer', {
			'neovim/nvim-lspconfig',
			config = configs.lspconfig,
		}
	}

	---- Rust tools
	use {
		'simrat39/rust-tools.nvim',
		config = function() require('rust-tools').setup {} end
	}

	---- Prettier code actions
	use {
		'weilbith/nvim-code-action-menu',
		cmd = 'CodeActionMenu',
	}

	-- Cmp
	use {
		'hrsh7th/nvim-cmp',
		config = configs.cmp,
	}
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/cmp-git'
	use 'saadparwaiz1/cmp_luasnip'

	-- Snippets
	use 'L3MON4D3/LuaSnip'

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- Misc
	---- NvimTree
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {
			'kyazdani42/nvim-web-devicons', -- optional, for file icon
		},
		config = function()
			require('nvim-tree').setup {}
		end
	}

	---- Symbols outline
	use {
		'simrat39/symbols-outline.nvim',
		config = function()
			require('symbols-outline').setup {}
		end
	}

	---- Whitespace
	use 'ntpeters/vim-better-whitespace'

	---- Status line
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
		config = function()
			require('lualine').setup()
		end
	}
end)
