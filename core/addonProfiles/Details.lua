local SPG, E, L, V, P, G = unpack(select(2, ...))

function SPG:LoadDetailsProfile()
    local key = SPG.MyAddonProfileKey

    LoadAddOn("Details")

    if _detalhes_global["__profiles"][key] == nil then
        if SPG.isInstallerRunning == false then
            SPG:Print(format(SPG.profileStrings[2], "Details"))
        end
    else
        SPG:Print(format(SPG.profileStrings[1], "Details"))
        _detalhes:ApplyProfile(key)
    end
end