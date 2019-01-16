local gears   = require("gears")
local awful   = require("awful")
local wibox   = require("wibox")
local naughty = require("naughty")

local function trim(s)
    return s:find'^%s*$' and '' or s:match'^%s*(.*%S)'
end

local function get_battery_capacity()
    local f_capacity = assert(io.open("/sys/class/power_supply/BAT0/capacity", "r"))
    return tonumber(f_capacity:read("*all"))
end

local function get_battery_status()
    local f_status = assert(io.open("/sys/class/power_supply/BAT0/status", "r"))
    return trim(f_status:read("*all"))
end

local mybatterybar = wibox.widget {
    {
        min_value        = 0,
        max_value        = 100,
        value            = 0,
        paddings         = 0,
        border_width     = 1,
        forced_width     = 40,
        color            = "#2e8b00",
        background_color = "#000000",
        id               = "mypb",
        widget           = wibox.widget.progressbar,
        margins = {
            top    = 3,
            bottom = 3,
        },
    },
    {
        id     = "mytb",
        text   = "100%",
        widget = wibox.widget.textbox,
    },
    layout      = wibox.layout.stack,
    set_battery = function(self, val)
        self.mytb.text  = tonumber(val).."%"
        self.mypb.value = tonumber(val)
    end,
}

local function update_battery_capacity()
    mybatterybar.battery = get_battery_capacity()
end

gears.timer {
    timeout   = 10,
    call_now  = true,
    autostart = true,
    callback  = update_battery_capacity,
}

local function battery_low_notify()
    local bat_capacity = get_battery_capacity()
    local bat_status   = get_battery_status()
    if (bat_capacity <= 20 and bat_status == "Discharging") then
        naughty.notify({
                title     = "Battery Warning",
                text      = "Battery low! " .. bat_capacity .. "%" .. " left!",
                icon      = os.getenv("HOME") .. "/Pictures/battery-low.png",
                icon_size = 80,
                fg        = "#ff0000",
                bg        = "#deb887",
                timeout   = 0,
        })
    end
end

gears.timer {
    timeout   = 120,
    autostart = true,
    callback  = battery_low_notify,
}

return mybatterybar
