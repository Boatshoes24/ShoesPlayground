local SPG, E, _, V, P, G = unpack(select(2, ...))
local CH = E:GetModule("Chat")

local _G = _G
local chat_frame1 = _G.ChatFrame1Tab
local chat_frame2 = _G.ChatFrame2Tab
local chat_frame4 = _G.ChatFrame4Tab
local chat_frame5 = _G.ChatFrame5Tab
local chat_frame6 = _G.ChatFrame6Tab

SPG.ChatTabs = {
    ["ChatTabs_DataText1"] = {
        id = 1,
        text = "G",
        selected = true,
        flashing = false,
        clickFrame = chat_frame1,
    },
    ["ChatTabs_DataText2"] = {
        id = 2,
        text = "L",
        selected = false,
        flashing = false,
        clickFrame = chat_frame2,
    },
    ["ChatTabs_DataText3"] = {
        id = 4,
        text = "S",
        selected = false,
        flashing = false,
        clickFrame = chat_frame4,
    },
    ["ChatTabs_DataText4"] = {
        id = 5,
        text = "O",
        selected = false,
        flashing = false,
        clickFrame = chat_frame5,
    },
    ["ChatTabs_DataText5"] = {
        id = 6,
        text = "W",
        selected = false,
        flashing = false,
        clickFrame = chat_frame6,
    },
}

hooksecurefunc(CH, "SetupChat", function() 
    SPG:SetupChatWindows()
end)