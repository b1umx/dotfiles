local luasnip = require('luasnip')
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node

luasnip.config.set_config({
    history = false,
})

luasnip.add_snippets('lua', {
    s({
        trig="if basic",
        wordTrig=true
    }, {
	    t({"if "}),
	    i(1),
	    t({" then", "\t"}),
	    i(0),
	    t({"", "end"})
	})
})

vim.keymap.set({ 'i', 's' }, '<C-k>', function ()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { noremap = true, silent = true })
vim.keymap.set({ 'i', 's' }, '<C-j>', function ()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { noremap = true, silent = true })

