---@class Functions
---@param name string
---@param func function
---@param prefix boolean
function Core.Functions:RegisterModule(name, func, prefix)
    assert(type(name) == "string", "Name must be a string")
    assert(type(func) == "function", "Function must be a function")

    Core.Modules[name] = {
        ["Function"] = func,
        ["Prefix"] = prefix or false -- als standaard kan de functie zonder prefix worden aangeroepen.
    }
end


