local awful = require("awful")
local beautiful = require("beautiful")

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
        --{
        --        rule = { class = "Firefox"},
        --        properties= { tag = tags[1][1] },
        --},
        --{
        --        rule = { class = "Pidgin" },
        --        properties = { tag = tags[1][2],
        --                       callback   = awful.client.setslave },
        --},
        { 
                rule = { instance = "plugin-container"},
                properties = { floating = true } },
        {
                rule = { instance = "plugin-container" },
                properties = { floating = true }
        },
        {
                rule = { class = "gimp" },
                properties = { floating = true }
        },
}
-- }}}


