local opt = vim.opt

opt.mouse = 'a'
opt.mousemoveevent = true
opt.clipboard = 'unnamedplus'
opt.swapfile = false
opt.hidden = true
opt.history = 100
opt.synmaxcol = 240

opt.number = true
opt.foldenable = false
opt.foldmethod = 'indent'
opt.splitright = true
opt.splitbelow = true
opt.equalalways = false
opt.ignorecase = true
opt.smartcase = true
opt.wrap = false
opt.termguicolors = true
opt.laststatus = 2
opt.completeopt = 'menu,menuone,noinsert,noselect'
opt.pumheight = 14
opt.shortmess:append 'sI'

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true
opt.cino = 't0,N-s,g-1'

