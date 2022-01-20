--Don't worry about this
local SPG, E, L, V, P, G = unpack(select(2, ...))

local format, checkTable = format, next
local tinsert, twipe, tsort, tconcat = table.insert, table.wipe, table.sort, table.concat
local _G = _G

local ReloadUI = ReloadUI
local ADDONS = ADDONS
local classHex = SPG.MyClassHexColor

-- addon profile installation
local addonNames = {}
local profilesFailed = format("|c%s|r didn't find any supported addons for profile installation", classHex)

SPG.isInstallerRunning = false

local function SetupAddons()
	SPG.isInstallerRunning = true

	if SPG:IsAddOnEnabled("BigWigs") then
		SPG:LoadBigWigsProfile()
		tinsert(addonNames, "BigWigs")
	end

	if SPG:IsAddOnEnabled("Raven") then
		SPG:LoadRavenProfile()
		tinsert(addonNames, "Raven")
	end

	if SPG:IsAddOnEnabled("SorhaQuestLog") then
		SPG:LoadSorhaQuestLogProfile()
		tinsert(addonNames, "SorhaQuestLog")
	end

	if SPG:IsAddOnEnabled("Details") then
		SPG:LoadDetailsProfile()
		tinsert(addonNames, "Details")
	end

	if SPG:IsAddOnEnabled("Plater") then
		SPG:LoadPlaterProfile()
		tinsert(addonNames, "Plater")
	end

	if SPG:IsAddOnEnabled("MRT") then
		SPG:LoadERTProfile()
		tinsert(addonNames, "ERT")
	end

	if SPG.PA then
		SPG:LoadPAProfile()
		tinsert(addonNames, "ProjectAzilroka")
	end

	SPG:LoadElvUIProfile()
	tinsert(addonNames, "ElvUI")
	tinsert(addonNames, "ElvUI Private")

	if checkTable(addonNames) ~= nil then
		local profileString = format("|c%sSuccessfully created and applied profile(s) for:|r\n", classHex)
		tsort(addonNames, function(a, b) return a < b end)
		local names = tconcat(addonNames, ", ")
		profileString = profileString..names

		PluginInstallFrame.Desc4:SetText(profileString..".")
	else
		PluginInstallFrame.Desc4:SetText(profilesFailed)
	end

	PluginInstallStepComplete.message = "Addons Set"
	PluginInstallStepComplete:Show()
	twipe(addonNames)	
end

local function InstallComplete()
	local spgDB = SPG.db.global
	spgDB[E.mynameRealm].install_complete = SPG.Version
	ReloadUI()
end

SPG.installTable = {
	["Name"] = format("|c%sShoesPlayground|r", classHex),
	["Title"] = "|cff00ff00ShoesPlayground Installation|r",
	["tutorialImage"] = [[Interface\AddOns\ShoesPlayground\media\ShoesPlaygroundLogo.tga]],
	["Pages"] = {
		[1] = function()
			PluginInstallTutorialImage:Size(384, 96)
			PluginInstallTutorialImage:SetPoint("BOTTOM", 0, 100)
			PluginInstallTutorialImage2:SetTexture(nil)
			PluginInstallFrame.SubTitle:SetFormattedText("Welcome to Shoes Playground")
			PluginInstallFrame.Desc1:SetText("By pressing the Continue button, ShoesPlayground installation will start.")
			PluginInstallFrame.Desc2:SetText('')
			PluginInstallFrame.Desc3:SetText("Please press the Continue button to go to the next step.")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() InstallComplete() end)
			PluginInstallFrame.Option1:SetText("Skip Process")
		end,
		[2] = function()
			PluginInstallFrame.SubTitle:SetFormattedText("%s", ADDONS)
			PluginInstallFrame.Desc1:SetText("This step of the installation will apply will create and apply profiles for some addons.")
			PluginInstallFrame.Desc2:SetText("Please click the button below to setup your addons.")
			PluginInstallFrame.Desc3:SetText("Importance: |cffD3CF00Medium|r")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() SetupAddons() end)
			PluginInstallFrame.Option1:SetText("Setup Addons")
		end,
		[3] = function()
			PluginInstallFrame.SubTitle:SetText("Installation Complete")
			PluginInstallFrame.Desc1:SetText("Installation process is now completed.")
			PluginInstallFrame.Desc2:SetText("Please click the button below to save changes and ReloadUI")
			PluginInstallFrame.Option1:Show()
			PluginInstallFrame.Option1:SetScript("OnClick", function() InstallComplete() end)
			PluginInstallFrame.Option1:SetText("Finished")
			PluginInstallStepComplete.message = SPG.Title.."Installed"
			PluginInstallStepComplete:Show()
		end,
	},

	["StepTitles"] = {
		[1] = "Start",
		[2] = ADDONS,
		[3] = "Finish"
	},
	StepTitlesColor = {1, 1, 1},
	StepTitlesColorSelected = {0, 192/255, 250},
	StepTitleWidth = 200,
	StepTitleButtonWidth = 200,
	StepTitleTextJustification = "CENTER",
}
