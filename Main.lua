-- exec-chai/main.lua
-- Main loader script for GitHub deployment

-- Configuration
local REPO_BASE = "https://raw.githubusercontent.com/dev-lem/-exec-chai/main/src/"
local LOAD_ORDER = {
    "Core.lua",
    "GUI.lua"
}

-- Load modules with error handling
local function LoadModule(moduleName)
    local url = REPO_BASE .. moduleName
    local success, result = pcall(function()
        return loadstring(game:HttpGet(url, true))()
    end)
    
    if not success then
        warn("[Exec-Chai] Failed to load "..moduleName..": "..tostring(result))
        return nil
    end
    return result
end

-- Initialize system
local function Main()
    -- Load dependencies
    local Core = LoadModule("Core.lua")
    if not Core then return end
    
    local GUI = LoadModule("GUI.lua")
    if not GUI then return end

    -- Initialize components
    local executor = Core.new()
    local interface = GUI.new(executor)

    -- Inject GUI
    local success, err = pcall(function()
        interface:Inject()
    end)
    
    if not success then
        warn("[Exec-Chai] Injection failed: "..tostring(err))
    end
end

-- Start the system with protection
local success, err = pcall(Main)
if not success then
    warn("[Exec-Chai] Critical error: "..tostring(err))
end

return "Exec-Chai loaded successfully"
