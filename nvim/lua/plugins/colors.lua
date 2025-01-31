return {
  {
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'warm',
      transparent = false
    }
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      commentStyle = { italic = false },
      keywordStyle = { italic = false },
      statementStyle = { bold = false },
      terminalColors = false,
      theme = 'wave',
      background = {
          dark = 'dragon',
          light = 'lotus'
      },
      overrides = function(_)
        return {
          Boolean = { bold = false }
        }
      end
    }
  }
}

