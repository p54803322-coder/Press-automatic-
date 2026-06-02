-- [[ ppingyyy Hub v3.2 - Smooth Animation Edition ]]
-- บันทึกการแก้ไข: เพิ่มระบบ TweenService คุมแอนิเมชันหด/ขยาย UI และแอนิเมชันปุ่มหมวดหมู่ตอนเมาส์ชี้พร้อมเสียงเด้งดึ๋ง

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService") -- เรียกใช้งานพระเอกของงานนี้

local MainGui = LocalPlayer.PlayerGui:WaitForChild("MainGui")

-- ลบ UI เก่าป้องกันการซ้อนทับ
if CoreGui:FindFirstChild("ppingyyy_MainHub") then
    CoreGui["ppingyyy_MainHub"]:Destroy()
end

local sg = Instance.new("ScreenGui")
sg.Name = "ppingyyy_MainHub"
sg.ResetOnSpawn = false
sg.Parent = CoreGui

-- สร้างอ็อบเจกต์เสียง (ถ้าไม่อยากได้เสียง ให้เปลี่ยน ID หรือปล่อยผ่านได้เลยไอ้ชาย)
local ClickSound = Instance.new("Sound")
ClickSound.SoundId = "rbxassetid://6895079853" -- เสียงกิ๊กๆ ตอนกด/ชี้
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
MainFrame.ClipsDescendants = true -- บังคับให้ไอเทมข้างในซ่อนตัวตอนหดขนาดหน้าต่าง
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

-- สร้าง CanvasGroup ช่วยให้ควบคุมกลุ่มความโปร่งใสตอนจางหายได้เนียนๆ
local ContentGroup = Instance.new("CanvasGroup")
ContentGroup.Size = UDim2.new(1, 0, 1, 0)
ContentGroup.BackgroundTransparency = 1
ContentGroup.Parent = PagesArea

local Page1_Skills = Instance.new("ScrollingFrame")
Page1_Skills.Size = UDim2.new(1, 0, 1, 0)
Page1_Skills.BackgroundTransparency = 1; Page1_Skills.ScrollBarThickness = 3
Page1_Skills.CanvasSize = UDim2.new(0, 0, 0, 180); Page1_Skills.Visible = true; Page1_Skills.Parent = ContentGroup

local Page2_Fishing = Instance.new("ScrollingFrame")
Page2_Fishing.Size = UDim2.new(1, 0, 1, 0)
Page2_Fishing.BackgroundTransparency = 1; Page2_Fishing.ScrollBarThickness = 0
Page2_Fishing.Visible = false; Page2_Fishing.Parent = ContentGroup

local Page3_Utils = Instance.new("ScrollingFrame")
Page3_Utils.Size = UDim2.new(1, 0, 1, 0)
Page3_Utils.BackgroundTransparency = 1; Page3_Utils.ScrollBarThickness = 3
Page3_Utils.CanvasSize = UDim2.new(0, 0, 0, 180); Page3_Utils.Visible = false; Page3_Utils.Parent = ContentGroup

local Page4_Emergency = Instance.new("ScrollingFrame")
Page4_Emergency.Size = UDim2.new(1, 0, 1, 0)
Page4_Emergency.BackgroundTransparency = 1; Page4_Emergency.ScrollBarThickness = 3
Page4_Emergency.CanvasSize = UDim2.new(0, 0, 0, 260); Page4_Emergency.Visible = false; Page4_Emergency.Parent = ContentGroup

-- ปุ่มย่อ / ปุ่มปิด
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 25, 0, 25); MinBtn.Position = UDim2.new(0.82, 0, 0, 10)
MinBtn.Text = "[-]"; MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255); MinBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MinBtn.Font = Enum.Font.GothamBold; MinBtn.Parent = MainFrame; Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25); CloseBtn.Position = UDim2.new(0.9, 0, 0, 10)
CloseBtn.Text = "[X]"; CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255); CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CloseBtn.Font = Enum.Font.GothamBold; CloseBtn.Parent = MainFrame; Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)

