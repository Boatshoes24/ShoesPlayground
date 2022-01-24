local SPG, E, _, V, P, G = unpack(select(2, ...))
local CH = E:GetModule("Chat")

local classHex = SPG.MyClassHexColor
local inactive = "ff3c3c3c"

local _G = _G
local SELECTED_CHAT_FRAME = _G.SELECTED_CHAT_FRAME
local NUM_CHAT_WINDOWS = _G.NUM_CHAT_WINDOWS
local CHAT_FRAMES = _G.CHAT_FRAMES
local lastFrame = _G.ChatFrame10Tab

function SPG:RGBPercToHex(r, g, b)
	r = r <= 1 and r >= 0 and r or 0
	g = g <= 1 and g >= 0 and g or 0
	b = b <= 1 and b >= 0 and b or 0
	return string.format("%02x%02x%02x", r*255, g*255, b*255)
end

function SPG:SetupChatWindows()
    for i = 1, NUM_CHAT_WINDOWS do
        local tab = _G["ChatFrame"..i.."Tab"]
        tab:Hide()
        tab.Show = tab.Hide
    end

    for _, name in ipairs(_G.CHAT_FRAMES) do
        _G[name]:SetHeight(self.ChatFrameHeight)
    end
end

function SPG:UpdateChatID(id)
    _G.CURRENT_CHAT_FRAME_ID = id
end

function SPG:UpdateTabs()    
    local id = SELECTED_CHAT_FRAME:GetID()
    for k, v in pairs(self.ChatTabs) do
        local tab = _G[k]
        if id == v.id or v.flashing then
            tab.text:SetFormattedText("|c%s%s|r", classHex, v.text)
            v.selected = true
        else
            tab.text:SetFormattedText("|c%s%s|r", inactive, v.text)
            v.selected = false
        end
    end
end

function SPG:PLAYER_ENTERING_WORLD()
    hooksecurefunc("FCF_Tab_OnClick", function(self, button) 
        local chatFrame = _G["ChatFrame"..self:GetID()]
        SELECTED_CHAT_FRAME = chatFrame
    end)
end