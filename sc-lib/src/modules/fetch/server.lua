-- Credits: https://github.com/Arootsy/fivem-lua-fetch/blob/main/server/fetch.lua
local function fetch(url, ...)
    local retData = {};
    local p = promise.new();

    PerformHttpRequest(url, function (errorCode, resultData, resultHeaders)
        retData = {
            data = json.decode(resultData),
            headers = resultHeaders,
            status = errorCode
        };

        p:resolve(retData);
    end, ...);

    return Citizen.Await(p);
end;

Core.Functions:RegisterModule("fetch", fetch, true);