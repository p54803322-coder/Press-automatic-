-- [[ ppingyyy Hub v3.2 - Anti-Crash & Clean Execution Edition ]]
-- อัปเดตแก้ไข: อุดทุกจุดเสี่ยงค้าง, ปรับโครงสร้างระบบเช็กค่า, การันตีรันผ่าน 100% ไม่ขาดซักบรรทัด

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")

-- ป้องกันสคริปต์ค้างตอนเริ่มรัน ถ้าหน้าต่างเกม (MainGui) ยังไม่ขึ้น
local MainGui = nil
pcall(function()
    MainGui = LocalPlayer:WaitForChild("PlayerGui", 5):WaitForChild("MainGui", 5)
end)

-- ระบบลบ UI เก่าแบบปลอดภัย (Safe Destroy) ป้องกัน Executor บนมือถือค้าง
pcall(function()
    if CoreGui:FindFirstChild("ppingyyy_MainHub") then
        CoreGui["ppingyyy_MainHub"]:Destroy()
    end
end)

local sg = Instance.new("ScreenGui")
sg.Name = "ppingyyy_MainHub"
sg.ResetOnSpawn = false
pcall(function()
    sg.Parent = CoreGui
end)
if not sg.Parent then 
    sg.Parent = LocalPlayer:WaitForChild("PlayerGui") -- เผื่อไว้ถ้าเข้าถึง CoreGui ไม่ได้
end

-- อ็อบเจกต์เสียงเอฟเฟกต์เด้งดึ๋ง
local ClickSound = Instance.new("Sound")
ClickSound.SoundId = "rbxassetid://6895079853"
ClickSound.Volume = 0.5
ClickSound.Parent = sg

-- ====================================================================
-- [1. Main Frame & UI Setup]
-- ====================================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 270)
MainFrame.Position = UDim2.new(0.1, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
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
Title.Text = "★ PPINGYYY HUB v3.2"
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

local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, 0, 1, 0)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = PagesArea

local Page1_Skills = Instance.new("ScrollingFrame")
Page1_Skills.Size = UDim2.new(1, 0, 1, 0)
Page1_Skills.BackgroundTransparency = 1; Page1_Skills.ScrollBarThickness = 3
Page1_Skills.CanvasSize = UDim2.new(0, 0, 0, 180); Page1_Skills.Visible = true; Page1_Skills.Parent = PageContainer

local Page2_Fishing = Instance.new("ScrollingFrame")
Page2_Fishing.Size = UDim2.new(1, 0, 1, 0)
Page2_Fishing.BackgroundTransparency = 1; Page2_Fishing.ScrollBarThickness = 0
Page2_Fishing.Visible = false; Page2_Fishing.Parent = PageContainer

local Page3_Utils = Instance.new("ScrollingFrame")
Page3_Utils.Size = UDim2.new(1, 0, 1, 0)
Page3_Utils.BackgroundTransparency = 1; Page3_Utils.ScrollBarThickness = 3
Page3_Utils.CanvasSize = UDim2.new(0, 0, 0, 180); Page3_Utils.Visible = false; Page3_Utils.Parent = PageContainer

local Page4_Emergency = Instance.new("ScrollingFrame")
Page4_Emergency.Size = UDim2.new(1, 0, 1, 0)
Page4_Emergency.BackgroundTransparency = 1; Page4_Emergency.ScrollBarThickness = 3
Page4_Emergency.CanvasSize = UDim2.new(0, 0, 0, 260); Page4_Emergency.Visible = false; Page4_Emergency.Parent = PageContainer

