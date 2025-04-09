-- 🔁 Auto-close old GUI if it exists
if game.CoreGui:FindFirstChild("LumberTycoonGui") then
    game.CoreGui.LumberTycoonGui:Destroy()
end

-- Lumber Tycoon GUI by Zanj1n

-- Services
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "LumberTycoonGui"

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 437, 0, 527)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- Topbar
local TopBar = Instance.new("Frame", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TopBar.BorderSizePixel = 0

-- Close Button
local Close = Instance.new("TextButton", TopBar)
Close.Size = UDim2.new(0, 30, 0, 30)
Close.Position = UDim2.new(1, -30, 0, 0)
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 255, 255)
Close.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Close.Font = Enum.Font.SourceSansBold
Close.TextScaled = true
Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Sidebar
local SideBar = Instance.new("Frame", MainFrame)
SideBar.Size = UDim2.new(0, 120, 1, -30)
SideBar.Position = UDim2.new(0, 0, 0, 30)
SideBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local CategoryList = Instance.new("UIListLayout", SideBar)
CategoryList.SortOrder = Enum.SortOrder.LayoutOrder
CategoryList.Padding = UDim.new(0, 5)

-- Content Area
local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, -120, 1, -30)
ContentFrame.Position = UDim2.new(0, 120, 0, 30)
ContentFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

local function clearContent()
    for _, child in ipairs(ContentFrame:GetChildren()) do
        if not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
end

local ContentList = Instance.new("UIListLayout", ContentFrame)
ContentList.SortOrder = Enum.SortOrder.LayoutOrder
ContentList.Padding = UDim.new(0, 5)

-- Add Category Function
local function addCategory(name, buttons, isCustom)
    local btn = Instance.new("TextButton", SideBar)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSans
    btn.TextScaled = true

    btn.MouseButton1Click:Connect(function()
        clearContent()

        if isCustom then
            isCustom()
            return
        end

        for i, data in ipairs(buttons) do
            local b = Instance.new("TextButton", ContentFrame)
            b.Size = UDim2.new(1, -10, 0, 30)
            b.Text = data.text
            b.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.Font = Enum.Font.SourceSans
            b.TextScaled = true
            b.MouseButton1Click:Connect(function()
                print(data.print)
            end)
        end
    end)
end

-- Auto Buy Dropdown + Quantity Slider UI
addCategory("Settings", nil, function()
    -- Dropdown
    local selectedItemName = "None"
    local selectedItemValue = "None"
    local items = {
        {name = "Basic Axe", value = "BasicHatchet"},
        {name = "Truck", value = "Vehicle"},
        {name = "Saw", value = "SawMill"},
        {name = "Conveyor", value = "Conveyor"},
        {name = "Land Deed", value = "LandDeed"},
    }

    local dropdown = Instance.new("TextButton", ContentFrame)
    dropdown.Size = UDim2.new(1, -10, 0, 30)
    dropdown.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    dropdown.Text = "Select Item"
    dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdown.TextScaled = true
    dropdown.Font = Enum.Font.SourceSans

    local itemFrame = Instance.new("Frame", dropdown)
    itemFrame.Size = UDim2.new(1, 0, 0, #items * 25)
    itemFrame.Position = UDim2.new(0, 0, 1, 0)
    itemFrame.Visible = false
    itemFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    itemFrame.BorderSizePixel = 0

    local list = Instance.new("UIListLayout", itemFrame)
    list.SortOrder = Enum.SortOrder.LayoutOrder

    for _, item in ipairs(items) do
        local option = Instance.new("TextButton", itemFrame)
        option.Size = UDim2.new(1, 0, 0, 25)
        option.Text = item.name
        option.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        option.TextColor3 = Color3.fromRGB(255, 255, 255)
        option.Font = Enum.Font.SourceSans
        option.TextScaled = true
        option.MouseButton1Click:Connect(function()
            selectedItemName = item.name
            selectedItemValue = item.value
            dropdown.Text = item.name
            itemFrame.Visible = false
        end)
    end

    dropdown.MouseButton1Click:Connect(function()
        itemFrame.Visible = not itemFrame.Visible
    end)

    -- Quantity Slider
    local quantity = 1
    local quantityLabel = Instance.new("TextLabel", ContentFrame)
    quantityLabel.Size = UDim2.new(1, -10, 0, 25)
    quantityLabel.Text = "Quantity: " .. quantity
    quantityLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    quantityLabel.BackgroundTransparency = 1
    quantityLabel.Font = Enum.Font.SourceSans
    quantityLabel.TextScaled = true

    local slider = Instance.new("TextButton", ContentFrame)
    slider.Size = UDim2.new(1, -10, 0, 25)
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    slider.Text = "Slide here"
    slider.TextColor3 = Color3.fromRGB(200, 200, 200)
    slider.TextScaled = true
    slider.Font = Enum.Font.SourceSans

    slider.MouseButton1Down:Connect(function()
        local conn
        conn = game:GetService("RunService").RenderStepped:Connect(function()
            local x = math.clamp(mouse.X - slider.AbsolutePosition.X, 0, slider.AbsoluteSize.X)
            quantity = math.floor((x / slider.AbsoluteSize.X) * 20) + 1
            quantityLabel.Text = "Quantity: " .. quantity
        end)
        mouse.Button1Up:Wait()
        conn:Disconnect()
    end)

    -- Buy Button
    local buy = Instance.new("TextButton", ContentFrame)
    buy.Size = UDim2.new(1, -10, 0, 30)
    buy.Text = "Buy"
    buy.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    buy.TextColor3 = Color3.fromRGB(255, 255, 255)
    buy.Font = Enum.Font.SourceSansBold
    buy.TextScaled = true
    buy.MouseButton1Click:Connect(function()
        print("Buying", quantity, selectedItemValue)
        -- insert buying logic here if you have one
    end)
end)

-- Other Categories
addCategory("Wood Tools", {
    {text = "Auto Chop", print = "Chopping trees..."},
    {text = "Teleport Logs", print = "Teleporting logs to base..."},
})

addCategory("Player Stuff", {
    {text = "Speed Boost", print = "Speed increased!"},
    {text = "Jump Power", print = "Jump power activated!"},
})

addCategory("Misc", {
    {text = "ESP Trees", print = "ESP on trees enabled"},
    {text = "Fly Mode", print = "Fly mode toggled"},
})
