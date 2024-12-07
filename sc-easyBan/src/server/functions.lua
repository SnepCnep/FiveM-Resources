-- //[[ LOCAL FUNCTIONS ]]// --

local function doesFileExist(filePath)
    local file = LoadResourceFile(GetCurrentResourceName(), ("src/data/%s"):format(filePath))
    return file ~= nil
end

local function loadFile(filePath)
    assert(doesFileExist(filePath), ("%s does not exist"):format(filePath))

    local file = LoadResourceFile(GetCurrentResourceName(), ("src/data/%s"):format(filePath))
    return file
end

-- //[[ FUNCTIONS ]]// --

function SC.Functions:loadBans()
    local data = loadFile("bans.json")

    return json.decode(data)
end

SC.Functions.print = {
    info = function(msg)
        print(("\27[32m[sc-easyBan] %s\27[0m"):format(msg))
    end,
    error = function(msg)
        print(("\27[31m[sc-easyBan] %s\27[0m"):format(msg))
    end,
    debug = function(msg)
        if Config.Debug then
            print(("\27[34m[sc-easyBan] %s\27[0m"):format(msg))
        end
    end
}