-- ปุ่มย่อหน้าจอ / ปุ่มปิดเมนู
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 25, 0, 25); MinBtn.Position = UDim2.new(0.82, 0, 0, 10)
MinBtn.Text = "[-]"; MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255); MinBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MinBtn.Font = Enum.Font.GothamBold; MinBtn.Parent = MainFrame; Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25); CloseBtn.Position = UDim2.new(0.9, 0, 0, 10)
CloseBtn.Text = "[X]"; CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255); CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.Parent = MainFrame; Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- แอนิเมชันย่อ/ขยายแบบเซฟตี้สูงสุด ไม่ใช้ CanvasGroup เพื่อกันระบบค้าง
local isMinimized = false
local tweenInfoUI = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    pcall(function() ClickSound:Play() end)
    
    if isMinimized then
        MinBtn.Text = "[+]"
        TweenService:Create(MainFrame, tweenInfoUI, {Size = UDim2.new(0, 420, 0, 45)}):Play()
        PageContainer.Visible = false
        TabBar.Visible = false
    else
        MinBtn.Text = "[-]"
        TweenService:Create(MainFrame, tweenInfoUI, {Size = UDim2.new(0, 420, 0, 270)}):Play()
        PageContainer.Visible = true
        TabBar.Visible = true
    end
end)

-- หน้าต่างยืนยันการลบเมนูหลัก [X]
local ConfirmPanel = Instance.new("Frame")
ConfirmPanel.Size = UDim2.new(0.94, 0, 0.75, 0); ConfirmPanel.Position = UDim2.new(0.03, 0, 0.2, 0)
ConfirmPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25); ConfirmPanel.Visible = false; ConfirmPanel.ZIndex = 10; ConfirmPanel.Parent = MainFrame
Instance.new("UICorner", ConfirmPanel).CornerRadius = UDim.new(0, 10)

local SureBtn = Instance.new("TextButton")
SureBtn.Size = UDim2.new(0.85, 0, 0, 40); SureBtn.Position = UDim2.new(0.075, 0, 0, 30); SureBtn.Text = "มึงแน่ใจใช่ไหมว่าจะลบ?"
SureBtn.TextColor3 = Color3.fromRGB(255, 255, 255); SureBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0); SureBtn.ZIndex = 11; SureBtn.Parent = ConfirmPanel
Instance.new("UICorner", SureBtn).CornerRadius = UDim.new(0, 8)

local ShutUpBtn = Instance.new("TextButton")
ShutUpBtn.Size = UDim2.new(0.85, 0, 0, 40); ShutUpBtn.Position = UDim2.new(0.075, 0, 0, 90); ShutUpBtn.Text = "ลบเลยหุบปาก"
ShutUpBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ShutUpBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0); ShutUpBtn.ZIndex = 11; ShutUpBtn.Parent = ConfirmPanel
Instance.new("UICorner", ShutUpBtn).CornerRadius = UDim.new(0, 8)

local CancelBtn = Instance.new("TextButton")
CancelBtn.Size = UDim2.new(0.85, 0, 0, 30); CancelBtn.Position = UDim2.new(0.075, 0, 0, 145); CancelBtn.Text = "เปลี่ยนใจไม่ลบละ"
CancelBtn.TextColor3 = Color3.fromRGB(150, 150, 150); CancelBtn.BackgroundTransparency = 1; CancelBtn.ZIndex = 11; CancelBtn.Parent = ConfirmPanel

CloseBtn.MouseButton1Click:Connect(function() ConfirmPanel.Visible = true; pcall(function() ClickSound:Play() end) end)
CancelBtn.MouseButton1Click:Connect(function() ConfirmPanel.Visible = false; pcall(function() ClickSound:Play() end) end)
SureBtn.MouseButton1Click:Connect(function() sg:Destroy() end)
ShutUpBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

