local _, ns = ...
local SPG = ns.Addon
local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule('DataTexts')

local isLogging = '|cff00ff00On|r'
local notLogging = '|cffff0000Off|r'
local displayString = '|c%sLogs:|r %s'
local classHex = 'ffffffff'
local GetInstanceInfo = GetInstanceInfo
local LoggingCombat = LoggingCombat

local autoLogRaidIDs = {
    [2296] = 'Castle Nathria',
    [2450] = 'Sanctum of Domination',
    [2481] = 'Sepulcher of the First Ones'
}

local db

local function CreateMenuItems()
    local diffMenu = CreateFrame('Frame', 'ShoesDT_TimeMenu', E.UIParent, 'UIDropDownMenuTemplate')
    local subMenu = {
        {text = 'Autolog Difficult Selection', isTitle = true, notCheckable = true},
        {
            text = 'Mythic Raids',
            func = function(self, arg1, arg2, checked)
                db.dt.logs[16].value = checked
            end,
            notCheckable = false,
            checked = db.dt.logs[16].value,
            keepShownOnClick = true
        },
        {
            text = 'Heroic Raids',
            func = function(self, arg1, arg2, checked) 
                db.dt.logs[15].value = checked
            end,
            notCheckable = false,
            checked = db.dt.logs[15].value,
            keepShownOnClick = true
        },
        {
            text = 'Normal Raids',
            func = function(self, arg1, arg2, checked)
                db.dt.logs[14].value = checked
            end,
            notCheckable = false,
            checked = db.dt.logs[14].value,
            keepShownOnClick = true
        },
        {
            text = 'LFR Raids',
            func = function(self, arg1, arg2, checked)
                db.dt.logs[17].value = checked
            end,
            notCheckable = false,
            checked = db.dt.logs[17].value,
            keepShownOnClick = true
        },
        {
            text = 'M+ Dungeons',
            func = function(self, arg1, arg2, checked)
                db.dt.logs[8].value = checked
            end,
            notCheckable = false,
            checked = db.dt.logs[8].value,
            keepShownOnClick = true
        },
    }
    return diffMenu, subMenu
end

local function OnEvent(self, event, unit)
    db = SPG.db.global
    classHex = ns.MyClassHexColor
    local diffID = select(3, GetInstanceInfo())
    local raidID = select(8, GetInstanceInfo())

    if diffID == 8 then
        LoggingCombat(db.dt.logs[8].value)
        if LoggingCombat() then
            self.text:SetFormattedText(displayString, classHex, isLogging)
        else
            self.text:SetFormattedText(displayString, classHex, notLogging)
        end
    elseif diffID > 13 and diffID < 18 and autoLogRaidIDs[raidID] then
        LoggingCombat(db.dt.logs[diffID].value)
        if LoggingCombat() then
            self.text:SetFormattedText(displayString, classHex, isLogging)
        else
            self.text:SetFormattedText(displayString, classHex, notLogging)
        end
    end

    if LoggingCombat() then
        self.text:SetFormattedText(displayString, classHex, isLogging)
    else
        self.text:SetFormattedText(displayString, classHex, notLogging)
    end
end

local function OnClick(self, button)
    if button == 'LeftButton' then
        if LoggingCombat() then
            LoggingCombat(false)
            self.text:SetFormattedText(displayString, classHex, notLogging)
        else
            LoggingCombat(true)
            self.text:SetFormattedText(displayString, classHex, isLogging)
        end
    elseif button == 'RightButton' then
        local diffMenu, subMenu = CreateMenuItems()
        EasyMenu(subMenu, diffMenu, self, 0, 0, 'MENU')
    end
end

local function OnEnter()
    DT.tooltip:ClearLines()

    DT.tooltip:AddLine('Included Raids')
    for _, v in pairs(autoLogRaidIDs) do
        DT.tooltip:AddLine(format('|cff00ff00%s|r', v))
    end

    DT.tooltip:AddLine(' ')
    DT.tooltip:AddLine('Current Settings')
    for _, v in pairs(db.dt.logs) do
        DT.tooltip:AddDoubleLine(format('|cffffffff%s|r', v.name), v.value and '|cff00ff00true|r' or '|cffff0000false|r')
    end

    DT.tooltip:Show()
end


DT:RegisterDatatext('SDT Combat Logging', 'Shoes', {'PLAYER_ENTERING_WORLD', 'ZONE_CHANGED', 'ZONE_CHANGED_NEW_AREA', 'RAID_INSTANCE_WELCOME'}, OnEvent, nil, OnClick, OnEnter, nil, nil)