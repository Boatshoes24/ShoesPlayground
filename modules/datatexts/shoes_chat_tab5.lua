local SPG, E, L, V, P, G = unpack(select(2, ...))
local DT = E:GetModule('DataTexts')
local CT = SPG.ChatTabs
local tab = CT["ChatTabs_DataText5"]
local classHex = SPG.MyClassHexColor
local inactive = SPG.InactiveHexColor

local function OnEvent(self, event, unit)
    if event == "CHAT_MSG_WHISPER" or event == "CHAT_MSG_BN_WHISPER" then
        if not tab.selected then
            tab.flashing = true
            E:Flash(self, 0.65, true)
        end
    end
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
    end
end

DT:RegisterDatatext('SDT Chat 5', 'Shoes', {'PLAYER_ENTERING_WORLD', 'CHAT_MSG_WHISPER', 'CHAT_MSG_BN_WHISPER'}, OnEvent, nil, OnClick, OnEnter, nil, nil)