local SPG, E, L, V, P, G = unpack(select(2, ...))

function SPG:LoadRavenProfile()
    local key = SPG.MyAddonProfileKey

    LoadAddOn("Raven_Options")
    LoadAddOn("Raven")

    if RavenDB["profiles"][key] == nil then 
        if SPG.isInstallerRunning == false then
            SPG:Print(format(SPG.profileStrings[2], "Raven"))
        end
    else
        SPG:Print(format(SPG.profileStrings[1], "Raven"))
        Raven.db:SetProfile(key)
    end
end