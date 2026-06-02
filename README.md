-- [[ PPINGYYY HUB - STABLE VERSION (OPTIMIZED HIDE) ]]
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("ppingyyy_Hub") then CoreGui["ppingyyy_Hub"]:Destroy() end

local sg = Instance.new("ScreenGui", CoreGui)
sg.Name = "ppingyyy_Hub"

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 200, 0, 300); Main.Position = UDim2.new(0.05, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25); Main.Active = true; Main.Draggable = true
Main.ClipsDescendants = true -- 👈 นี่คือหัวใจสำคัญ!
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- ปุ่มจัดการ (ทำให้อยู่ในตระกูล Main เพื่อให้มันหดไปพร้อมกัน)
local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0, 30, 0, 30); MinBtn.Position = UDim2.new(0.65, 0, 0, 5)
MinBtn.Text = "-"; MinBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45); MinBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", MinBtn)

local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 30, 0, 30); CloseBtn.Position = UDim2.new(0.82, 0, 0, 5)
CloseBtn.Text = "X"; CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0); CloseBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", CloseBtn)

-- ฟังก์ชันสร้างปุ่ม
local function CreateBtn(text, pos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.85, 0, 0, 30); btn.Position = UDim2.new(0.075, 0, 0, pos)
    btn.Text = text; btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45); btn.TextColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() callback(btn) end)
end

-- [ใส่ปุ่มตามปกติ...]
CreateBtn("🎣 Auto Cast: OFF", 40, function(btn) -- ใส่ Logic เดิมมึงที่นี่ได้เลย
    getgenv().AutoCast = not getgenv().AutoCast
    btn.Text = getgenv().AutoCast and "🎣 Auto Cast: ON" or "🎣 Auto Cast: OFF"
end)
CreateBtn("🎯 Auto Catch: OFF", 75, function(btn) end)
CreateBtn("✨ Random Skill: OFF", 110, function(btn) end)
CreateBtn("🧱 NOCLIP: OFF", 145, function(btn) end)
CreateBtn("💰 Sell All", 180, function() end)

-- [ระบบอนิเมชั่นหดหน้าต่าง]
MinBtn.MouseButton1Click:Connect(function()
    local isMin = Main.Size.Y.Offset < 50
    local targetSize = isMin and UDim2.new(0, 200, 0, 300) or UDim2.new(0, 200, 0, 40)
    
    -- หดหน้าต่าง + ปรับความโปร่งใสของลูกๆ ทุกตัว
    TweenService:Create(Main, TweenInfo.new(0.3), {Size = targetSize}):Play()
    
    for _, child in pairs(Main:GetChildren()) do
        if child:IsA("TextButton") and child ~= MinBtn and child ~= CloseBtn then
            TweenService:Create(child, TweenInfo.new(0.2), {BackgroundTransparency = isMin and 0 or 1, TextTransparency = isMin and 0 or 1}):Play()
        end
    end
end)

CloseBtn.MouseButton1Click:Connect(function() sg:Destroy() end)
