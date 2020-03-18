
local awful = require("awful")
local naughty = require("naughty")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local gfs = require("gears.filesystem")
local dpi = require('beautiful').xresources.apply_dpi
local gears = require('gears')
local app_launcher_widget = require('widgets.launcher-widget.application')

-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged

local HOME = os.getenv("HOME")

local instances

local launcher_widget = {}
local function worker(args)
    local args = args or {}
    local applications = args.applications or {}
    


    launcher_widget = wibox.widget {
	id = "launcher",
        layout = wibox.layout.fixed.horizontal,
    }


    for _,v in ipairs(applications) do
	launcher_widget:add(app_launcher_widget(v))
    end

    --print(launcher_widget:get_children()[1].icon:set_image("/usr/share/icons/Tela/scalable/apps/firefox-old.svg"))

    --[[for k,v in pairs(launcher_widget) do
	print("key")
	    print(k)
	 print("value")
	 print(v)
    end]]--

    launcher_widget:get_children()[1]:get_children()[1][1](true)
    --[[print(lol)
    for k,v in pairs(lol) do
	print(v)
    end
    for k,v in pairs(lol) do
	print(k)
    end]]--



       --launcher_widget:connect_signal("button::press", launch )
    return wibox.container.margin(launcher_widget)
end

return setmetatable(launcher_widget, { __call = function(_, ...) return worker(...) end })
