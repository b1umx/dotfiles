local luasnip = require('luasnip')
local types = require('luasnip.util.types')

luasnip.config.setup({
    update_events = "TextChanged,TextChangedI",
	region_check_events = "CursorHold,InsertLeave",
	delete_check_events = "TextChanged,InsertEnter",
    ext_opts = {
        [types.choiceNode] = { active = { virt_text = {{ '󰷐', 'SnippetChoiceNode' }} } },
        [types.insertNode] = { active = { virt_text = {{ '', 'SnippetInsertNode' }} } }
    }
})

luasnip.add_snippets('cpp', require('snippets/cpp'))

vim.keymap.set({ 'i', 's' }, '<C-k>', function ()
    if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
    end
end, { noremap = true, silent = true })
vim.keymap.set({ 'i', 's' }, '<C-j>', function ()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { noremap = true, silent = true })
vim.keymap.set({ 'i', 's' }, '<C-e>', function ()
    if luasnip.choice_active() then
        luasnip.change_choice()
    end
end, { noremap = true, silent = true })

