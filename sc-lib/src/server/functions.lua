---@class Functions
---@param name string
---@param func function | table
---@param prefix boolean
function Core.Functions:RegisterModule(name, func, prefix)
    assert(type(name) == "string", "Name must be a string")

    if Core.Modules[name] then
        error(("Module with name %s already exists"):format(name))
    end

    Core.Modules[name] = {
        ["Function"] = func,
        ["Prefix"] = prefix or false -- als standaard kan de functie zonder prefix worden aangeroepen.
    }
end