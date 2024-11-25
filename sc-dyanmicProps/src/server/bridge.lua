SC["Bridge"] = {
    ["framework"] = "unkown",
    ["sharedData"] = {}
}

-- //[[Detected Framework]]\\ --
(function()
    -- ESX lecacy Detetcion
    local succes,_ = pcall(function()
        if GetResourceState("es_extended") ~= "started" then  
            error("ESX is not started.")
        end
        local ESX = exports['es_extended']:getSharedObject()
        SC.Bridge.framework = "esx"
        SC.Bridge.sharedData = ESX
    end)

    if succes then return end

    -- QB Core Detection (Not Support Right Now)
    local success,_ = pcall(function()
        if GetResourceState("qb-core") ~= "started" then
            error("QB-Core is not started.")
        end
        local QBCore = exports['qb-core']:GetCoreObject()
        SC.Bridge.framework = "qb-core"
        SC.Bridge.sharedData = QBCore
    end)

    if success then return end

    print("[SC-DynamicProps] No Framework Detected.")
end)()