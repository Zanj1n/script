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
MainFrame.Size = UDim2.new(0, 500, 0, 300)
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
local function addCategory(name, buttons)
	local btn = Instance.new("TextButton", SideBar)
	btn.Size = UDim2.new(1, -10, 0, 30)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	btn.TextColor3 = Color3.fromRGB(255, 255, 255)
	btn.Font = Enum.Font.SourceSans
	btn.TextScaled = true

	btn.MouseButton1Click:Connect(function()
		clearContent()
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

-- Categories
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
