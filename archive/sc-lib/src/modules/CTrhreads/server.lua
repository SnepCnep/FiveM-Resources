local cThreads = {}

function cThreads:addToLoop(name, func, time, resource)
    local res = resource or GetInvokingResource() or GetCurrentResourceName()
    if not name or not func or not time then
        error("Invalid arguments: name, func, and time are required")
        return
    end

    local codeNam = ("%s:%s"):format(res, name)
    if cThreads[codeNam] then
        error(("Thread with name '%s' already exists"):format(name))
        return
    end

    cThreads[codeNam] = {
        func = func,
        time = time,
        lastRun = GetGameTimer(),
        resource = res
    }
end

function cThreads:removeFromLoop(name, resource)
    local res = resource or GetInvokingResource() or GetCurrentResourceName()
    local codeNam = ("%s:%s"):format(res, name)

    if not cThreads[codeNam] then
        print(("Thread with name '%s' does not exist"):format(name))
        return
    end
    cThreads[codeNam] = nil
end

CreateThread(function()
    while true do
        local currentTime = GetGameTimer()
        for name, thread in pairs(cThreads) do
            if currentTime - thread.lastRun >= thread.time then
                local success, err = pcall(thread.func)
                if not success then
                    print(("Error in thread '%s': %s"):format(name, err))
                end
                thread.lastRun = currentTime
            end
        end
        Wait(0)
    end
end)

RegisterNetEvent("onResourceStop", function(res)
    for name, thread in pairs(cThreads) do
        if thread.resource == res then
            cThreads[name] = nil
        end
    end
end)

Core.Functions:RegisterModule("cThreads", cThreads, true)