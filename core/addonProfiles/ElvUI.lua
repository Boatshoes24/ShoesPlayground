local SPG, E, L, V, P, G = unpack(select(2, ...))

function SPG:LoadElvUIProfile()
    local key = SPG.MyAddonProfileKey

    if ElvDB["profiles"][key] == nil then 
        if SPG.isInstallerRunning == false then
            SPG:Print(format(SPG.profileStrings[2], "ElvUI"))
        end
    else
        SPG:Print(format(SPG.profileStrings[1], "ElvUI"))
        ElvDB.profileKeys[E.mynameRealm] = key
    end

    if ElvPrivateDB["profiles"][key] == nil then 
        if SPG.isInstallerRunning == false then
            SPG:Print(format(SPG.profileStrings[2], "ElvUI Private"))
        end
    else
        SPG:Print(format(SPG.profileStrings[1], "ElvUI Private"))
        ElvPrivateDB.profileKeys[E.mynameRealm] = key
    end
end