-- ฟังก์ชันสร้างปุ่มหมวดหมู่ + แอนิเมชันขยายตัวดึ๋งๆ ตอนเมาส์ชี้
local function CreateTabButton(name, posY, targetPage)
    local TBtn = Instance.new("TextButton")
    TBtn.Size = UDim2.new(1, 0, 0, 30)
    TBtn.Position = UDim2.new(0, 0, 0, posY)
    TBtn.Text = name
    TBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    TBtn.Font = Enum.Font.GothamBold
    TBtn.TextSize = 10
    TBtn.Parent = TabBar
    Instance.new("UICorner", TBtn).CornerRadius = UDim.new(0, 6)

    local tweenInfoTab = TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

    TBtn.MouseEnter:Connect(function()
        pcall(function() ClickSound:Play() end)
        TweenService:Create(TBtn, tweenInfoTab, {
            Size = UDim2.new(1, 8, 0, 34),
            Position = UDim2.new(0, -4, 0, posY - 2)
        }):Play()
    end)

    TBtn.MouseLeave:Connect(function()
        TweenService:Create(TBtn, tweenInfoTab, {
            Size = UDim2.new(1, 0, 0, 30),
            Position = UDim2.new(0, 0, 0, posY)
        }):Play()
    end)

    TBtn.MouseButton1Click:Connect(function()
        pcall(function() ClickSound:Play() end)
        Page1_Skills.Visible = false; Page2_Fishing.Visible = false; Page3_Utils.Visible = false; Page4_Emergency.Visible = false
        targetPage.Visible = true
        for _, v in pairs(TabBar:GetChildren()) do 
            if v:IsA("TextButton") then v.BackgroundColor3 = Color3.fromRGB(25, 25, 30) end 
        end
        TBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    end)
end

CreateTabButton("⚔️ ออโต้สกิล", 5, Page1_Skills)
CreateTabButton("🎣 ออโต้ตกปลา", 38, Page2_Fishing)
CreateTabButton("🛠️ อำนวยความสะดวก", 71, Page3_Utils)
CreateTabButton("🚨 โหมดวาร์ปฉุกเฉิน", 104, Page4_Emergency)

-- ====================================================================
-- [2. ระบบ Backend ทำงานหลังบ้าน - ปลอดภัยไม่ทำเกมค้าง]
-- ====================================================================
local SkillStates = { Z = false, X = false, C = false, V = false }
getgenv().PPINGYYY_AutoCast = false 
getgenv().PPINGYYY_Anchor = false   
local ClimbWallEnabled = false
local NoclipEnabled = false

local function PressKey(keyStr)
    local keyCode = Enum.KeyCode[keyStr]
    if keyCode then
        pcall(function()
            VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
            task.wait(0.02)
            VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
        end)
    end
end

-- ลูปคุมออโต้สกิล
task.spawn(function()
    while true do
        task.wait(0.25)
        if SkillStates["V"] then PressKey("V") task.wait(0.3) end
        local activeSkills = {}
        for key, isEnabled in pairs(SkillStates) do 
            if isEnabled and key ~= "V" then table.insert(activeSkills, key) end 
        end
        if #activeSkills > 0 then
            PressKey(activeSkills[math.random(1, #activeSkills)])
            task.wait(0.3)
        end
    end
end)

-- ออโต้เหวี่ยงเบ็ด
task.spawn(function()
    while true do
        task.wait(0.5) 
        if getgenv().PPINGYYY_AutoCast then
            pcall(function()
                local char = LocalPlayer.Character
                if char and MainGui then
                    -- ครอบ pcall ดักอาการค้างตอนตัวละครสปอนใหม่หรือตาย
                    local isFishing = char:GetAttribute("Fishing")
                    local fishUI = MainGui:FindFirstChild("Fishing")
                    if not isFishing and (fishUI and not fishUI.Visible) then
                        ReplicatedStorage.Events.Fishing:FireServer()
                    end
                end
            end)
        end
    end
end)

-- ล็อกเกจเขียวให้อยู่ตรงกลางเสมอ
RunService.RenderStepped:Connect(function()
    if getgenv().PPINGYYY_Anchor then
        pcall(function()
            if MainGui then
                local fishingUI = MainGui:FindFirstChild("Fishing")
                if fishingUI and fishingUI.Visible then
                    local barFrame = fishingUI:FindFirstChild("BarFrame")
                    if barFrame and barFrame:FindFirstChild("Bar") then
                        barFrame.Bar.Position = UDim2.new(0.5, 0, barFrame.Bar.Position.Y.Scale, 0)
                        if math.random(1, 3) == 1 then 
                            ReplicatedStorage.Fishing:FireServer("1") 
                        end
                    end
                end
            end
        end)
    end
end)

-- ฟิสิกส์คุมตัวละคร (ปีนกำแพง / Noclip)
RunService.Stepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local hrp = char.HumanoidRootPart

        if ClimbWallEnabled then
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {char}
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            local res = workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * 2.5, raycastParams)
            if res and res.Instance then hrp.Velocity = Vector3.new(hrp.Velocity.X, 45, hrp.Velocity.Z) end
        end

        if NoclipEnabled then
            for _, part in pairs(char:GetChildren()) do 
                if part:IsA("BasePart") then part.CanCollide = false end 
            end
        end
    end)
end)

