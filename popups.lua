local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")-- ===== POPUPS VOLUMEN Y BRILLO =====

local function get_volume()
    local f = io.popen("pamixer --get-volume 2>/dev/null")
    local v = f:read("*l"); f:close()
    return tonumber(v) or 0
end

local function get_muted()
    local f = io.popen("pamixer --get-mute 2>/dev/null")
    local m = f:read("*l"); f:close()
    return m == "true"
end

local function get_brightness()
    local f = io.popen("brightnessctl get 2>/dev/null")
    local cur = tonumber(f:read("*l")) or 0; f:close()
    local f2 = io.popen("brightnessctl max 2>/dev/null")
    local max = tonumber(f2:read("*l")) or 100; f2:close()
    return math.floor((cur / max) * 100)
end

local function make_popup()
    local p = wibox({ width = 220, height = 65, bg = "#1a1a1aCC", ontop = true, visible = false, type = "notification" })
    p.shape = function(cr, w, h) gears.shape.rounded_rect(cr, w, h, 12) end
    return p
end

local hide_timer = gears.timer({ timeout = 2 })
local current_popup = nil
local vol_popup = make_popup()
local bri_popup = make_popup()

local vol_label = wibox.widget({ markup = "🔊 Volume  0%", font = "JetBrains Mono Bold 11", align = "left", widget = wibox.widget.textbox })
local vol_bar = wibox.widget({ max_value = 100, value = 0, forced_height = 8, shape = gears.shape.rounded_bar, color = "#ffffffBB", background_color = "#444444AA", widget = wibox.widget.progressbar })
vol_popup:setup({ { vol_label, vol_bar, layout = wibox.layout.fixed.vertical, spacing = 8 }, margins = 14, widget = wibox.container.margin })

local bri_label = wibox.widget({ markup = "☀ Brightness  0%", font = "JetBrains Mono Bold 11", align = "left", widget = wibox.widget.textbox })
local bri_bar = wibox.widget({ max_value = 100, value = 0, forced_height = 8, shape = gears.shape.rounded_bar, color = "#ffffffBB", background_color = "#444444AA", widget = wibox.widget.progressbar })
bri_popup:setup({ { bri_label, bri_bar, layout = wibox.layout.fixed.vertical, spacing = 8 }, margins = 14, widget = wibox.container.margin })

local function show_popup(p)
    if current_popup and current_popup ~= p then current_popup.visible = false end
    current_popup = p
    local s = awful.screen.focused()
    p.x = s.geometry.x + s.geometry.width - p.width - 20
    p.y = s.geometry.y + 50
    p.visible = true
    if hide_timer.started then hide_timer:stop() end
    hide_timer:start()
end

hide_timer:connect_signal("timeout", function()
    if current_popup then current_popup.visible = false end
    hide_timer:stop()
end)

local function update_volume()
    local v = get_volume()
    local muted = get_muted()
    vol_label.markup = "<span color='#ffffff'>" .. (muted and "🔇 Muted" or ("🔊 Volume  " .. v .. "%")) .. "</span>"
    vol_bar.value = v
    show_popup(vol_popup)
end

local function update_brightness()
    local b = get_brightness()
    bri_label.markup = "<span color='#ffffff'>☀ Brightness  " .. b .. "%</span>"
    bri_bar.value = b
    show_popup(bri_popup)
end

root.keys(awful.util.table.join(
    root.keys(),
    awful.key({}, "XF86AudioRaiseVolume",  function() awful.spawn.easy_async("pamixer -i 5",          function() update_volume()     end) end),
    awful.key({}, "XF86AudioLowerVolume",  function() awful.spawn.easy_async("pamixer -d 5",          function() update_volume()     end) end),
    awful.key({}, "XF86AudioMute",         function() awful.spawn.easy_async("pamixer -t",            function() update_volume()     end) end),
    awful.key({}, "XF86MonBrightnessUp",   function() awful.spawn.easy_async("brightnessctl set 5%+", function() update_brightness() end) end),
    awful.key({}, "XF86MonBrightnessDown", function() awful.spawn.easy_async("brightnessctl set 5%-", function() update_brightness() end) end)
    ))