-- 🔥 [[ ระบบแอนิเมชันย่อ/ขยายหน้า GUI บานใหญ่แบบสมูท ]]
local isMinimized = false
local tweenInfoUI = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    ClickSound:Play() -- เล่นเสียงตอนกดปุ่มย่อหน้าจอ
    
    if isMinimized then
        MinBtn.Text = "[+]"
        -- ค่อยๆ หดขนาดความสูงลงมาเหลือ 45 และจางเนื้อหาให้หายไป
        TweenService:Create(MainFrame, tweenInfoUI, {Size = UDim2.new(0, 420, 0, 45)}):Play()
        TweenService:Create(ContentGroup, tweenInfoUI, {GroupTransparency = 1}):Play()
        TweenService:Create(TabBar, tweenInfoUI, {Size = UDim2.new(0, 130, 0, 0)}):Play()
        task.wait(0.35)
        TabBar.Visible = false
    else
        MinBtn.Text = "[-]"
        TabBar.Visible = true
        -- ค่อยๆ ขยายขนาดความสูงกลับไปเป็น 270 และแสดงเนื้อหาคืนมา
        TweenService:Create(MainFrame, tweenInfoUI, {Size = UDim2.new(0, 420, 0, 270)}):Play()
        TweenService:Create(ContentGroup, tweenInfoUI, {GroupTransparency = 0}):Play()
        TweenService:Create(TabBar, tweenInfoUI, {Size = UDim2.new(0, 130, 1, -55)}):Play()
    end
end)

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

CloseBtn.MouseButton1Click:Connect(function() ConfirmPanel.Visible = true; ClickSound:Play() end)
CancelBtn.MouseButton1Click:Connect(function() ConfirmPanel.Visible = false; ClickSound:Play() end)
SureBtn.MouseButton1Click:Connect(function() sg:Destroy() end)
ShutUpBtn.MouseButton1Click:Connect(function() sg:Destroy() end)

-- 🔥 [[ ฟังก์ชันสร้างปุ่มหมวดหมู่ + ระบบแอนิเมชันขยายตัวตอนเมาส์ชี้ ]]
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

    -- เหตุการณ์ตอนเอาเมาส์ชี้ปุ่ม (ขยายใหญ่ขึ้นมานิดนึง + ขยับตำแหน่งมาขวาหน่อยให้ดูเด้ง)
    TBtn.MouseEnter:Connect(function()
        ClickSound:Play() -- เล่นเสียงกิ๊กเบาๆ ตอนเมาส์ชี้หมวดหมู่
        TweenService:Create(TBtn, tweenInfoTab, {
            Size = UDim2.new(1, 8, 0, 34), -- ขยายทั้งกว้างและสูงขึ้นนิดนึง
            Position = UDim2.new(0, -4, 0, posY - 2) -- ปรับกึ่งกลางให้สมดุล
        }):Play()
    end)

    -- เหตุการณ์ตอนเมาส์ออกจากปุ่ม (หดกลับขนาดเท่าเดิมเป๊ะๆ)
    TBtn.MouseLeave:Connect(function()
        TweenService:Create(TBtn, tweenInfoTab, {
            Size = UDim2.new(1, 0, 0, 30),
            Position = UDim2.new(0, 0, 0, posY)
        }):Play()
    end)

    TBtn.MouseButton1Click:Connect(function()
        ClickSound:Play()
        Page1_Skills.Visible = false; Page2_Fishing.Visible = false; Page3_Utils.Visible = false; Page4_Emergency.Visible = false
        targetPage.Visible = true
        for _, v in pairs(TabBar:GetChildren()) do if v:IsA("TextButton") then v.BackgroundColor3 = Color3.fromRGB(25, 25, 30) end end
        TBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    end)
end

CreateTabButton("⚔️ ออโต้สกิล", 5, Page1_Skills)
CreateTabButton("🎣 ออโต้ตกปลา", 38, Page2_Fishing)
CreateTabButton("🛠️ อำนวยความสะดวก", 71, Page3_Utils)
CreateTabButton("🚨 โหมดวาร์ปฉุกเฉิน", 104, Page4_Emergency)

-- ====================================================================
-- [2. ระบบ Backend ทำงานหลังบ้าน]
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
        for key, isEnabled in pairs(SkillStates) do if isEnabled and key ~= "V" then table.insert(activeSkills, key) end end
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
                if char and not char:GetAttribute("Fishing") and not MainGui.Fishing.Visible then
                    ReplicatedStorage.Events.Fishing:FireServer()
                end
            end)
        end
    end
end)

-- ล็อกเกจเขียวให้อยู่ตรงกลางเสมอ
RunService.RenderStepped:Connect(function()
    if getgenv().PPINGYYY_Anchor then
        pcall(function()
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
        end)
    end
end)

-- ฟิสิกส์คุมตัวละคร (ปีนกำแพง / Noclip)
RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    if ClimbWallEnabled then
        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {char}; raycastParams.FilterType = Enum.RaycastFilterType.Exclude
        local res = workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * 2.5, raycastParams)
        if res and res.Instance then hrp.Velocity = Vector3.new(hrp.Velocity.X, 45, hrp.Velocity.Z) end
    end

    if NoclipEnabled then
        for _, part in pairs(char:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end
    end
end)

