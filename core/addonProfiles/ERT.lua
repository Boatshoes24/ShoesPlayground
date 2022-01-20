local SPG, E, L, V, P, G = unpack(select(2, ...))

local gsub = string.gsub

function SPG:LoadERTProfile()
    local key = SPG.MyAddonProfileKey

    LoadAddOn("MRT")

    if VMRT["Profiles"][key] == nil then 
        if SPG.isInstallerRunning == false then
            SPG:Print(format(SPG.profileStrings[2], "ERT"))
        end
    else
        SPG:Print(format(SPG.profileStrings[1], "ERT"))
        local stripName = gsub(E.mynameRealm, " ", "")
        VMRT.ProfileKeys[stripName] = key
    end
end