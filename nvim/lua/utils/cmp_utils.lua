local cmp = require('cmp')
local luasnip = require('luasnip')

local M = {}

function M.toggle_completion(_)
    print('foo')
    if cmp.visible() then
        cmp.abort();
    else
        cmp.complete();
    end
end


function M.select_next_item(fallback)
    if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    else
        fallback()
    end
end

function M.select_prev_item(fallback)
    if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
    else
        fallback()
    end
end

function M.select_next_item_or_snippet_choice(fallback)
    if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
    elseif luasnip.choice_active() then
        luasnip.change_choice()
    else
        fallback()
    end
end


function M.select_prev_item_or_snippet_choice(fallback)
    if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
    elseif luasnip.choice_active() then
        luasnip.change_choice(-1)
    else
        fallback()
    end
end


function M.confirm_or_snippet_jump(fallback)
    if cmp.visible() and cmp.get_selected_entry() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        fallback()
    end
end

function M.confirm(fallback)
    if cmp.visible() and cmp.get_selected_entry() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = false })
    else
        fallback()
    end
end

function M.snippet_jump_reverse(fallback)
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
end

function M.interrupt_current_snippet(fallback)
  if luasnip.jumpable(1) then
    luasnip.unlink_current()
  else
    fallback()
  end
end

local cmp_menu_labels = {
    nvim_lsp = "[LSP]",
    luasnip = "[Snip]",
    buffer = "[Buffer]",
    path = "[Path]",
    cmdline = "[CMD]"

}

function M.format_completion_item(entry, vim_item)
    if entry.source.name == 'nvim_lsp' then
        local filterText = entry.completion_item.filterText
        if filterText == nil or filterText == '' then
            vim_item.abbr = entry.completion_item.label
        else
            vim_item.abbr = filterText
        end
    end
    vim_item.menu = cmp_menu_labels[entry.source.name]
    return vim_item
end

return M

