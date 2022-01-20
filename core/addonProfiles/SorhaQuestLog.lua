local SPG, E, L, V, P, G = unpack(select(2, ...))

function SPG:LoadSorhaQuestLogProfile()
    local key = SPG.MyAddonProfileKey

    LoadAddOn("SorhaQuestLog")

    if SorhaQuestLogDB["profiles"][key] == nil then 
        if SPG.isInstallerRunning == false then
            SPG:Print(format(SPG.profileStrings[2], "SorhaQuestLog"))
        end
    else
        SPG:Print(format(SPG.profileStrings[1], "SorhaQuestLog"))
        SorhaQuestLog.db:SetProfile(key)
    end
end