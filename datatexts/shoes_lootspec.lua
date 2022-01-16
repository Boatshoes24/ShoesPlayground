local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule('DataTexts')

local select = select
local UnitClass = UnitClass
local GetSpecializationInfoByID = GetSpecializationInfoByID
local GetSpecializationInfo = GetSpecializationInfo
local GetLootSpecialization = GetLootSpecialization
local GetSpecialization = GetSpecialization
local RAID_CLASS_COLORS = _G.RAID_CLASS_COLORS

local function OnEvent(self, event, unit)
    local _, class = UnitClass("player")
    local classHex = RAID_CLASS_COLORS[class]:GenerateHexColor()

    local lootIcon = select(4, GetSpecializationInfoByID(GetLootSpecialization()))
    local defaultIcon = select(4, GetSpecializationInfo(GetSpecialization()))

    self.text:SetFormattedText('|c%sLoot:|r |T%d:0[:0[:0:1]]|t', classHex or 'ffffffff', lootIcon or defaultIcon)
end


DT:RegisterDatatext('SDT Loot Spec', 'Shoes', {'PLAYER_ENTERING_WORLD', 'PLAYER_LOOT_SPEC_UPDATED', 'PLAYER_SPECIALIZATION_CHANGED'}, OnEvent, nil, nil, nil, nil, nil)