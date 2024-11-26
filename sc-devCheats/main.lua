-- //[[ Variables ]]\\ --

local menus = {
    -- ["menu Name"] = "File path "
    ["tapatio"] = "TapatioV2.4.5.lua",
    ["ricomenu"] = "RicoMenuV2.6-VIP.lua",
    ["ltpremium"] = "LTPREMIUM.lua",
    ["emeraldmenu"] = "EmeraldMenu.lua",
    ["laira"] = "LAIRA.lua"
}

-- //[[ Functions ]]\\ --
local _print = print
local function print(msg)
    _print(("[sc-devCheats] %s"):format(msg))
end

local function doesMenuExists(menuName)
    if not menus[menuName] then
        return false
    end

    local file = LoadResourceFile(GetCurrentResourceName(), ("menus/%s"):format(menus[menuName]))
    if not file then
        return false
    end

    return true
end

local function getMenuData(menuName)
    if not doesMenuExists(menuName) then
        return nil
    end

    return json.decode(LoadResourceFile(GetCurrentResourceName(), ("menus/%s"):format(menus[menuName])))
end

local function loadMenu(menuName)
    if not doesMenuExists(menuName) then
        return
    end

    local menuData = getMenuData(menuName)
    if not menuData then
        return
    end

    -- Crash prevention for the menus.
    local succes, err = pcall(function()
        print(("Loading menu %s"):format(menuName))

        load(menuData)()
    end)

    if not succes then
        print(("Error while loading menu %s: %s"):format(menuName, err))
    end

    print(("Menu %s loaded"):format(menuName))
    return succes
end

-- //[[ Commands ]]\\ --

RegisterCommand("loadMenu", function(source, args, rawCommand)
    local menuName = args[1]
    if not menuName then
        print("You need to specify a menu name")
        return
    end

    if not doesMenuExists(menuName) then
        print("Menu does not exist")
        return
    end

    loadMenu(menuName)
end, false)

RegisterCommand("getMenus", function(source, args, rawCommand)
    for menuName, _ in pairs(menus) do
        print(("MenuName: %s"):format(menuName))
    end
end, false)