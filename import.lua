local resourceName = GetCurrentResourceName()
local isServerSide = IsDuplicityVersion()
local isClientSide = not isServerSide

-- // [[ Load ServerSide Modules ]]\\ --
if isServerSide then
    (function()
        local success, err = pcall(function()
            local modules = exports["sc-core"]:GetModules()

            for name, module in pairs(modules) do
                if module.Prefix then
                    _G["sc." .. name] = module
                else
                    _G[name] = module
                end
            end
        end)

        if not success then
            print(("^1[Error]^0: Failed to load modules for resource %s: %s"):format(resourceName, err))
        else
            print(("^2[Success]^0: Modules loaded successfully for resource: %s"):format(resourceName))
        end
    end)();
end

if isClientSide then
    (function()
        local success, err = pcall(function()
            local modules = exports["sc-core"]:GetModules()

            for name, module in pairs(modules) do
                if module.Prefix then
                    _G["sc." .. name] = module
                else
                    _G[name] = module
                end
            end
        end)


        if not success then
            print(("^1[Error]^0: Failed to load modules for resource %s: %s"):format(resourceName, err))
        else
            print(("^2[Success]^0: Modules loaded successfully for resource: %s"):format(resourceName))
        end
    end)();
end
