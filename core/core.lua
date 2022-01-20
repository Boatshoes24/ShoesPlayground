local SPG, E, _, V, P, G = unpack(select(2, ...))

local _G = _G
local pairs, print, tinsert, strjoin, lower, next, wipe = pairs, print, table.insert, strjoin, strlower, next, wipe
local format = string.format
local GetAddOnMetadata = GetAddOnMetadata
local GetAddOnEnableState = GetAddOnEnableState
local DisableAddOn = DisableAddOn
local EnableAddOn = EnableAddOn
local GetAddOnInfo = GetAddOnInfo
local GetNumAddOns = GetNumAddOns
local ReloadUI = ReloadUI
local SetCVar = SetCVar

SPG.Version = GetAddOnMetadata("ShoesPlayground", "Version")

function SPG:IsAddOnEnabled(addon)
    return GetAddOnEnableState(SPG.MyName, addon) == 2
end

SPG.SLE = SPG:IsAddOnEnabled("ElvUI_SLE")
SPG.PA = SPG:IsAddOnEnabled("ProjectAzilroka")
SPG.AS = SPG:IsAddOnEnabled("AddOnSkins")

function SPG:Print(...)
    return (_G.DEFAULT_CHAT_FRAME):AddMessage(strjoin('', '|c', SPG.MyClassHexColor, 'ShoesPlayground|r: ', ...))
end

function SPG:SetupSPGUI()
    E:GetModule("PluginInstaller"):Queue(SPG.installTable)
end

function SPG:LoadCommands()
    self:RegisterChatCommand("spginstall", "SetupSPGUI")
end

function SPG:Initialize()
    self:LoadCommands()
    local spgDB = SPG.db.global

    if spgDB[E.mynameRealm] == nil then
        spgDB[E.mynameRealm] = {}
        self:SetupSPGUI()
    elseif spgDB[E.mynameRealm].install_complete ~= SPG.Version then
        self:SetupSPGUI()
    else
        self:Print("Already installed on this character.")
    end
end