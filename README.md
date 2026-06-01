-- [[ ppingyyy Hub v2.9 - Instant Teleport Update ]]
-- เอาหน้า 4 กลับมาตามคำขอ! พร้อมระบบวาร์ปหายตัวแว๊บไปโผล่ที่เกาะทันที ไม่บินให้เสียเวลา!

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local MainGui = LocalPlayer.PlayerGui:WaitForChild("MainGui")

-- ลบ GUI ตัวเก่าออกก่อนรันตัวใหม่
if CoreGui:FindFirstChild("ppingyyy_MainHub") then
    CoreGui["ppingyyy_MainHub"]:Destroy()
end

-- สร้างหน้าต่าง ScreenGui
local sg = Instance.new("ScreenGui")
sg.Name = "ppingyyy_MainHub"
sg.ResetOnSpawn = false
sg.Parent = CoreGui

-- ====================================================================
-- [1. หน้าต่างหลัก (Main Frame)]
-- ====================================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 410, 0, 260) -- ปรับขนาดกว้างขึ้นเล็กน้อยเพื่อความสวยงาม
MainFrame.Position = UDim2.new(0.1, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = sg

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(45, 45, 50)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.5, 0, 0, 45)
Title.Position = UDim2.new(0.04, 0, 0, 0)
Title.Text = "★ PPINGYYY HUB v2.9"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0.92, 0, 0, 1)
Divider.Position = UDim2.new(0.04, 0, 0, 45)
Divider.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

-- แผงเมนูด้านซ้าย (Sidebar) & ขวา (Pages)
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(0, 130, 1, -55)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundTransparency = 1
TabBar.Parent = MainFrame

local PagesArea = Instance.new("Frame")
PagesArea.Size = UDim2.new(1, -155, 1, -55)
PagesArea.Position = UDim2.new(0, 145, 0, 50)
PagesArea.BackgroundTransparency = 1
PagesArea.Parent = MainFrame

local Page1_Skills = Instance.new("ScrollingFrame")
Page1_Skills.Size = UDim2.new(1, 0, 1, 0)
Page1_Skills.BackgroundTransparency = 1; Page1_Skills.ScrollBarThickness = 0
Page1_Skills.Visible = true; Page1_Skills.Parent = PagesArea

local Page2_Fishing = Instance.new("ScrollingFrame")
Page2_Fishing.Size = UDim2.new(1, 0, 1, 0)
Page2_Fishing.BackgroundTransparency = 1; Page2_Fishing.ScrollBarThickness = 0
Page2_Fishing.Visible = false; Page2_Fishing.Parent = PagesArea

local Page3_Utils = Instance.new("ScrollingFrame")
Page3_Utils.Size = UDim2.new(1, 0, 1, 0)
Page3_Utils.BackgroundTransparency = 1; Page3_Utils.ScrollBarThickness = 0
Page3_Utils.Visible = false; Page3_Utils.Parent = PagesArea

local Page4_Teleport = Instance.new("ScrollingFrame")
Page4_Teleport.Size = UDim2.new(1, 0, 1, 0)
Page4_Teleport.BackgroundTransparency = 1; Page4_Teleport.ScrollBarThickness = 3
Page4_Teleport.CanvasSize = UDim2.new(0, 0, 0, 200); Page4_Teleport.Visible = false; Page4_Teleport.Parent = PagesArea

-- ====================================================================
-- [2. ระบบปุ่มย่อ [-] และ ปุ่มลบ [X]]
-- ====================================================================
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(0.82, 0, 0, 10)
MinBtn.Text = "[-]"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.Parent = MainFrame
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(0.9, 0, 0, 10)
CloseBtn.Text = "[X]"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = MainFrame
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        TabBar.Visible = false; PagesArea.Visible = false
        MainFrame.Size = UDim2.new(0, 410, 0, 45)
        MinBtn.Text = "[+]"
    else
        TabBar.Visible = true; PagesArea.Visible = true
        MainFrame.Size = UDim2.new(0, 410, 0, 260)
        MinBtn.Text = "[-]"
    end
end)

local ConfirmPanel = Instance.new("Frame")
ConfirmPanel.Size = UDim2.new(0.94, 0, 0.75, 0)
ConfirmPanel.Position = UDim2.new(0.03, 0, 0.2, 0)
ConfirmPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ConfirmPanel.Visible = false; ConfirmPanel.ZIndex = 10; ConfirmPanel.Parent = MainFrame
Instance.new("UICorner", ConfirmPanel).CornerRadius = UDim.new(0, 10)

local SureBtn = Instance.new("TextButton")
SureBtn.Size = UDim2.new(0.85, 0, 0, 40)
SureBtn.Position = UDim2.new(0.075, 0, 0, 30)
SureBtn.Text = "มึงแน่ใจใช่ไหมว่าจะลบ?"
SureBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SureBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
SureBtn.ZIndex = 11; SureBtn.Parent = ConfirmPanel
Instance.new("UICorner", SureBtn).CornerRadius = UDim.new(0, 8)

local ShutUpBtn = Instance.new("TextButton")
ShutUpBtn.Size = UDim2.new(0.85, 0, 0, 40)
ShutUpBtn.Position = UDim2.new(0.075, 0, 0, 90)
ShutUpBtn.Text = "ลบเลยหุบปาก"
ShutUpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ShutUpBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ShutUpBtn.ZIndex = 11; ShutUpBtn.Parent = ConfirmPanel
Instance.new("UICorner", ShutUpBtn).CornerRadius = UDim.new(0, 8)

local CancelBtn = Instance.new("TextButton")
CancelBtn.Size = UDim2.new(0.85, 0, 0, 30)
CancelBtn.Position = UDim2.new(0.0
