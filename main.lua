-- [[ ppingyyy Hub v3.3 - Emergency Thip Update ]]
-- เพิ่มหน้า 4 "โหมดฉุกเฉิน" รวมปุ่มเดินทิพย์, กระโดดทิพย์ และตกปลาทิพย์ ไว้แก้บั๊กตอนปุ่มเกมปกติกดไม่ได้!

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
MainFrame.Size = UDim2.new(0, 410, 0, 250) -- ปรับขนาดให้พอดีกับแผงปุ่มเดินทิพย์
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
Title.Text = "★ PPINGYYY HUB v3.3 (Thip Edition)"
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
Page1_Skills.BackgroundTransparency = 1; Page1_Skills.ScrollBarThickness = 3
Page1_Skills.CanvasSize = UDim2.new(0, 0, 0, 180); Page1_Skills.Visible = true; Page1_Skills.Parent = PagesArea

local Page2_Fishing = Instance.new("ScrollingFrame")
Page2_Fishing.Size = UDim2.new(1, 0, 1, 0)
Page2_Fishing.BackgroundTransparency = 1; Page2_Fishing.ScrollBarThickness = 0
Page2_Fishing.Visible = false; Page2_Fishing.Parent = PagesArea

local Page3_Utils = Instance.new("ScrollingFrame")
Page3_Utils.Size = UDim2.new(1, 0, 1, 0)
Page3_Utils.BackgroundTransparency = 1; Page3_Utils.ScrollBarThickness = 0
Page3_Utils.Visible = false; Page3_Utils.Parent = PagesArea

local Page4_Emergency = Instance.new("ScrollingFrame")
Page4_Emergency.Size = UDim2.new(1, 0, 1, 0)
Page4_Emergency.BackgroundTransparency = 1; Page4_Emergency.ScrollBarThickness = 3
Page4_Emergency.CanvasSize = UDim2.new(0, 0, 0, 240); Page4_Emergency.Visible = false; Page4_Emergency.Parent = PagesArea

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
        MainFrame.Size = UDim2.new(0, 410, 0, 250)
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
CancelBtn.Position = UDim2.new(0.075, 0, 0, 145)
CancelBtn.Text = "เปลี่ยนใจไม่ลบละ"
CancelBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
CancelBtn.BackgroundTransparency = 1; CancelBtn.ZIndex = 11; CancelBtn.Parent = ConfirmPanel

CloseBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        TabBar.Visible = true; PagesArea.Visible = true
        MainFrame.Size = UDim2.new(0, 410, 0, 250)
        MinBtn.Text = "[-]"; isMinimized = false
    end
    ConfirmPanel.Visible = true
end)
CancelBtn.MouseButton1Click:Connect(function() ConfirmPanel.Visible = false end)
local function DestroyHub() sg:Destroy() end
SureBtn.MouseButton1Click:Connect(DestroyHub)
ShutUpBtn.MouseButton1Click:Connect(DestroyHub)

-- ====================================================================
-- [3. ฟังก์ชันสลับหน้า Tab]
-- ====================================================================
local function CreateTabButton(name, posY, targetPage)
    local TBtn = Instance.new("TextButton")
    TBtn.Size = UDim2.new(1, 0, 0, 30)
    TBtn.Position = UDim2.new(0, 0, 0, posY)
    TBtn.Text = name
    TBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TBtn.BackgroundColor3 = (targetPage.Visible and Color3.fromRGB(40, 40, 45)) or Color3.fromRGB(25, 25, 30)
    TBtn.Font = Enum.Font.GothamBold
    TBtn.TextSize = 10
    TBtn.Parent = TabBar
    Instance.new("UICorner", TBtn).CornerRadius = UDim.new(0, 6)

    TBtn.MouseButton1Click:Connect(function()
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
CreateTabButton("🚨 โหมดฉุกเฉินทิพย์", 104, Page4_Emergency) -- เปิดตัวหน้าต่างใหม่!

-- ====================================================================
-- [4. ระบบทำงานหลังบ้าน (Backend)]
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
            task.wait(0.06)
            VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
        end)
    end
end

