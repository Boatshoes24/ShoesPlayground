--my own rewrite of the ElvUI combat timer for personal preference

local SPG, E, L, V, P, G = unpack(select(2, ...))
local DT = E:GetModule('DataTexts')

local classHex = SPG.MyClassHexColor

local floor, format, strjoin = floor, format, strjoin
local GetInstanceInfo = GetInstanceInfo
local GetTime = GetTime

local timer, startTime, inEncounter = 0, 0

local function UpdateText(classColor)
    if classColor then
	    return format('|c%s%02d:%02d|r', classHex, floor(timer/60), timer % 60)
    else
        return format('|c%s%02d:%02d|r', 'ffffffff', floor(timer/60), timer % 60)
    end
end

local function OnUpdate(self)
	timer = GetTime() - startTime
	self.text:SetFormattedText('%s', UpdateText(true))
end

local function DelayOnUpdate(self, elapsed)
	startTime = startTime - elapsed
	if startTime <= 0 then
		timer, startTime = 0, GetTime()
		self:SetScript('OnUpdate', OnUpdate)
	end
end

local function OnEvent(self, event, _, timeSeconds)
	local _, instanceType = GetInstanceInfo()
	local inArena, started, ended = instanceType == 'arena', event == 'ENCOUNTER_START', event == 'ENCOUNTER_END'

	if inArena and event == 'START_TIMER' then
		timer, startTime = 0, timeSeconds
		self.text:SetFormattedText('%s', '00:00')
		self:SetScript('OnUpdate', DelayOnUpdate)
	elseif not inArena and ((not inEncounter and event == 'PLAYER_REGEN_ENABLED') or ended) then
		self:SetScript('OnUpdate', nil)
		if ended then inEncounter = nil end
        self.text:SetFormattedText('%s', UpdateText(false))
	elseif not inArena and (event == 'PLAYER_REGEN_DISABLED' or started) then
		timer, startTime = 0, GetTime()
		self:SetScript('OnUpdate', OnUpdate)
		if started then inEncounter = true end
	elseif not self.text:GetText() then
		self.text:SetFormattedText('%s', '00:00')
	end

end


DT:RegisterDatatext('SDT Combat Timer', 'Shoes', {'START_TIMER', 'ENCOUNTER_START', 'ENCOUNTER_END', 'PLAYER_REGEN_DISABLED', 'PLAYER_REGEN_ENABLED'}, OnEvent, nil, nil, nil, nil, nil, nil, nil)