-- ระบบ Smooth Teleport ขยับสั้นๆ แบบเนียนๆ
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

-- ฟังก์ชันประมวลผลวาร์ปพิกัดเนียน + ลบทิ้งเมื่อถึงจุดหมาย
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
local function CreateFunctionButton(keyName, posY, parentPage, isSkill, toggleCallback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.93, 0, 0, 36); Btn.Position = UDim2.new(0, 0, 0, posY)
    Btn.Text = (isSkill and ("AUTO " .. keyName .. " : OFF")) or (keyName .. " : OFF")
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255); Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 11; Btn.Parent = parentPage
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    local Stroke = Instance.new("UIStroke", Btn)
    Stroke.Color = Color3.fromRGB(0, 0, 0); Stroke.Thickness = 1.2

    Btn.MouseButton1Click:Connect(function()
        ClickSound:Play()
        local state = toggleCallback()
        if state then
            Btn.Text = (isSkill and ("AUTO " .. keyName .. " : ON")) or (keyName .. " : ON")
            Btn.BackgroundColor3 = Color3.fromRGB(210, 0, 0); Stroke.Enabled = false 
        else
            Btn.Text = (isSkill and ("AUTO " .. keyName .. " : OFF")) or (keyName .. " : OFF")
            Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255); Stroke.Enabled = true 
        end
    end)
end

CreateFunctionButton("Z", 5, Page1_Skills, true, function() SkillStates.Z = not SkillStates.Z return SkillStates.Z end)
CreateFunctionButton("X", 46, Page1_Skills, true, function() SkillStates.X = not SkillStates.X return SkillStates.X end)
CreateFunctionButton("C", 87, Page1_Skills, true, function() SkillStates.C = not SkillStates.C return SkillStates.C end)
CreateFunctionButton("V", 128, Page1_Skills, true, function() SkillStates.V = not SkillStates.V return SkillStates.V end)

CreateFunctionButton("ตกปลาอัตโนมัติ (Auto Cast)", 5, Page2_Fishing, false, function() getgenv().PPINGYYY_AutoCast = not getgenv().PPINGYYY_AutoCast return getgenv().PPINGYYY_AutoCast end)
CreateFunctionButton("ล็อกเกจตรงกลาง (Auto Catch)", 46, Page2_Fishing, false, function() getgenv().PPINGYYY_Anchor = not getgenv().PPINGYYY_Anchor return getgenv().PPINGYYY_Anchor end)

local ManualSellBtn = Instance.new("TextButton")
ManualSellBtn.Size = UDim2.new(0.93, 0, 0, 36); ManualSellBtn.Position = UDim2.new(0, 0, 0, 87)
ManualSellBtn.Text = "💰 ขายปลาทั้งหมดทันที"; ManualSellBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ManualSellBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 100)
ManualSellBtn.Font = Enum.Font.GothamBold; ManualSellBtn.TextSize = 11; ManualSellBtn.Parent = Page2_Fishing
Instance.new("UICorner", ManualSellBtn).CornerRadius = UDim.new(0, 6)
ManualSellBtn.MouseButton1Click:Connect(function() ClickSound:Play(); pcall(function() ReplicatedStorage.Events.SellFish:FireServer("All") end) end)

CreateFunctionButton("ปีนกำแพงอัตโนมัติ (Climb Wall)", 5, Page3_Utils, false, function() ClimbWallEnabled = not ClimbWallEnabled return ClimbWallEnabled end)
CreateFunctionButton("เดินทะลุกำแพงวัตถุ (Noclip)", 46, Page3_Utils, false, function() NoclipEnabled = not NoclipEnabled return NoclipEnabled end)

local FlyScriptBtn = Instance.new("TextButton")
FlyScriptBtn.Size = UDim2.new(0.93, 0, 0, 36); FlyScriptBtn.Position = UDim2.new(0, 0, 0, 87)
FlyScriptBtn.Text = "🚀 เปิดสคริปต์บิน FLY GUI V11"; FlyScriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255); FlyScriptBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 210)
FlyScriptBtn.Font = Enum.Font.GothamBold; FlyScriptBtn.TextSize = 11; FlyScriptBtn.Parent = Page3_Utils
Instance.new("UICorner", FlyScriptBtn).CornerRadius = UDim.new(0, 6)
FlyScriptBtn.MouseButton1Click:Connect(function() ClickSound:Play(); loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FLY-GUI-V11-205450"))() end)

local CopyPosBtn = Instance.new("TextButton")
CopyPosBtn.Size = UDim2.new(0.93, 0, 0, 36); 
