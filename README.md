-- [[ ppingyyy Hub v2.0 - Ultimate Hack & Fishing Integration ]]
-- เพิ่มหมวดหมู่ที่ 3 ระบบอำนวยความสะดวก: ปีนกำแพง, บิน, ทะลุ, มองผู้เล่น ยัดรวมในลิงก์เดียว!

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Workspace = game:GetService("Workspace")

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
-- [1. หน้าต่างหลัก (Main Frame) - ขยายขนาดเพื่อรองรับ 3 หมวดหมู่]
-- ====================================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 380, 0, 280)
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
Title.Text = "★ PPINGYYY HUB v2.0"
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
TabBar.Size = UDim2.new(0, 120, 1, -55)
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.BackgroundTransparency = 1
TabBar.Parent = MainFrame

local PagesArea = Instance.new("Frame")
PagesArea.Size = UDim2.new(1, -145, 1, -55)
PagesArea.Position = UDim2.new(0, 135, 0, 50)
PagesArea.BackgroundTransparency = 1
PagesArea.Parent = MainFrame

-- สร้างโครงหน้าเพจทั้ง 3 หน้า
local Page1_Skills = Instance.new("ScrollingFrame")
Page1_Skills.Size = UDim2.new(1, 0, 1, 0)
Page1_Skills.BackgroundTransparency = 1
Page1_Skills.ScrollBarThickness = 0
Page1_Skills.Visible = true
Page1_Skills.Parent = PagesArea

local Page2_Fishing = Instance.new("ScrollingFrame")
Page2_Fishing.Size = UDim2.new(1, 0, 1, 0)
Page2_Fishing.BackgroundTransparency = 1
Page2_Fishing.ScrollBarThickness = 0
Page2_Fishing.Visible = false
Page2_Fishing.Parent = PagesArea

local Page3_Utils = Instance.new("ScrollingFrame")
Page3_Utils.Size = UDim2.new(1, 0, 1, 0)
Page3_Utils.BackgroundTransparency = 1
Page3_Utils.ScrollBarThickness = 3
Page3_Utils.CanvasSize = UDim2.new(0, 0, 1.3, 0) -- ขยายให้เลื่อนสกรอลล์ลงมาได้
Page3_Utils.Parent = PagesArea

-- ====================================================================
-- [2. ระบบปุ่มย่อ [-] และ ปุ่มลบ [X] (ลบเลยหุบปาก)]
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
        MainFrame.Size = UDim2.new(0, 380, 0, 45)
        MinBtn.Text = "[+]"
    else
        TabBar.Visible = true; PagesArea.Visible = true
        MainFrame.Size = UDim2.new(0, 380, 0, 280)
        MinBtn.Text = "[-]"
    end
end)

local ConfirmPanel = Instance.new("Frame")
ConfirmPanel.Size = UDim2.new(0.94, 0, 0.75, 0)
ConfirmPanel.Position = UDim2.new(0.03, 0, 0.2, 0)
ConfirmPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ConfirmPanel.Visible = false
ConfirmPanel.ZIndex = 10
ConfirmPanel.Parent = MainFrame
Instance.new("UICorner", ConfirmPanel).CornerRadius = UDim.new(0, 10)

local SureBtn = Instance.new("TextButton")
SureBtn.Size = UDim2.new(0.85, 0, 0, 40)
SureBtn.Position = UDim2.new(0.075, 0, 0, 30)
SureBtn.Text = "มึงแน่ใจใช่ไหมว่าจะลบ?"
SureBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SureBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
SureBtn.ZIndex = 11
SureBtn.Parent = ConfirmPanel
Instance.new("UICorner", SureBtn).CornerRadius = UDim.new(0, 8)

local ShutUpBtn = Instance.new("TextButton")
ShutUpBtn.Size = UDim2.new(0.85, 0, 0, 40)
ShutUpBtn.Position = UDim2.new(0.075, 0, 0, 90)
ShutUpBtn.Text = "ลบเลยหุบปาก"
ShutUpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ShutUpBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ShutUpBtn.ZIndex = 11
ShutUpBtn.Parent = ConfirmPanel
Instance.new("UICorner", ShutUpBtn).CornerRadius = UDim.new(0, 8)

