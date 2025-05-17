-- exec-chai/src/GUI.lua
-- Modern executor GUI

local GUI = {}
GUI.__index = GUI

function GUI.new(executor)
    local self = setmetatable({}, GUI)
    self.Executor = executor
    return self
end

function GUI:Inject()
    local Player = game:GetService("Players").LocalPlayer
    local UserInputService = game:GetService("UserInputService")

    -- Create UI
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ExecChaiGUI"
    ScreenGui.ResetOnSpawn = false

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Size = UDim2.new(1, 0, 0, 30)
    TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    TitleBar.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Text = "exec-chai"
    Title.Size = UDim2.new(1, 0, 1, 0)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.Parent = TitleBar

    -- Script Box
    local ScriptBox = Instance.new("TextBox")
    ScriptBox.Size = UDim2.new(1, -20, 1, -70)
    ScriptBox.Position = UDim2.new(0, 10, 0, 40)
    ScriptBox.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    ScriptBox.TextColor3 = Color3.new(1, 1, 1)
    ScriptBox.Font = Enum.Font.RobotoMono
    ScriptBox.TextSize = 14
    ScriptBox.TextXAlignment = Enum.TextXAlignment.Left
    ScriptBox.TextYAlignment = Enum.TextYAlignment.Top
    ScriptBox.MultiLine = true
    ScriptBox.ClearTextOnFocus = false
    ScriptBox.PlaceholderText = "Paste Lua script here..."
    ScriptBox.Parent = MainFrame

    -- Buttons
    local ExecuteBtn = Instance.new("TextButton")
    ExecuteBtn.Size = UDim2.new(0.48, 0, 0, 40)
    ExecuteBtn.Position = UDim2.new(0, 10, 1, -60)
    ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    ExecuteBtn.TextColor3 = Color3.new(1, 1, 1)
    ExecuteBtn.Text = "EXECUTE"
    ExecuteBtn.Font = Enum.Font.GothamMedium
    ExecuteBtn.TextSize = 16
    ExecuteBtn.Parent = MainFrame

    ExecuteBtn.MouseButton1Click:Connect(function()
        local success, err = self.Executor:Execute(ScriptBox.Text)
        if not success then
            warn(err)
        end
    end)

    -- Inject into player GUI
    ScreenGui.Parent = Player:WaitForChild("PlayerGui")
end

return GUI
