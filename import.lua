local isServerSide = IsDuplicityVersion()

if isServerSide then
    local function loadModules()
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
            print("^1[Error]^0: Failed to load modules: " .. err)
        else
            print("^2[Success]^0: Modules loaded successfully.")
        end
    end

    loadModules()
end
