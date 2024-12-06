-- //[[ FUNCTIONS ]]\\ --
local function exports(exportName, exportFunc)
    assert(type(exportName) == "string", "exportName must be a string")
    assert(type(exportFunc) == "function", "exportFunc must be a function")

    AddEventHandler(('__cfx_export_%s_%s'):format(Config.resourceName, exportName), function(setCB)
        setCB(exportFunc)
    end)
end

-- //[[ EXPORTS ]]\\ --
exports("banPlayer", function(reason)
    local resource = (GetInvokingResource() or "unkown")

    TriggerServerEvent("sc-easyBan:banPlayer", reason, resource)
end)