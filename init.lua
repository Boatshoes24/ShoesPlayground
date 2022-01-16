local ADDON, ns = ...
local Addon = LibStub('AceAddon-3.0'):NewAddon(ADDON, 'AceEvent-3.0')

local _G = _G
local select = select

local UnitClass = UnitClass
local UnitName = UnitName
local RAID_CLASS_COLORS = RAID_CLASS_COLORS


ns.Addon = Addon
ns.MyClass = select(2, UnitClass('player'))
ns.MyName = UnitName('player')
ns.MyClassHexColor = RAID_CLASS_COLORS[ns.MyClass]:GenerateHexColor()

_G[ADDON] = ns

local defaults = {
    global = {
        dt = {
            time = {
                realm = false,
                railway = false
            }
        }
    },
}

function Addon:OnInitialize()
    self.db = LibStub('AceDB-3.0'):New('ShoesPlaygroundDB', defaults, true)
end
