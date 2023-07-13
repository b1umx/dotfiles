local luasnip = require('luasnip')
local s = luasnip.snippet
local t = luasnip.text_node
local i = luasnip.insert_node
local c = luasnip.choice_node
local f = luasnip.function_node
local fmta = require('luasnip.extras.fmt').fmta

local definitions = {
    s({
        trig = 'class_hpp',
        dscr = 'C++ header class declaration inside namespace'
    }, fmta([[
        #pragma once

        namespace <> {

        <> <3> {
        public:
            <3>();<>
        };

        }
    ]], {
        i(1, 'ns'),
        c(2, { t('class'), t('struct') }),
        i(3, 'Name'),
        i(0)
    }, { repeat_duplicates = true })),
    s({
        trig = 'class_cpp',
        dscr = 'C++ source class definition inside namespace'
    }, fmta([[
        #include "<>"

        namespace <> {

        <3>::<3>() {<>
        }

        }
    ]], {
        f(function()
            return vim.fn.fnamemodify(vim.fn.expand('%'), ':t:r') .. '.hpp'
        end, {}),
        i(1, 'ns'),
        i(2, 'Name'),
        i(0)
    }, { repeat_duplicates = true })),
    s({
        trig = 'qt_paint_event',
        dscr = 'Standard minimal paintEvent() realization'
    }, fmta([[
        void <>::paintEvent(QPaintEvent *) {
            QStyleOption opt;
            opt.init(this);
            QPainter p(this);
            style()->>drawPrimitive(QStyle::<>, &opt, &p, this);
        }
    ]], {
        i(1, 'Name'),
        i(2, 'PE_Frame')
    }))
}

return definitions

