local luasnip = require('luasnip')
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local c = luasnip.choice_node

local definitions = {
    s({
        trig = 'hppcls',
        dscr = 'C++ header class declaration inside namespace'
    }, {
        t({ '#pragma once', '', 'namespace ' }),
        i(1),
        t({ ' {', '', '' }),
        c(2, {
            t('class '),
            t('struct ')
        }),
        i(3),
        t({ ' {', '' }),
        i(0),
        t({ '', '};', '', '}', '' })
    }),
    s({
        trig = 'cppcls',
        dscr = 'C++ source class definition inside namespace'
    }, {
        t('#include "'),
        i(1),
        t({ '"', '', 'namespace ' }),
        i(2),
        t({ ' {', '', '' }),
        i(3),
        t('::'),
        i(0),
        t({ '', '', '}', '' })
    })
}

return definitions

