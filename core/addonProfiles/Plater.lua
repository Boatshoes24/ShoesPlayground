local SPG, E, L, V, P, G = unpack(select(2, ...))

function SPG:LoadPlaterProfile()
    local key = SPG.MyAddonProfileKey

    LoadAddOn("Plater")

    if PlaterDB["profiles"][key] == nil then 
        if SPG.isInstallerRunning == false then
            SPG:Print(format(SPG.profileStrings[2], "Plater"))
        end
    else
        SPG:Print(format(SPG.profileStrings[1], "Plater"))
        Plater.db:SetProfile(key)
    end
end