local CancelBtn = Instance.new("TextButton")
CancelBtn.Size = UDim2.new(0.85, 0, 0, 30)
CancelBtn.Position = UDim2.new(0.075, 0, 0, 145)
CancelBtn.Text = "เปลี่ยนใจไม่ลบละ"
CancelBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
CancelBtn.BackgroundTransparency = 1
CancelBtn.ZIndex = 11
CancelBtn.Parent = ConfirmPanel

CloseBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        TabBar.Visible = true; PagesArea.Visible = true
        MainFrame.Size = UDim2.new(0, 380, 0, 280)
        MinBtn.Text = "[-]"; isMinimized = false
    end
    ConfirmPanel.Visible = true
end)
CancelBtn.MouseButton1Click:Connect(function() ConfirmPanel.Visible = false end)
local function DestroyHub() sg:Destroy() end
SureBtn.MouseButton1Click:Connect(DestroyHub)
ShutUpBtn.MouseButton1Click:Connect(DestroyHub)

-- ====================================================================
-- [3. ฟังก์ชันสลับหน้า Tab (รองรับ 3 ปุ่ม)]
-- ====================================================================
local function CreateTabButton(name, posY, targetPage)
    local TBtn = Instance.new("TextButton")
    TBtn.Size = UDim2.new(1, 0, 0, 35)
    TBtn.Position = UDim2.new(0, 0, 0, posY)
    TBtn.Text = name
    TBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TBtn.BackgroundColor3 = (targetPage.Visible and Color3.fromRGB(40, 40, 45)) or Color3.fromRGB(25, 25, 30)
    TBtn.Font = Enum.Font.GothamBold
    TBtn.TextSize = 11
    TBtn.Parent = TabBar
    Instance.new("UICorner", TBtn).CornerRadius = UDim.new(0, 6)

    TBtn.MouseButton1Click:Connect(function()
        Page1_Skills.Visible = false; Page2_Fishing.Visible = false; Page3_Utils.Visible = false
        targetPage.Visible = true
        for _, v in pairs(TabBar:GetChildren()) do
            if v:IsA("TextButton") then v.BackgroundColor3 = Color3.fromRGB(25, 25, 30) end
        end
        TBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    end)
end

CreateTabButton("⚔️ ออโต้สกิล", 5, Page1_Skills)
CreateTabButton("🎣 ออโต้ตกปลา", 45, Page2_Fishing)
CreateTabButton("🛠️ อำนวยความสะดวก", 85, Page3_Utils)

-- ====================================================================
-- [4. ระบบฟังก์ชันการทำงานเบื้องหลัง (Backend)]
-- ====================================================================
local SkillStates = { Z = false, X = false, C = false, V = false }
getgenv().PPINGYYY_Anchor = false

-- ตัวแปรระบบแฮกหน้า 3
local ClimbWallEnabled = false
local FlyEnabled = false
local NoclipEnabled = false
local EspEnabled = false

local function PressKey(keyStr)
    local keyCode = Enum.KeyCode[keyStr]
    if keyCode then
        VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
    end
end