-- ลูปคุมออโต้สกิล Z, X, C, V
task.spawn(function()
    while true do
        task.wait(0.3) 
        if SkillStates["V"] then PressKey("V") task.wait(0.6) end
        local activeSkills = {}
        for key, isEnabled in pairs(SkillStates) do
            if isEnabled and key ~= "V" then table.insert(activeSkills, key) end
        end
        if #activeSkills > 0 then
            local randomIndex = math.random(1, #activeSkills)
            PressKey(activeSkills[randomIndex])
            task.wait(0.5) 
        end
    end
end)

-- ลูปแสกนและกดวงกลมเช็กจังหวะอัตโนมัติ 
RunService.RenderStepped:Connect(function()
    if SkillStates.Z or SkillStates.X or SkillStates.C or SkillStates.V then
        pcall(function()
            local pGui = LocalPlayer.PlayerGui
            local skillCheckNames = {"SkillCheck", "CircleCheck", "TimingGui", "QTEGui", "QuickTimeEvent", "PerfectClick"}
            
            for _, name in pairs(skillCheckNames) do
                local targetGui = pGui:FindFirstChild(name)
                if targetGui and targetGui.Enabled == true then
                    if targetGui:FindFirstChild("Button") then
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 1)
                        VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 1)
                    end
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                    break
                end
            end
        end)
    end
end)

-- ลูปตกปลาอัตโนมัติ
task.spawn(function()
    while true do
        task.wait(0.8) 
        if getgenv().PPINGYYY_AutoCast then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    if not char:GetAttribute("Fishing") and not MainGui.Fishing.Visible then
                        ReplicatedStorage.Events.Fishing:FireServer()
                    end
                end
            end)
        end
    end
end)

-- ลูปย้ายเกจเขียวตกปลา
RunService.RenderStepped:Connect(function()
    if getgenv().PPINGYYY_Anchor then
        pcall(function()
            local fishingUI = MainGui:FindFirstChild("Fishing")
            if fishingUI and fishingUI.Visible then
                local barFrame = fishingUI:FindFirstChild("BarFrame")
                if barFrame and barFrame:FindFirstChild("Bar") then
                    local bar = barFrame.Bar
                    bar.Position = UDim2.new(0.5, 0, bar.Position.Y.Scale, 0)
                    if math.random(1, 4) == 1 then ReplicatedStorage.Fishing:FireServer("1") end
                end
            end
        end)
    end
end)

-- ลูปคุมระบบหน้า 3
RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    local hrp = char.HumanoidRootPart

    if ClimbWallEnabled then
        pcall(function()
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {char}
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude
            local raycastResult = workspace:Raycast(hrp.Position, hrp.CFrame.LookVector * 2.5, raycastParams)
            if raycastResult and raycastResult.Instance then hrp.Velocity = Vector3.new(hrp.Velocity.X, 45, hrp.Velocity.Z) end
        end)
    end

    if NoclipEnabled then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    end
end)

-- ฟังก์ชันคุมการเคลื่อนที่ของระบบ "สายทิพย์"
local function ThipMove(direction)
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local moveDistance = 4 -- ระยะขยับก้าวต่อการกด 1 ครั้ง ปรับได้ตามใจมึง
            if direction == "Up" then
                hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -moveDistance)
            elseif direction == "Down" then
                hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, moveDistance)
            elseif direction == "Left" then
                hrp.CFrame = hrp.CFrame * CFrame.new(-moveDistance, 0, 0)
            elseif direction == "Right" then
                hrp.CFrame = hrp.CFrame * CFrame.new(moveDistance, 0, 0)
            elseif direction == "Jump" then
                hrp.CFrame = hrp.CFrame * CFrame.new(0, 7, 0) -- โดดเด้งขึ้นฟ้า 7 บล็อกลอยทิพย์ ๆ
            end
        end
    end)
end

-- ====================================================================
-- [5. ฟังก์ชันสร้างปุ่มควบคุมระบบหน้า 1, 2, 3]
-- ====================================================================
local function CreateFunctionButton(keyName, posY, parentPage, isSkill, toggleCallback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.93, 0, 0, 36)
    Btn.Position = UDim2.new(0, 0, 0, posY)
    Btn.Text = (isSkill and ("AUTO " .. keyName .. " : OFF")) or (keyName .. " : OFF")
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255) 
    Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 11
    Btn.Parent = parentPage

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    local TextStroke = Instance.new("UIStroke", Btn)
    TextStroke.Color = Color3.fromRGB(0, 0, 0); TextStroke.Thickness = 1.2

    Btn.MouseButton1Click:Connect(function()
        local state = toggleCallback()
        if state then
            Btn.Text = (isSkill and ("AUTO " .. keyName .. " : ON")) or (keyName .. " : ON")
            Btn.BackgroundColor3 = Color3.fromRGB(210, 0, 0); TextStroke.Enabled = false 
        else
            Btn.Text = (isSkill and ("AUTO " .. keyName .. " : OFF")) or (keyName .. " : OFF")
            Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255); TextStroke.Enabled = true 
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
Instance.new("UIStroke", ManualSellBtn).Color = Color3.fromRGB(0, 0, 0)
ManualSellBtn.MouseButton1Click:Connect(function() pcall(function() ReplicatedStorage.Events.SellFish:FireServer("All") end) end)

