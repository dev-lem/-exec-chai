-- exec-chai/src/Core.lua
-- Fast & stable execution engine

local Core = {}

function Core.new()
    local self = setmetatable({}, Core)
    return self
end

function Core:Execute(scriptText)
    if not scriptText or #scriptText < 2 then
        return false, "Empty script"
    end

    -- Create isolated environment
    local env = {
        game = game,
        script = script,
        workspace = workspace,
        Player = game:GetService("Players").LocalPlayer
    }
    setmetatable(env, { __index = _G })

    -- Load and execute
    local fn, err = loadstring(scriptText)
    if not fn then
        return false, "Compile error: "..tostring(err)
    end

    setfenv(fn, env)
    return pcall(fn)
end

return Core
