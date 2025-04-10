local player = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "NoclipGUI"

local textLabel = Instance.new("TextLabel", gui)
textLabel.Size = UDim2.new(1, 0, 0.1, 0)
textLabel.Position = UDim2.new(0, 0, 0.45, 0)
textLabel.Text = "Наш телеграм канал: https://t.me/cheats_robl0x"
textLabel.TextScaled = true
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.BackgroundTransparency = 1

local colors = {Color3.new(1, 0, 0), Color3.new(1, 1, 0), Color3.new(0, 1, 0), Color3.new(0, 1, 1), Color3.new(0, 0, 1), Color3.new(1, 0, 1)}
local colorIndex = 1

local function rainbowText()
    while true do
        textLabel.TextColor3 = colors[colorIndex]
        colorIndex = colorIndex + 1
        if colorIndex > #colors then
            colorIndex = 1
        end
        wait(0.5)
    end
end

coroutine.wrap(rainbowText)()

wait(3)
textLabel:Destroy()

local noclipButton = Instance.new("TextButton", gui)
noclipButton.Size = UDim2.new(0.1, 0, 0.1, 0)
noclipButton.Position = UDim2.new(0.45, 0, 0.8, 0)
noclipButton.Text = "NOCLIP"
noclipButton.TextScaled = true
noclipButton.BackgroundColor3 = Color3.new(1, 0, 0)

local dragging = false
local dragInput, dragStart, startPos

noclipButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = noclipButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

noclipButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        noclipButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local noclip = false
local characterParts = {}

local function updateCollision()
    if player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not noclip
            end
        end
    end
end

noclipButton.MouseButton1Click:Connect(function()
    noclip = not noclip
    if noclip then
        noclipButton.BackgroundColor3 = Color3.new(0, 1, 0)
    else
        noclipButton.BackgroundColor3 = Color3.new(1, 0, 0)
    end
    updateCollision()
end)

player.CharacterAdded:Connect(function(character)
    if not noclip then
        updateCollision()
    end
end)
