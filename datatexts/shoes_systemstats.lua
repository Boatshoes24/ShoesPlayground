local _, ns = ...
local SPG = ns.Addon
local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule('DataTexts')

local _G = _G
local select = select
local UnitClass = UnitClass
local classHex = 'ffffffff'
local GetNetStats = GetNetStats
local GetFramerate = GetFramerate

local function OnEvent(self, event, unit)
    classHex = ns.MyClassHexColor
end

local function OnUpdate(self, t)
    -- using throttle from ElvUI time DT
    self.timeElapsed = (self.timeElapsed or 5) - t
    if self.timeElapsed > 0 then return end
    self.timeElapsed = 5
    local _, _, home, world = GetNetStats()
    local frate = GetFramerate()
    self.text:SetFormattedText('%d|c%sfps|r %d|c%sms|r', frate or 0, classHex, world or 0, classHex)    
end


DT:RegisterDatatext('SDT System Stats', 'Shoes', {'PLAYER_ENTERING_WORLD'}, OnEvent, OnUpdate, nil, nil, nil, nil)