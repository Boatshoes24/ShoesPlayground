local SPG, E, L, V, P, G = unpack(select(2, ...))
local DT = E:GetModule('DataTexts')

local _G = _G
local classHex = SPG.MyClassHexColor
local date = date
local EasyMenu = EasyMenu
local C_DateAndTime_GetCurrentCalendarTime = C_DateAndTime.GetCurrentCalendarTime
local APM = { _G.TIMEMANAGER_AM, _G.TIMEMANAGER_PM }

local function CreateMenuItems()
    local db = SPG.db.global
    local timeMenu = CreateFrame('Frame', 'ShoesDT_TimeMenu', E.UIParent, 'UIDropDownMenuTemplate')
    local subMenu = {
        {text = 'Time Options', isTitle = true, notCheckable = true},
        {
            text = 'Use Realm Time',
            func = function(self, arg1, arg2, checked)
                db.dt.time.realm = checked
            end,
            notCheckable = false,
            checked = db.dt.time.realm,
            keepShownOnClick = true
        },
        {
            text = 'Use 24hr Format',
            func = function(self, arg1, arg2, checked) 
                db.dt.time.railway = checked
            end,
            notCheckable = false,
            checked = db.dt.time.railway,
            keepShownOnClick = true
        }
    }
    return timeMenu, subMenu
end

local function FormatTime(hour, min, railway)
    local ampm = -1
    if railway == true then
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

local function AssignTime(realm, railway)
    local time
    if realm == false then
        time = date('*t')
        return FormatTime(time.hour, time.min, railway)
    else
        time = C_DateAndTime_GetCurrentCalendarTime()
        return FormatTime(time.hour, time.minute, railway)
    end
end

local function OnClick(self, button)
    if button == "RightButton" then
        local timeMenu, subMenu = CreateMenuItems()
        EasyMenu(subMenu, timeMenu, self, 0, 3, 'MENU')
    end
end

local function OnUpdate(self, t)
    local db = SPG.db.global
    -- using throttle from ElvUI time DT
    self.timeElapsed = (self.timeElapsed or 5) - t
    if self.timeElapsed > 0 then return end
    self.timeElapsed = 5
    local hour, min, ampm = AssignTime(db.dt.time.realm, db.dt.time.railway)
    if ampm == -1 then
        self.text:SetFormattedText("%02d|c%s:|r%02d", hour, classHex or 'ffffffff', min)
    else
        self.text:SetFormattedText("%d|c%s:|r%02d |c%s%s|r", hour, classHex or 'ffffffff', min, classHex or 'ffffffff', APM[ampm])
    end

end


DT:RegisterDatatext('SDT Time', 'Shoes', {'PLAYER_ENTERING_WORLD'}, nil, OnUpdate, OnClick, nil, nil, nil)