local SPG, E, L, V, P, G = unpack(select(2, ...))

function SPG:LoadBigWigsProfile()
    local key = SPG.MyAddonProfileKey
    
    LoadAddOn("BigWigs_Options")
    LoadAddOn("BigWigs")

    if BigWigs3DB["profiles"][key] == nil then
        if SPG.isInstallerRunning == false then
            SPG:Print(format(SPG.profileStrings[2], "BigWigs"))
        end
    else
        SPG:Print(format(SPG.profileStrings[1], "BigWigs"))
        BigWigs.db:SetProfile(key)
    end
end