SC["Bridge"] = {
    ["Framework"] = "unkown",
    ["Functions"] = {},
    ["SharedData"] = {}
}

-- //[[Detected Framework]]\\ --
(function()
    -- ESX legacy Detetcion
    local success,_ = pcall(function()
        if GetResourceState("es_extended") ~= "started" then  
            error("ESX is not started.")
        end
        local ESX = exports['es_extended']:getSharedObject()
        SC.Bridge.Framework = "esx"
        SC.Bridge.SharedData = ESX
    end)

    if success then
        return print("[SC-DynamicProps] ESX legacy Detected.")
    end

    -- QB Core Detection (Not Support Right Now)
    local success,_ = pcall(function()
        if GetResourceState("qb-core") ~= "started" then
            error("QB-Core is not started.")
        end
        local QBCore = exports['qb-core']:GetCoreObject()
        SC.Bridge.Framework = "qb-core"
        SC.Bridge.SharedData = QBCore
    end)

    if success then
        return print("[SC-DynamicProps] QB-Core Detected.")
    end
    print("[SC-DynamicProps] No Framework Detected.")
end)()


-- //[[Shared Functions]]\\ --
