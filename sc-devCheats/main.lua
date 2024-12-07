-- //[[ Variabelen ]]\\ --

local menus = {
    -- ["menu Naam"] = "Bestandspad"
    ["tapatio"] = "Tapatio.lua",
    ["ricomenu"] = "RicoMenu.lua",
    ["ltpremium"] = "LTPREMIUM.lua",
    ["emeraldmenu"] = "EmeraldMenu.lua",
    ["laira"] = "LAIRA.lua",
    ["skidmenu"] = "skidmenu.lua",
}

-- //[[ Functies ]]\\ --
local _print = print
local function print(msg)
    _print(("[sc-devCheats] %s"):format(msg))
end

local function doesMenuExists(menuName)
    if not menus[menuName] then
        print(("Menu '%s' bestaat niet in de tabel."):format(menuName))
        return false
    end
    
    local FilePath = ("menus/%s"):format(menus[menuName])
    local file = LoadResourceFile(GetCurrentResourceName(), FilePath)
    if not file then
        print(("Bestand niet gevonden: %s"):format(FilePath))
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

    if not file then
        print(("Fout bij het laden van bestand: %s"):format(FilePath))
        return nil
    end

    return file
end

local function loadMenu(menuName)
    -- Controleer of het menu bestaat
    if not doesMenuExists(menuName) then
        print(("Menu '%s' bestaat niet."):format(menuName))
        return false
    end

    -- Verkrijg de menugegevens
    local menuData = getMenuData(menuName)
    if not menuData then
        print(("Kon gegevens van menu '%s' niet laden."):format(menuName))
        return false
    end

    -- Probeer het menu te laden
    local load_func, load_err = load(menuData)
    if not load_func then
        print(("Fout bij het laden van menu '%s': %s"):format(menuName, load_err))
        return false
    end

    -- Probeer de geladen functie uit te voeren
    local success, exec_err = pcall(load_func)
    if not success then
        print(("Fout bij de uitvoering van menu '%s'"):format(menuName))
        return false
    end

    -- Menu is succesvol geladen en uitgevoerd
    print(("Menu '%s' succesvol geladen en uitgevoerd!"):format(menuName))
    return true
end

-- //[[ Commando's ]]\\ --

RegisterCommand("loadMenu", function(source, args, rawCommand)
    local menuName = args[1]
    if not menuName then
        print("Je moet een menu naam specificeren.")
        return
    end

    print(("Probeer menu '%s' te laden..."):format(menuName))
    local success = loadMenu(menuName)
    if not success then
        print(("Menu '%s' kon niet geladen worden. Controleer fouten hierboven."):format(menuName))
    end
end, false)

RegisterCommand("getMenus", function(source, args, rawCommand)
    print("Beschikbare menu's:")
    for menuName, _ in pairs(menus) do
        print((" - %s"):format(menuName))
    end
end, false)