CreateFunctionButton("ปีนกำแพงอัตโนมัติ (Climb Wall)", 5, Page3_Utils, false, function() ClimbWallEnabled = not ClimbWallEnabled return ClimbWallEnabled end)
CreateFunctionButton("เดินทะลุกำแพงวัตถุ (Noclip)", 46, Page3_Utils, false, function() NoclipEnabled = not NoclipEnabled return NoclipEnabled end)

local FlyScriptBtn = Instance.new("TextButton")
FlyScriptBtn.Size = UDim2.new(0.93, 0, 0, 36); FlyScriptBtn.Position = UDim2.new(0, 0, 0, 87)
FlyScriptBtn.Text = "🚀 เปิดสคริปต์บิน FLY GUI V11"; FlyScriptBtn.TextColor3 = Color3.fromRGB(255, 255, 255); FlyScriptBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 210)
FlyScriptBtn.Font = Enum.Font.GothamBold; FlyScriptBtn.TextSize = 11; FlyScriptBtn.Parent = Page3_Utils
Instance.new("UICorner", FlyScriptBtn).CornerRadius = UDim.new(0, 6)
FlyScriptBtn.MouseButton1Click:Connect(function() pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FLY-GUI-V11-205450"))() end) end)

local ResetMoveBtn = Instance.new("TextButton")
ResetMoveBtn.Size = UDim2.new(0.93, 0, 0, 36); ResetMoveBtn.Position = UDim2.new(0, 0, 0, 128)
ResetMoveBtn.Text = "🛠️ ฟื้นฟูระบบเดิน/กระโดด (Reset)"; ResetMoveBtn.TextColor3 = Color3.fromRGB(255, 255, 255); ResetMoveBtn.BackgroundColor3 = Color3.fromRGB(230, 100, 0)
ResetMoveBtn.Font = Enum.Font.GothamBold; ResetMoveBtn.TextSize = 11; ResetMoveBtn.Parent = Page3_Utils
Instance.new("UICorner", ResetMoveBtn).CornerRadius = UDim.new(0, 6)
ResetMoveBtn.MouseButton1Click:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
            char:FindFirstChildOfClass("Humanoid").JumpPower = 50
            char:FindFirstChildOfClass("Humanoid").PlatformStand = false
        end
    end)
end)

-- ====================================================================
-- [6. ส่วนปุ่มหน้า 4 - แผงควบคุมสายทิพย์โหมดฉุกเฉิน (Thip Control Interface)]
-- ====================================================================
local function CreateThipBtn(text, size, pos, action)
    local Btn = Instance.new("TextButton")
    Btn.Size = size; Btn.Position = pos; Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255); Btn.BackgroundColor3 = Color3.fromRGB(40, 45, 60)
    Btn.Font = Enum.Font.GothamBold; Btn.TextSize = 12; Btn.Parent = Page4_Emergency
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 5)
    local Stroke = Instance.new("UIStroke", Btn)
    Stroke.Color = Color3.fromRGB(0, 0, 0); Stroke.Thickness = 1
    Btn.MouseButton1Click:Connect(action)
end

-- ประกอบแผงควบคุมจอยสติ๊กเดินทิพย์ (D-Pad Style)
CreateThipBtn("▲ บนทิพย์", UDim2.new(0, 70, 0, 30), UDim2.new(0, 80, 0, 5), function() ThipMove("Up") end)
CreateThipBtn("◀ ซ้ายทิพย์", UDim2.new(0, 70, 0, 30), UDim2.new(0, 5, 0, 40), function() ThipMove("Left") end)
CreateThipBtn("🦘 โดดทิพย์", UDim2.new(0, 70, 0, 30), UDim2.new(0, 80, 0, 40), function() ThipMove("Jump") end)
CreateThipBtn("▶ ขวาทิพย์", UDim2.new(0, 70, 0, 30), UDim2.new(0, 155, 0, 40), function() ThipMove("Right") end)
CreateThipBtn("▼ ล่างทิพย์", UDim2.new(0, 70, 0, 30), UDim2.new(0, 80, 0, 75), function() ThipMove("Down") end)

-- ปุ่มตกปลาทิพย์ (สำรองยามปุ่มเกมหาย) วางแยกไว้ด้าน
