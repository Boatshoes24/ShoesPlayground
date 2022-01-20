local SPG, E, L, V, P, G = unpack(select(2, ...))

function SPG:LoadPAProfile()
    local PA = _G.ProjectAzilroka
    local key = SPG.MyAddonProfileKey

    if ProjectAzilrokaDB["profiles"][key] == nil then 
        if SPG.isInstallerRunning == false then
            SPG:Print(format(SPG.profileStrings[2], "ProjectAzilroka"))
        end
    else
        SPG:Print(format(SPG.profileStrings[1], "ProjectAzilroka"))
        PA.data:SetProfile(key)
    end
end