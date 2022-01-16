local _, ns = ...
local SPG = ns.Addon
local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule('DataTexts')

local classHex = 'ffffffff'
local C_PvP_IsWarModeDesired = C_PvP.IsWarModeDesired
local C_PvP_CanToggleWarMode = C_PvP.CanToggleWarMode
local C_PvP_SetWarModeDesired = C_PvP.SetWarModeDesired

local function OnEvent(self, event, unit)
    classHex = ns.MyClassHexColor

    local warmode = C_PvP_IsWarModeDesired() and "|cff00ff00On|r" or "|cffff0000Off|r"
    self.text:SetFormattedText('|c%sWar:|r %s', classHex or 'ffffffff', warmode or 'N/A')
end

local function OnClick(self, button)
    if button == "LeftButton" then
        if (C_PvP_CanToggleWarMode(not C_PvP_IsWarModeDesired())) then
            C_PvP_SetWarModeDesired(not C_PvP_IsWarModeDesired())
        else
            print("Cannot toggle war mode here.")
        end
    end
end


DT:RegisterDatatext('SDT War Mode', 'Shoes', {'PLAYER_ENTERING_WORLD', 'PLAYER_FLAGS_CHANGED'}, OnEvent, nil, OnClick, nil, nil, nil)