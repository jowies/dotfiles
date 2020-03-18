
local capi = { screen = screen,
               client = client }

local awful = require("awful")
local naughty = require("naughty")
local watch = require("awful.widget.watch")
local wibox = require("wibox")
local gfs = require("gears.filesystem")
local timer = require("gears.timer")
local dpi = require('beautiful').xresources.apply_dpi
local gears = require('gears')
local tag = require("awful.tag")
local app_launcher_widget = require('widgets.launcher-widget.application')

-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged

local HOME = os.getenv("HOME")

local instances


local function get_screen(s)
    return s and screen[s]
end

local launcher_widget = {}

local function update(s, w, applications)
	local clients = {}

	local source = capi.client.get()
	local list = capi.client.get()

	for _, c in ipairs(list) do
        	if not (c.skip_taskbar or c.hidden
            		or c.type == "splash" or c.type == "dock" or c.type == "desktop")
            		and awful.widget.tasklist.filter.currenttags(c, s) then
            		table.insert(clients, c)
        	end
    	end
	print("Start")
	for _, c in pairs(applications) do

	print(c)
end
	for k,a in pairs(applications) do
		local active = false
		for _, c in pairs(clients) do
			local instance = c.instance
			if a.instance == instance then
				active = true
			end
		end
		if active then
			local x = w:get_children()[k]:get_children()[1].change(true)
		else
			local x = w:get_children()[k]:get_children()[1].change(false)
		end
	end
	print("done")

end

local function worker(args)
    local w = {}
    local args = args or {}
    local applications = args.applications or {}
    local screen = args.screen

    local argstype = type(args)

    -- Detect the old function signature
    if argstype == "number" or argstype == "screen" or
      (argstype == "table" and args.index and args == capi.screen[args.index]) then
        gdebug.deprecate("The `screen` paramater is deprecated, use `args.screen`.",
            {deprecated_in=5})

        screen = get_screen(args)
        args = {}
    end
    


    w = wibox.widget {
	id = "launcher",
        layout = wibox.layout.fixed.horizontal,
    }


    for _,v in ipairs(applications) do
	w:add(app_launcher_widget(v))
    end

    --print(launcher_widget:get_children()[1].icon:set_image("/usr/share/icons/Tela/scalable/apps/firefox-old.svg"))

    --[[for k,v in pairs(launcher_widget) do
	print("key")
	    print(k)
	 print("value")
	 print(v)
    end]]--

    --w:get_children()[1]:get_children()[1][1](true)
    --[[print(lol)
    for k,v in pairs(lol) do
	print(v)
    end
    for k,v in pairs(lol) do
	print(k)
    end]]--

    	
	screen = screen or get_screen(args.screen)
	local queued_update = false

    	-- For the tests
    	function w._do_tasklist_update_now()
        	queued_update = false
        	if screen.valid then
            		update(screen, w, applications)
        	end
    	end

    	function w._do_tasklist_update()
        -- Add a delayed callback for the first update.
        	if not queued_update then
            		timer.delayed_call(w._do_tasklist_update_now)
            		queued_update = true
        	end
    	end

    function w._unmanage(c)
        data[c] = nil
    end


    -- Signals
   if instances == nil then
        instances = setmetatable({}, { __mode = "k" })
        local function us(s)
            local i = instances[get_screen(s)]
            if i then
                for _, tlist in pairs(i) do
                    tlist._do_tasklist_update()
                end
            end
        end
        local function u()
            for s in pairs(instances) do
                if s.valid then
                    us(s)
                end
            end
        end

        tag.attached_connect_signal(nil, "property::selected", u)
        tag.attached_connect_signal(nil, "property::activated", u)
        capi.client.connect_signal("property::urgent", u)
        capi.client.connect_signal("property::sticky", u)
        capi.client.connect_signal("property::ontop", u)
        capi.client.connect_signal("property::above", u)
        capi.client.connect_signal("property::below", u)
        capi.client.connect_signal("property::floating", u)
        capi.client.connect_signal("property::maximized_horizontal", u)
        capi.client.connect_signal("property::maximized_vertical", u)
        capi.client.connect_signal("property::maximized", u)
        capi.client.connect_signal("property::minimized", u)
        capi.client.connect_signal("property::name", u)
        capi.client.connect_signal("property::icon_name", u)
        capi.client.connect_signal("property::icon", u)
        capi.client.connect_signal("property::skip_taskbar", u)
        capi.client.connect_signal("property::screen", function(c, old_screen)
            us(c.screen)
            us(old_screen)
        end)
        capi.client.connect_signal("property::hidden", u)
        capi.client.connect_signal("tagged", u)
        capi.client.connect_signal("untagged", u)
        capi.client.connect_signal("request::unmanage", function(c)
            u(c)
            for _, i in pairs(instances) do
                for _, tlist in pairs(i) do
                    tlist._unmanage(c)
                end
            end
        end)
        capi.client.connect_signal("list", u)
        capi.client.connect_signal("property::active", u)
        capi.screen.connect_signal("removed", function(s)
            instances[get_screen(s)] = nil
        end)
    end
    w._do_tasklist_update()
    local list = instances[screen]
    if not list then
        list = setmetatable({}, { __mode = "v" })
        instances[screen] = list
    end
    table.insert(list, w)



       --launcher_widget:connect_signal("button::press", launch )
    return wibox.container.margin(w)
end

return setmetatable(launcher_widget, { __call = function(_, ...) return worker(...) end })