-- ลูปคุมสกิล
task.spawn(function()
    while true do
        task.wait(0.1)
        if SkillStates["V"] then
            pcall(function() PressKey("V") end)
            task.wait(0.5)
        end
        local activeSkills = {}
        for key, isEnabled in pairs(SkillStates) do
            if isEnabled and key ~= "V" then table.insert(activeSkills, key) end
        end
        if #activeSkills > 0 then
            pcall(function()
                local randomIndex = math.random(1, #activeSkills)
                PressKey(activeSkills[randomIndex])
            end)
            task.wait(0.4)
        end
    end
end)

-- ลูปคุมล็อกเกจตกปลาตรงกลาง
RunService.RenderStepped:Connect(function()
    if getgenv().PPINGYYY_Anchor then
        pcall(function()
            local fishingUI = MainGui.Fishing
            if fishingUI.Visible then
                local bar = fishingUI.BarFrame.Bar
                bar.Position = UDim2.new(0.5, 0, bar.Position.Y.Scale, 0)
                ReplicatedStorage.Fishing:FireServer("1")
            end
        end)
    end
end)

-- ลูปคุมระบบอำนวยความสะดวก (ปีนกำแพง, บิน, ทะลุกำแพง)
local flyBodyVelocity
RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    -- 1. ลอจิกปีนกำแพงอัตโนมัติ (ชนกำแพงแล้วกระโดดรัวๆ ออกห่างหยุดทำงาน)
    if ClimbWallEnabled then
        pcall(function()
            local raycastParams = RaycastParams.new()
            raycastParams.FilterDescendantsInstances = {char}
            raycastParams.FilterType = Enum.RaycastFilterType.Exclude

            -- ยิงลำแสงเลเซอร์ไปข้างหน้าตัวละคร 2.5 หน่วย เพื่อเช็กกำแพง
            local rayOrigin = hrp.Position
            local rayDirection = hrp.CFrame.LookVector * 2.5
            local raycastResult = Workspace:Raycast(rayOrigin, rayDirection, raycastParams)

            if raycastResult and raycastResult.Instance then
                -- ถ้าชนกำแพง สั่งกระโดดดีดตัวขึ้นทันทีเหมือน Infinite Jump
                hrp.Velocity = Vector3.new(hrp.Velocity.X, 45, hrp.Velocity.Z)
            end
        end)
    end

    -- 2. ลอจิกทะลุกำแพง (Noclip)
    if NoclipEnabled then
        for _, part in pairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    -- 3. ลอจิกบินเท่ๆ (Fly Hack)
    if FlyEnabled then
        pcall(function()
            if not flyBodyVelocity then
                flyBodyVelocity = Instance.new("BodyVelocity")
                flyBodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                flyBodyVelocity.Parent = hrp
            end
            -- ควบคุมทิศทางตามปุ่มการเดินและทิศทางของมุมกล้องในมือถือ/คอม
            local camera = Workspace.CurrentCamera
            local moveDirection = hum.MoveDirection
            if moveDirection.Magnitude > 0 then
                flyBodyVelocity.Velocity = camera.CFrame:VectorToWorldSpace(Vector3.new(moveDirection.X, 0, -moveDirection.Z).Unit * 50)
            else
                flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    else
        if flyBodyVelocity then
            flyBodyVelocity:Destroy()
            flyBodyVelocity = nil
        end
    end
end)

-- 4. ลอจิกมองทะลุผู้เล่นทุกคนในเซิร์ฟ (ESP)
task.spawn(function()
    while true do
        task.wait(1)
        if EspEnabled then
            pcall(function()
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        if not p.Character:FindFirstChild("ppingyyy_ESP") then
                            local highlight = Instance.new("Highlight")
                            highlight.Name = "ppingyyy_ESP"
                            highlight.FillColor = Color3.fromRGB(255, 0, 0) -- แดงสะท้อนแสง
                            highlight.FillTransparency = 0.5
                            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                            highlight.OutlineTransparency = 0
                            highlight.Adornee = p.Character
                            highlight.Parent = p.Character
                        end
                    end
                end
            end)
        else
            -- ถ้าสั่งปิดให้กวาดล้างลบ ESP ออกให้หมดจอ
            pcall(function()
                for _, p in pairs(Players:GetPlayers()) do
                    if p.Character and p.Character:FindFirstChild("ppingyyy_ESP") then
                        p.Character["ppingyyy_ESP"]:Destroy()
                    end
                end
            end)
        end
    end
end)

-- ====================================================================
-- [5. ฟังก์ชันสร้างปุ่มตัวเลือกฟังก์ชันภายในหน้า Page]
-- ====================================================================
local function CreateFunctionButton(keyName, posY, parentPage, isSkill, toggleCallback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.93, 0, 0, 38)
    Btn.Position = UDim2.new(0, 0, 0, posY)
    Btn.Text = (isSkill and ("AUTO " .. keyName .. " : OFF")) or (keyName .. " : OFF")
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255) 
    Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 12
    Btn.Parent = parentPage

    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    local TextStroke = Instance.new("UIStroke", Btn)
    TextStroke.Color = Color3.fromRGB(0, 0, 0)
    TextStroke.Thickness = 1.2

    Btn.MouseButton1Click:Connect(function()
        local state = toggleCallback()
        if state then
            Btn.Text = (isSkill and ("AUTO " .. keyName .. " : ON")) or (keyName .. " : ON")
            Btn.BackgroundColor3 = Color3.fromRGB(210, 0, 0)
            TextStroke.Enabled = false 
        else
            Btn.Text = (isSkill and ("AUTO " .. keyName .. " : OFF")) or (keyName .. " : OFF")
            Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextStroke.Enabled = true 
        end
    end)
