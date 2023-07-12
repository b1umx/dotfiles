-- Автоматическая установка packer, если отсутствует
local fn = vim.fn
local packer_dir = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(packer_dir)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', packer_dir })
    vim.o.runtimepath = fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

-- Автоматическое чтение файла и синхронизация packer после сохранения буфера
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost */packages/init.lua source <afile> | PackerSync
    augroup end
]]

local packer = require('packer')
return packer.startup(function(use)
    -- Packer
    use 'wbthomason/packer.nvim'

    -- Цветовые схемы
    use 'sainnhe/sonokai'
    use 'luisiacc/gruvbox-baby'
    use {
        'catppuccin/nvim',
        as = "catppuccin"
    }

    -- Аккуратное удаление буферов
    use 'famiu/bufdelete.nvim'

    -- Иконки
    use {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup()
        end
    }

    -- Навигация
    use {
        'nvim-tree/nvim-tree.lua',
        tag = 'nightly'  -- Стабильные изменения для этого проекта
    }

    -- Улучшенная строка статуса
    use 'nvim-lualine/lualine.nvim'
    use 'arkav/lualine-lsp-progress'

    -- Строка с открытыми буферами
    use {
        'akinsho/bufferline.nvim',
        tag = 'v3.*',
        requires = 'nvim-tree/nvim-web-devicons'
    }

    -- Скроллбар
    use 'petertriho/nvim-scrollbar'

    -- Синтаксический анализатор
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end
    }
    use 'preservim/tagbar'

    -- Маркеры Git
    use 'lewis6991/gitsigns.nvim'

    -- Улучшенный поиск
    use 'kevinhwang91/nvim-hlslens'

    -- Распознавание TODO-комментариев
    use 'folke/todo-comments.nvim'

    -- Автодополнение
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    use 'neovim/nvim-lspconfig'
    use 'onsails/lspkind.nvim'

    use 'norcalli/nvim-colorizer.lua'

    -- Поиск по файлам
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    -- Система сборки
    use {
        'Shatur/neovim-tasks',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }

    -- Отладка
    use 'mfussenegger/nvim-dap'

    -- Быстрое комментирование
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- Работа с обрамляющими знаками
    use 'tpope/vim-surround'
end)

