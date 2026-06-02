-- [[ PPINGYYY HUB - FINAL COMPILED VERSION ]]
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local lp = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- ลบของเก่าก่อนรันใหม่
if CoreGui:FindFirstChild("ppingyyy_Hub") then CoreGui["ppingyyy_Hub"]:Destroy() end

local sg = Instance.new("ScreenGui", CoreGui)
sg.Name = "ppingyyy_Hub"

local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 200, 0, 300) -- ขยายขนาดให้พอใส่ปุ่มเพิ่ม
Main.Position = UDim2.new(0.05, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- ปุ่มปิด/ย่อ
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
    return btn
end

-- [หมวดตกปลา]
CreateBtn("🎣 Auto Cast: OFF", 40, function(btn) 
    getgenv().AutoCast = not getgenv().AutoCast
    btn.Text = getgenv().AutoCast and "🎣 Auto Cast: ON" or "🎣 Auto Cast: OFF"
    btn.BackgroundColor3 = getgenv().AutoCast and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(40, 40, 45)
    if getgenv().AutoCast then
        task.spawn(function() while getgenv().AutoCast do task.wait(1.5)
            pcall(function() if not lp.Character:GetAttribute("Fishing") then RS.Events.Fishing:FireServer() end end)
        end end)
    end
end)

CreateBtn("🎯 Auto Catch: OFF", 75, function(btn) 
    getgenv().AutoCatch = not getgenv().AutoCatch
    btn.Text = getgenv().AutoCatch and "🎯 Auto Catch: ON" or "🎯 Auto Catch: OFF"
    btn.BackgroundColor3 = getgenv().AutoCatch and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(40, 40, 45)
end)

-- [หมวดสกิล]
CreateBtn("✨ Random Skill: OFF", 110, function(btn) 
    getgenv().RandomSkill = not getgenv().RandomSkill
    btn.Text = getgenv().RandomSkill and "✨ Random Skill: ON" or "✨ Random Skill: OFF"
    if getgenv().RandomSkill then
        task.spawn(function() while getgenv().RandomSkill do task.wait(math.random(5,15)/10)
            local key = {"Z","X","C","V"}[math.random(1,4)]
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[key], false, game)
            task.wait(0.1)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode[key], false, game)
        end end)
    end
end)

-- [หมวด Utility]
CreateBtn("🚀 FLY GUI", 145, function() 
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FLY-GUI-V11-205450"))()
end)

CreateBtn("🧱 NOCLIP: OFF", 180, function(btn) 
    getgenv().Noclip = not getgenv().Noclip
    btn.Text = getgenv().Noclip and "🧱 NOCLIP: ON" or "🧱 NOCLIP: OFF"
end)

CreateBtn("💰 Sell All", 215, function() RS.Events.SellFish:FireServer("All") end)

-- [Logic เสริม]
RunService.RenderStepped:Connect(function()
    -- Noclip logic
    if getgenv().Noclip then
        for _,v in pairs(lp.Character:GetChildren()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
    -- Auto Catch logic
    if getgenv().AutoCatch then
        pcall(function()
            local fishingUI = lp.PlayerGui:FindFirstChild("MainGui") and lp.PlayerGui.MainGui:FindFirstChild("Fishing")
            if fishingUI and fishingUI.Visible then
                fishingUI.BarFrame.Bar.Position = UDim2.new(0.5, 0, fishingUI.BarFrame.Bar.Position.Y.Scale, 0)
                RS.Events.Fishing:FireServer("1")
            end
        end)
    end
end)

-- ระบบย่อหน้าจอ
MinBtn.MouseButton1Click:Connect(function()
    local isMin = Main.Size.Y.Offset < 50
    TweenService:Create(Main, TweenInfo.new(0.3), {Size = isMin and UDim2.new(0, 200, 0, 300) or UDim2.new(0, 200, 0, 40)}):Play()
    MinBtn.Text = isMin and "-" or "+"
end)

CloseBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

