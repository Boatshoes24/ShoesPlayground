local SPG, E, L, V, P, G = unpack(select(2, ...))
local DT = E:GetModule('DataTexts')

local classHex = SPG.MyClassHexColor
local UnitAffectingCombat = UnitAffectingCombat

local function OnEvent(self, event, unit)
    local combat = UnitAffectingCombat('player') and ('|c'..classHex..'+combat|r') or '|cffffffff-combat|r'

    if event == 'PLAYER_REGEN_DISABLED' then
        E:Flash(self, 0.65, true)
    else
        E:StopFlash(self)
    end

    self.text:SetFormattedText('%s', combat or 'N/A')
end


DT:RegisterDatatext('SDT Combat Status', 'Shoes', {'PLAYER_ENTERING_WORLD', 'PLAYER_REGEN_DISABLED', 'PLAYER_REGEN_ENABLED'}, OnEvent, nil, nil, nil, nil, nil)