local SPG, E, L, V, P, G = unpack(select(2, ...))
local DT = E:GetModule('DataTexts')
local CT = SPG.ChatTabs
local tab = CT["ChatTabs_DataText3"]
local classHex = SPG.MyClassHexColor
local inactive = SPG.InactiveHexColor

local _G = _G
local ToggleDropDownMenu = _G.ToggleDropDownMenu

local function OnEvent(self, event, unit)
    if tab.selected or tab.flashing then
        self.text:SetFormattedText("|c%s%s|r", classHex, tab.text)
    else
        self.text:SetFormattedText("|c%s%s|r", inactive, tab.text)
    end
end

local function OnClick(self, button)
    if not button == "LeftButton" then return end
    if button == "LeftButton" then
        tab.clickFrame:Click()
        tab.selected = true
        tab.flashing = false
        E:StopFlash(self)
        SPG:UpdateTabs()
    elseif button == "RightButton" then
        SPG:UpdateChatID(tab.id)
        ToggleDropDownMenu(1, nil, _G[tab.clickFrame:GetName().."DropDown"], tab.clickFrame:GetName(), 0, 0)
    end
end

DT:RegisterDatatext('SDT Chat 3', 'Shoes', {'PLAYER_ENTERING_WORLD'}, OnEvent, nil, OnClick, OnEnter, nil, nil)