
local awful = require("awful")
local naughty = require("naughty")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local gfs = require("gears.filesystem")
local dpi = require('beautiful').xresources.apply_dpi
local gears = require('gears')

-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged

local HOME = os.getenv("HOME")

local instances

local app = {}
local function worker(args)
    local app_launcher_widget = {}
    local args = args or {}
    local path_to_inactive = args.path_to_inactive or "/home/jowie/.config/awesome/firefox-symbolic3.svg"
    local path_to_active = args.path_to_active or "/usr/share/icons/Tela/scalable/apps/firefox-old.svg"
    local command = args.command or ""
    local instance = args.instance or ""
    local icon_widget = wibox.widget {
        {
            id = "icon",
            widget = wibox.widget.imagebox,
	    resize = true,
	    --forced_height = dpi(30),
	    --forced_width = dpi(30),
        },
        layout = wibox.container.margin(_, 0, 0, 3)
    }

    icon_widget.icon:set_image(path_to_inactive)

    
    app_launcher_widget = wibox.widget {
        icon_widget,
	id = "launcher",
        layout = wibox.layout.fixed.horizontal,
    }
    local function launch()
	    awful.spawn(command)
	    icon_widget.icon:set_image(path_to_active)
    end
    app_launcher_widget:buttons(
		gears.table.join(
			awful.button(
				{},
				1,
				nil,
				function()
					launch()
				end
			)
		)
	)
    app_launcher_widget.instance = instance
    function app_launcher_widget.change(active)
	if active then
		app_launcher_widget:get_children()[1].icon:set_image(path_to_active)
	else
		app_launcher_widget:get_children()[1].icon:set_image(path_to_inactive)
	end
    end

    --print(launcher_widget:get_children()[1].icon:set_image("/usr/share/icons/Tela/scalable/apps/firefox-old.svg"))

    --[[for k,v in pairs(launcher_widget) do
	print("key")
	    print(k)
	 print("value")
	 print(v)
    end]]--


       --launcher_widget:connect_signal("button::press", launch )
    return wibox.container.margin(app_launcher_widget)
end

return setmetatable(app, { __call = function(_, ...) return worker(...) end })
