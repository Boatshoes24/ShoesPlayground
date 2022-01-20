local SPG, E, L, V, P, G = unpack(select(2, ...))
local DT = E:GetModule('DataTexts')

local classHex = SPG.MyClassHexColor

local select = select
local GetSpecializationInfoByID = GetSpecializationInfoByID
local GetSpecializationInfo = GetSpecializationInfo
local GetLootSpecialization = GetLootSpecialization
local GetSpecialization = GetSpecialization


local function OnEvent(self, event, unit)

    local lootIcon = select(4, GetSpecializationInfoByID(GetLootSpecialization()))
    local defaultIcon = select(4, GetSpecializationInfo(GetSpecialization()))

    self.text:SetFormattedText('|c%sLoot:|r |T%d:0:0:0:1:64:64:4:60:4:60|t', classHex or 'ffffffff', lootIcon or defaultIcon)
end


DT:RegisterDatatext('SDT Loot Spec', 'Shoes', {'PLAYER_ENTERING_WORLD', 'PLAYER_LOOT_SPEC_UPDATED', 'PLAYER_SPECIALIZATION_CHANGED'}, OnEvent, nil, nil, nil, nil, nil)