-- ระบบ Smooth Teleport ขยับสั้นๆ แบบเนียนๆ กันเด้งหลุด
local function SmoothWarp(direction)
    pcall(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local warpDistance = 8
        local targetCFrame = hrp.CFrame

        if direction == "Up" then targetCFrame = hrp.CFrame * CFrame.new(0, 0, -warpDistance)
        elseif direction == "Down" then targetCFrame = hrp.CFrame * CFrame.new(0, 0, warpDistance)
        elseif direction == "Left" then targetCFrame = hrp.CFrame * CFrame.new(-warpDistance, 0, 0)
        elseif direction == "Right" then targetCFrame = hrp.CFrame * CFrame.new(warpDistance, 0, 0)
        elseif direction == "Jump" then targetCFrame = hrp.CFrame * CFrame.new(0, warpDistance, 0) end

        local steps = 3
        for i = 1, steps do
            hrp.CFrame = hrp.CFrame:Lerp(targetCFrame, i/steps)
            task.wait(0.01)
        end
    end)
end

-- ฟังก์ชันประมวลผลวาร์ปพิกัดเนียน
local function TeleportToCoordinates(inputString, UI_TextBox, UI_Button)
    pcall(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local coords = {}
        for num in string.gmatch(inputString, "[-?%d%.]+") do
            table.insert(coords, tonumber(num))
        end

        if #coords >= 3 then
            local targetPos = Vector3.new(coords[1], coords[2], coords[3])
            local startCFrame = hrp.CFrame
            local distance = (targetPos - hrp.Position).Magnitude
            
            local warpSpeed = 150 
            local duration = math.clamp(distance / warpSpeed, 0.2, 3.5)
            local startTime = tick()
            
            UI_Button.Text = "⏳..."
            UI_Button.BackgroundColor3 = Color3.fromRGB(240, 140, 20)

            while tick() - startTime < duration do
                local progress = (tick() - startTime) / duration
                if not hrp or not hrp.Parent then break end
                hrp.CFrame = CFrame.new(startCFrame.Position:Lerp(targetPos, progress)) * startCFrame.Rotation
                RunService.Heartbeat:Wait()
            end
            
            if hrp then hrp.CFrame = CFrame.new(targetPos) * startCFrame.Rotation end
            
            UI_TextBox.Text = ""
            UI_Button.Text = "✅ ถึงแล้ว!"
            UI_Button.BackgroundColor3 = Color3.fromRGB(0, 180, 50)
            task.wait(1.2)
            UI_Button.Text = "วาร์ป"
            UI_Button.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        else
            UI_Button.Text = "❌ มั่ว!"
            UI_Button.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
            task.wait(1.2)
            UI_Button.Text = "วาร์ป"
            UI_Button.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
        end
    end)
end

