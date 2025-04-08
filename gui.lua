local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextButton = Instance.new("TextButton")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.BorderSizePixel = 2
Frame.Active = true
-- Remove default dragging
Frame.Draggable = false

-- Custom dragging logic
local UserInputService = game:GetService("UserInputService")
local dragToggle = false
local dragInput
local dragStart
local startPos

local borderThreshold = 20 -- pixels from border where dragging is allowed

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mousePos = input.Position
        local framePos = Frame.AbsolutePosition
        local frameSize = Frame.AbsoluteSize
        
        -- Check if mouse is near borders
        if mousePos.X <= framePos.X + borderThreshold or
           mousePos.X >= framePos.X + frameSize.X - borderThreshold or
           mousePos.Y <= framePos.Y + borderThreshold or
           mousePos.Y >= framePos.Y + frameSize.Y - borderThreshold then
            dragToggle = true
            dragStart = input.Position
            startPos = Frame.Position
        end
    end
end)

Frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragToggle = false
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragToggle then
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(0, 162, 255)
TextButton.Position = UDim2.new(0.5, -50, 0.5, -25)
TextButton.Size = UDim2.new(0, 100, 0, 50)
TextButton.Font = Enum.Font.SourceSansBold
TextButton.Text = "Click Me!"
TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton.TextSize = 18

TextButton.MouseButton1Click:Connect(function()
    print("Button clicked!")
end)