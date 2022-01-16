local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule('DataTexts')

local RAID_CLASS_COLORS = _G.RAID_CLASS_COLORS

local function OnEvent(self, event, unit)
    local _, class = UnitClass("player")
    local classHex = RAID_CLASS_COLORS[class]:GenerateHexColor()

    local combat = UnitAffectingCombat('player') and ('|c'..classHex..'+combat|r') or '|cffffffff-combat|r'

    if event == 'PLAYER_REGEN_DISABLED' then
        E:Flash(self, 0.65, true)
    else
        E:StopFlash(self)
    end

    self.text:SetFormattedText('%s', combat or 'N/A')
end


DT:RegisterDatatext('SDT Combat Status', 'Shoes', {'PLAYER_ENTERING_WORLD', 'PLAYER_REGEN_DISABLED', 'PLAYER_REGEN_ENABLED'}, OnEvent, nil, nil, nil, nil, nil)