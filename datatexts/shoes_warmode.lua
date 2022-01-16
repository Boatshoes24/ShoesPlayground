local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule('DataTexts')

local C_PvP = C_PvP
local RAID_CLASS_COLORS = _G.RAID_CLASS_COLORS

local function OnEvent(self, event, unit)
    local _, class = UnitClass("player")
    local classHex = RAID_CLASS_COLORS[class]:GenerateHexColor()
    local warmode = C_PvP.IsWarModeDesired() and "|cff00ff00On|r" or "|cffff0000Off|r"
    self.text:SetFormattedText('|c%sWar:|r %s', classHex or 'ffffffff', warmode or 'N/A')
end

local function OnClick(self, button)
    if button == "LeftButton" then
        if (C_PvP.CanToggleWarMode(not C_PvP.IsWarModeDesired())) then
            C_PvP.SetWarModeDesired(not C_PvP.IsWarModeDesired())
        else
            print("Cannot toggle war mode here.")
        end
    end
end


DT:RegisterDatatext('SDT War Mode', 'Shoes', {'PLAYER_ENTERING_WORLD', 'PLAYER_FLAGS_CHANGED'}, OnEvent, nil, OnClick, nil, nil, nil)