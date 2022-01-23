local E, L, V, P, G = unpack(ElvUI)
local EP = LibStub("LibElvUIPlugin-1.0")
local addon, Engine = ...

local SPG = E.Libs.AceAddon:NewAddon(addon, "AceConsole-3.0", "AceEvent-3.0", "AceHook-3.0")

Engine[1] = SPG
Engine[2] = E
Engine[3] = L
Engine[4] = V
Engine[5] = P
Engine[6] = G
_G[addon] = Engine

local _G = _G
local select = select
local format, checkTable = format, next
local GetAddOnEnableState = GetAddOnEnableState
local RAID_CLASS_COLORS = RAID_CLASS_COLORS


SPG.Config = {}
SPG["RegisteredModules"] = {}
SPG.MyName = E.myname
SPG.MyClass = E.myLocalizedClass
SPG.MyClassHexColor = E:ClassColor(E.myclass, true).colorStr
SPG.InactiveHexColor = "ff3c3c3c"
SPG.ChatFrameHeight = 135
SPG.ChatFrameWidth = 351
SPG.Title = format("|c%sShoes Playground|r ", SPG.MyClassHexColor)
SPG.MyAddonProfileKey = "Shoes - 9.2"

SPG.DataTexts = SPG:NewModule("DataTexts", "AceEvent-3.0")

local defaults = {
    global = {
        dt = {
            time = {
                realm = false,
                railway = false
            },
            logs = {
                [8] = { name = 'Dungeon (M+)', value = false },
                [14] = { name = 'Raid (Normal)', value = true },
                [15] = { name = 'Raid (Heroic)', value = true },
                [16] = { name = 'Raid (Mythic)', value = true },
                [17] = { name = 'Raid (LFR)', value = false },
            }
        }
    },
}

function SPG:RegisterModule(name)
    if self.initialized then
        local mod = self:GetModule(name)
        if (mod and mod.initialize) then
            mod:Initialize()
        end
    else
        self["RegisteredModules"][#self["RegisteredModules"] + 1] = name
    end
end

function SPG:InitializeModules()
    for _, moduleName in pairs(SPG["RegisteredModules"]) do
        local mod = self:GetModule(moduleName)
        if mod.Initialize then
            mod:Initialize()
        else
            SPG:Print("Module <"..moduleName.."> is not loaded.")
        end
    end
end

function SPG:AddOptions()
    self:Print(checkTable(SPG.Config))
    for _, func in pairs(SPG.Config) do
        func()
    end
end

function SPG:Init()
    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
        E:Delay(2, function() E:StaticPopup_Show("SPG_CLASSIC") end)
        return
    end

    self.db = LibStub('AceDB-3.0'):New('ShoesPlaygroundDB', defaults, true)
    self:RegisterEvent("PLAYER_ENTERING_WORLD")

    self.initialized = true
    self:Initialize()
    -- self:InitializeModules()
    -- EP:RegisterPlugin(addon, self.AddOptions)
end

E.Libs.EP:HookInitialize(SPG, SPG.Init)

E.PopupDialogs["SPG_CLASSIC"] = {
    button1 = CLOSE,
    OnAccept = E.noop,
    text = (format("|cffff0000Error:|r Classic WoW is not currently supported for |c%sShoesPlayground|r", SPG.MyClassHexColor)),
    timeout = 0,
    whileDead = 1,
    hideOnExcape = false,
}
