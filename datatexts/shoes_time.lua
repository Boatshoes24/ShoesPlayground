local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule('DataTexts')

local _G = _G
local select = select
local UnitClass = UnitClass
local classHex = 'ffffffff'
local date = date
local C_DateAndTime_GetCurrentCalendarTime = C_DateAndTime.GetCurrentCalendarTime
local APM = { _G.TIMEMANAGER_AM, _G.TIMEMANAGER_PM }

local RAID_CLASS_COLORS = _G.RAID_CLASS_COLORS

local function FormatTime(hour, min, format)
    local ampm = -1
    if format == '24' then
        return hour, min, ampm
    end
    if hour >= 12 then 
        if hour > 12 then hour = hour - 12 end
        ampm = 2
    else
        if hour == 0 then hour = 12 end
        ampm = 1
    end
    return hour, min, ampm
end

local function AssignTime(origin, format)
    local time
    if origin == 'local' then
        time = date('*t')
        return FormatTime(time.hour, time.min, format)
    else
        time = C_DateAndTime_GetCurrentCalendarTime()
        return FormatTime(time.hour, time.minute, format)
    end
end

local function OnEvent(self, event, unit)
    local _, class = UnitClass("player")
    classHex = RAID_CLASS_COLORS[class]:GenerateHexColor()
end

local function OnUpdate(self, t)
    -- using throttle from ElvUI time DT
    self.timeElapsed = (self.timeElapsed or 5) - t
    if self.timeElapsed > 0 then return end
    self.timeElapsed = 5
    local hour, min, ampm = AssignTime('local', '12')
    if ampm == -1 then
        self.text:SetFormattedText("%02d|c%s:|r%02d", hour, classHex or 'ffffffff', min)
    else
        self.text:SetFormattedText("%02d|c%s:|r%02d |c%s%s|r", hour, classHex or 'ffffffff', min, classHex or 'ffffffff', APM[ampm])
    end

end


DT:RegisterDatatext('SDT Time', 'Shoes', {'PLAYER_ENTERING_WORLD'}, OnEvent, OnUpdate, nil, nil, nil, nil)