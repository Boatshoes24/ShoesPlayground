local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule('DataTexts')

local anvilIcon = 136241
local equipmentList = {}
local equipmentSlotNames = {
    [0] = 'Ammo',
    [1] = 'Head',
    [2] = 'Neck',
    [3] = 'Shoulders',
    [4] = 'Shirt',
    [5] = 'Chest',
    [6] = 'Waist',
    [7] = 'Legs',
    [8] = 'Feet',
    [9] = 'Wrist',
    [10] = 'Hands',
    [11] = 'Ring1',
    [12] = 'Ring2',
    [13] = 'Trinket1',
    [14] = 'Trinket2',
    [15] = 'Back',
    [16] = 'MH',
    [17] = 'OH',
    [18] = 'Ranged',
    [19] = 'Tabard',
}
local tinsert = table.insert
local floor = math.floor
local RAID_CLASS_COLORS = _G.RAID_CLASS_COLORS

local function getDurabilityColor(value)
    local color = 'ffffffff'
    if value > 75 then
        color = 'ff00ff00'
    elseif value > 35 then
        color = 'ffffff00'
    elseif value > 0 then
        color = 'ffff0000' 
    end
    return color
end

local function OnEvent(self, event, unit)
    equipmentList = {}
    local _, class = UnitClass("player")
    local classHex = RAID_CLASS_COLORS[class]:GenerateHexColor()

    local totalCurr, totalMax = 0, 0
    for i = 1, 19 do
        local itemCurr, itemMax = GetInventoryItemDurability(i)
        if itemCurr and itemMax then
            totalCurr = totalCurr + itemCurr
            totalMax = totalMax + itemMax
            local itemTbl = { name = equipmentSlotNames[i], value =  floor(itemCurr / itemMax * 100 ) }
            tinsert(equipmentList, itemTbl)
        end
    end

    local totalPercent = floor(totalCurr / totalMax * 100)

    if totalPercent < 50 then
        E:Flash(self, 0.65, true)
    else
        E:StopFlash(self)
    end

    self.text:SetFormattedText('|T%d:0[:0[:0:1]]|t |c%s%s%%|r', anvilIcon, classHex or 'ffffffff', totalPercent or 'n/a')   
end

 local function OnEnter()
    DT.tooltip:ClearLines()

    local _, class = UnitClass("player")
    local classHex = RAID_CLASS_COLORS[class]:GenerateHexColor()

    DT.tooltip:AddLine('|cffffffffDurability Summary|r')
    DT.tooltip:AddLine(' ')

    for k, v in ipairs(equipmentList) do
        DT.tooltip:AddDoubleLine(('|c%s%s|r'):format(classHex or 'ffffffff', v.name), ('|c%s%d%%'):format(getDurabilityColor(v.value), v.value or 0))
    end

    DT.tooltip:Show()
end



DT:RegisterDatatext('SDT Durability', 'Shoes', {'PLAYER_ENTERING_WORLD', 'PLAYER_DEAD', 'UPDATE_INVENTORY_DURABILITY', 'PLAYER_EQUIPMENT_CHANGED'}, OnEvent, nil, nil, OnEnter, nil, nil)