-- ====================================================================
-- [3. หน้าอินเตอร์เฟสปุ่มกดฟังก์ชันต่าง ๆ]
-- ====================================================================
local function CreateFunctionButton(name, posY, parentPage, toggleCallback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.93, 0, 0, 36); Btn.Position = UDim2.new(0, 0, 0, posY)
    Btn.Text = name .. " : OFF"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255); Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 11; Btn.Parent = parentPage
    local Stroke = Instance.new("UIStroke", Btn)
    Stroke.Color = Color3.fromRGB(55, 55, 60); Stroke.Thickness = 1.2
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

    Btn.MouseButton1Click:Connect(function()
        pcall(function() ClickSound:Play() end)
        local state = toggleCallback()
        if state then
            Btn.Text = name .. " : ON"
            Btn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
            Stroke.Color = Color3.fromRGB(220, 50, 50)
        else
            Btn.Text = name .. " : OFF"
            Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
            Stroke.Color = Color3.fromRGB(55, 55, 60)
        end
    end)
end

-- หน้าที่ 1: ออโต้สกิล
CreateFunctionButton("AUTO Z", 5, Page1_Skills, function() SkillStates.Z = not SkillStates.Z return SkillStates.Z end)
CreateFunctionButton("AUTO X", 46, Page1_Skills, function() SkillStates.X = not SkillStates.X return SkillStates.X end)
CreateFunctionButton("AUTO C", 87, Page1_Skills, function() SkillStates.C = not SkillStates.C return SkillStates.C end)
CreateFunctionButton("AUTO V", 128, Page1_Skills, function() SkillStates.V = not SkillStates.V return SkillStates.V end)

-- หน้าที่ 2: ออโต้ตกปลา
CreateFunctionButton("ตกปลาอัตโนมัติ (Auto Cast)", 5, Page2_Fishing, function() getgenv().PPINGYYY_AutoCast = not getgenv().PPINGYYY_AutoCast return getgenv().PPINGYYY_AutoCast end)
CreateFunctionButton("ล็อกเกจตรงกลาง (Auto Catch)", 46, Page2_Fishing, function() getgenv().PPINGYYY_Anchor = not getgenv().PPINGYYY_Anchor return getgenv().PPINGYYY_Anchor end)

local ManualSellBtn = Instance.new("TextButton")
ManualSellBtn.Size = UDim2.new(0.93, 0, 0, 36); ManualSellBtn.Position = UDim2.new(0, 0, 0, 87)
ManualSellBtn.Text = "💰 ขายปลาทั้งหมดทันที"; ManualSellBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ManualSellBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 85)
ManualSellBtn.Font = Enum.Font.GothamBold; ManualSellBtn.TextSize = 11; ManualSellBtn.Parent = Page2_Fishing
Instance.new("UICorner", ManualSellBtn).CornerRadius = UDim.new(0, 6)
ManualSellBtn.MouseButton1Click:Connect(function() pcall(function() ClickSound:Play() end); pcall(function() ReplicatedStorage.Events.SellFish:FireServer("All") end) end)

-- หน้าที่ 3: อำนวยความสะดวก
CreateFunctionButton("ปีนกำแพงอัตโนมัติ (Climb Wall)", 5, Page3_Utils, function() ClimbWallEnabled = not ClimbWallEnabled return ClimbWallEnabled end)
CreateFunctionButton("เดินทะลุกำแพงวัตถุ (Noclip)", 46, Page3_Utils, function() NoclipEnabled = not NoclipEnabled return NoclipEnabled end)

local FlyScriptBtn = Instance.new("TextButton")
FlyScriptBtn.Size = UDim2.new(0.93, 0, 0, 36); FlyScriptBtn.Position = UDim2.new(0, 0, 0, 87)
FlyScriptBtn.Text = "🚀 เปิดสคริปต์บิน FLY GUI V11"; FlyScriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255); FlyScriptBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 180)
FlyScriptBtn.Font = Enum.Font.GothamBold; FlyScriptBtn.TextSize = 11; FlyScriptBtn.Parent = Page3_Utils
Instance.new("UICorner", FlyScriptBtn).CornerRadius = UDim.new(0, 6)
FlyScriptBtn.MouseButton1Click:Connect(function() pcall(function() ClickSound:Play() end); loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FLY-GUI-V11-205450"))() end)

-- 📋 ปุ่มคัดลอ
