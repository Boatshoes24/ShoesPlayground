local _, ns = ...
local SPG = ns.Addon
local E, L, V, P, G = unpack(ElvUI)
local DT = E:GetModule('DataTexts')

local bagIcon = 130716
local GetContainerNumFreeSlots = GetContainerNumFreeSlots

local function OnEvent(self, event, unit)
    classHex = ns.MyClassHexColor

    local emptySlots = 0
    for i = 0, 4 do
        emptySlots = emptySlots + GetContainerNumFreeSlots(i)
    end

    self.text:SetFormattedText('|T%d:0:0:0:1:64:64:4:60:4:60|t |c%s%d|r', bagIcon, classHex or 'ffffffff', emptySlots or -1)
end


DT:RegisterDatatext('SDT Bag Space', 'Shoes', {'PLAYER_ENTERING_WORLD', 'BAG_UPDATE'}, OnEvent, nil, nil, nil, nil, nil)