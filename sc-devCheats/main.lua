-- //[[ Variables ]]\\ --

local menus = {
    -- ["menu Name"] = "File path "
    ["tapatio"] = "Tapatio.lua",
    ["ricomenu"] = "RicoMenu.lua",
    ["ltpremium"] = "LTPREMIUM.lua",
    ["emeraldmenu"] = "EmeraldMenu.lua",
    ["laira"] = "LAIRA.lua",
    ["skidmenu"] = "skidmenu.lua",
    ["fallout"] = "falloutmenu.lua",
    ["ZMmenu"] = "ZM_Menu.lua",
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
    
    local FilePath = ("menus/%s"):format(menus[menuName])
    local file = LoadResourceFile(GetCurrentResourceName(), FilePath)
    if not file then
        return false
    end

    return true
end

local function getMenuData(menuName)
    if not doesMenuExists(menuName) then
        return nil
    end

    local FilePath = ("menus/%s"):format(menus[menuName])
    local file = LoadResourceFile(GetCurrentResourceName(), FilePath)

    return file
end

local function loadMenu(menuName)
    if not doesMenuExists(menuName) then
        print("Menu does not exist")
        return
    end

    local menuData = getMenuData(menuName)
    if not menuData then
        print("Error while loading menu data")
        return
    end

    -- Crash prevention for the menus.
    local success, err = pcall(function()
        print(("Loading menu %s"):format(menuName))

        local func, err = load(menuData)
        if not func then
            error(("Failed to load menu: %s"):format(err))
        end
        func()
    end)

    if not success then
        print(("Error while loading menu %s: %s"):format(menuName, err))
    end

    print(("Menu %s loaded"):format(menuName))
    return success
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

    print(("Loading menu %s"):format(menuName))
    loadMenu(menuName)
end, false)

RegisterCommand("getMenus", function(source, args, rawCommand)
    for menuName, _ in pairs(menus) do
        print(("MenuName: %s"):format(menuName))
    end
end, false)