end

-- สร้างปุ่มสกิลหน้า 1
CreateFunctionButton("Z", 5, Page1_Skills, true, function() SkillStates.Z = not SkillStates.Z return SkillStates.Z end)
CreateFunctionButton("X", 50, Page1_Skills, true, function() SkillStates.X = not SkillStates.X return SkillStates.X end)
CreateFunctionButton("C", 95, Page1_Skills, true, function() SkillStates.C = not SkillStates.C return SkillStates.C end)
CreateFunctionButton("V", 140, Page1_Skills, true, function() SkillStates.V = not SkillStates.V return SkillStates.V end)

-- สร้างปุ่มตกปลาหน้า 2
CreateFunctionButton("ล็อกเกจตรงกลาง (Auto Catch)", 5, Page2_Fishing, false, function() 
    getgenv().PPINGYYY_Anchor = not getgenv().PPINGYYY_Anchor 
    return getgenv().PPINGYYY_Anchor 
end)

local ManualSellBtn = Instance.new("TextButton")
ManualSellBtn.Size = UDim2.new(0.93, 0, 0, 38)
ManualSellBtn.Position = UDim2.new(0, 0, 0, 50)
ManualSellBtn.Text = "💰 ขายปลาทั้งหมดทันที"
ManualSellBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ManualSellBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 100)
ManualSellBtn.Font = Enum.Font.GothamBold
ManualSellBtn.TextSize = 12
ManualSellBtn.Parent = Page2_Fishing
Instance.new("UICorner", ManualSellBtn).CornerRadius = UDim.new(0, 6)
local SellStroke = Instance.new("UIStroke", ManualSellBtn)
SellStroke.Color = Color3.fromRGB(0, 0, 0)
SellStroke.Thickness = 1.2

ManualSellBtn.MouseButton1Click:Connect(function()
    pcall(function() ReplicatedStorage.Events.SellFish:FireServer("All") end)
    ManualSellBtn.Text = "✔ ¡VENDIDO! (ขายแล้ว)"
    ManualSellBtn.BackgroundColor3 = Color3.fromRGB(210, 0, 0)
    task.wait(0.5)
    ManualSellBtn.Text = "💰 ขายปลาทั้งหมดทันที"
    ManualSellBtn.BackgroundColor3 = Color3.fromRGB(0, 160, 100)
end)

-- --- [สร้างปุ่มหน้า 3 หมวดหมู่ระบบอำนวยความสะดวก (Utility)] ---
CreateFunctionButton("ปีนกำแพงอัตโนมัติ (Climb Wall)", 5, Page3_Utils, false, function() ClimbWallEnabled = not ClimbWallEnabled return ClimbWallEnabled end)
CreateFunctionButton("ระบบบินร่อนกลางเวหา (Fly)", 50, Page3_Utils, false, function() FlyEnabled = not FlyEnabled return FlyEnabled end)
CreateFunctionButton("เดินทะลุกำแพงวัตถุ (Noclip)", 95, Page3_Utils, false, function() NoclipEnabled = not NoclipEnabled return NoclipEnabled end)
CreateFunctionButton("มองเห็นผู้เล่นทุกคน (ESP)", 140, Page3_Utils, false, function() EspEnabled = not EspEnabled return EspEnabled end)

print("------- ★ [ppingyyy Hub v2.0] Ultimate Utility Pack Loaded! ★ -------")
