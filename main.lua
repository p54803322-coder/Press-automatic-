-- [[ ★PPINGYYY HUB★ - FIXED TABS ANIMATION ONLY ]] --
local lp = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager") 

-- ตั้งค่าตัวแปร Global
getgenv().NWKZ_Anchor = false
getgenv().NWKZ_AutoCast = false
getgenv().PP_Noclip = false
getgenv().PP_WalkSpeed = 16
getgenv().PP_FishingThipActive = false

-- ตัวแปรระบบสกิลออโต้
getgenv().PP_AutoSkillAll = false
getgenv().PP_Skill_Z = false
getgenv().PP_Skill_X = false
getgenv().PP_Skill_C = false
getgenv().PP_Skill_V = false

local skillKeys = {Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V}

-- Config อนิเมชั่นสำหรับแท็บหมวดหมู่
local tweenInfoTab = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

-- [[ 1. สร้าง ScreenGui หลัก ]] --
local sg = Instance.new("ScreenGui")
sg.Name = "PPINGYYY_Hub_FinalFix"
sg.ResetOnSpawn = false

local success, err = pcall(function()
    sg.Parent = game:GetService("CoreGui")
end)
if not success then
    sg.Parent = lp:WaitForChild("PlayerGui")
end

local MainSize = UDim2.new(0, 420, 0, 250)
local MinimizedSize = UDim2.new(0, 420, 0, 40)
local tweenInfoMain = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

-- [[ 2. หน้าต่างหลัก ]] --
local Main = Instance.new("Frame", sg)
Main.Size = MainSize
Main.Position = UDim2.new(0.1, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- [[ 3. แถบหัวข้อ (Title Bar) ]] --
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.Text = "★PPINGYYY HUB★"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.BackgroundTransparency = 1

local MinBtn = Instance.new("TextButton", TitleBar)
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(0.81, 0, 0.25, 0)
MinBtn.Text = "—"
MinBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(0.9, 0, 0.25, 0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

-- [[ 4. โครงสร้างแท็บเมนู ]] --
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, 0, 1, -40)
Container.Position = UDim2.new(0, 0, 0, 40)
Container.BackgroundTransparency = 1

local Sidebar = Instance.new("Frame", Container)
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Sidebar.BorderSizePixel = 0

local Pages = Instance.new("Frame", Container)
Pages.Size = UDim2.new(1, -130, 1, -10)
Pages.Position = UDim2.new(0, 125, 0, 5)
Pages.BackgroundTransparency = 1

local function createTabButton(text, posIndex)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(0.85, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, 8 + (posIndex * 40))
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local Tab1Btn = createTabButton("🎣 ตกปลาออโต้", 0)
local Tab2Btn = createTabButton("⚡ สกิลอัตโนมัติ", 1)
local Tab3Btn = createTabButton("🛠️ อำนวยสะดวก", 2)

local function createPage()
    local page = Instance.new("ScrollingFrame", Pages)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 150)
    page.Visible = false
    return page
end

local Page1 = createPage()
local Page2 = createPage()
local Page3 = createPage()

-- ระบบอนิเมชั่นสลับแท็บ (เหลือไว้แค่ส่วนนี้เพื่อความสวยงามและเสถียร)
local activePage = nil local activeBtn = nil
local function showPage(targetPage, targetBtn, posIndex)
    if activePage == targetPage then return end
    
    if activeBtn then
        local oldIndex = activeBtn:GetAttribute("Index") or 0
        TweenService:Create(activeBtn, tweenInfoTab, {
            Size = UDim2.new(0.85, 0, 0, 35),
            Position = UDim2.new(0.05, 0, 0, 8 + (oldIndex * 40)),
            TextColor3 = Color3.fromRGB(150, 150, 150),
            BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        }):Play()
    end
    
    targetBtn:SetAttribute("Index", posIndex)
    TweenService:Create(targetBtn, tweenInfoTab, {
        Size = UDim2.new(0.95, 0, 0, 35),
        Position = UDim2.new(0.08, 0, 0, 8 + (posIndex * 40)),
        TextColor3 = Color3.fromRGB(0, 255, 150),
        BackgroundColor3 = Color3.fromRGB(25, 35, 30)
    }):Play()
    
    activeBtn = targetBtn
    if activePage then activePage.Visible = false end 
    targetPage.Visible = true 
    activePage = targetPage
end

Tab1Btn.MouseButton1Click:Connect(function() showPage(Page1, Tab1Btn, 0) end)
Tab2Btn.MouseButton1Click:Connect(function() showPage(Page2, Tab2Btn, 1) end)
Tab3Btn.MouseButton1Click:Connect(function() showPage(Page3, Tab3Btn, 2) end)

-- ฟังก์ชันสร้างปุ่มแบบธรรมดา (ไม่มีอนิเมชั่นขยับพิกัด ป้องกันปุ่มเอ๋อ)
local function createNormalButton(parent, text, yPos)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.95, 0, 0, 32)
    btn.Position = UDim2.new(0.025, 0, 0, yPos)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn)
    return btn
end

-- [[ 5. หมวดหมู่ที่ 1 (🎣 ตกปลาออโต้) ]] --
local CastBtn = createNormalButton(Page1, "AUTO CAST (เหวี่ยงเบ็ดออโต้): OFF", 5)
local AnchorBtn = createNormalButton(Page1, "ANCHOR (ทำให้แถบอยู่ตรงกลาง): OFF", 42)
local FishThipBtn = createNormalButton(Page1, "🟢 เปิดปิดปุ่มตกปลาทิพย์ (ขวาจอ): OFF", 79)

local SellBtn = Instance.new("TextButton", Page1)
SellBtn.Size = UDim2.new(0.95, 0, 0, 32)
SellBtn.Position = UDim2.new(0.025, 0, 0, 116)
SellBtn.Text = "💰 SELL ALL (ขายปลาทั้งหมด)"
SellBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 40)
SellBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
SellBtn.Font = Enum.Font.GothamBold
SellBtn.TextSize = 10
Instance.new("UICorner", SellBtn)

-- [[ 6. หมวดหมู่ที่ 2 (⚡ สกิลอัตโนมัติ) ]] --
local SkillAllBtn = createNormalButton(Page2, "AUTO ALL SKILLS (รวมกดทุกสกิล): OFF", 5)

local function createGridSkillBtn(keyName, posIndex, varName)
    local btn = Instance.new("TextButton", Page2)
    btn.Size = UDim2.new(0.46, 0, 0, 30)
    local xPos = (posIndex % 2 == 0) and 0.02 or 0.51
    local yPos = 45 + (math.floor(posIndex / 2) * 35)
    btn.Position = UDim2.new(xPos, 0, 0, yPos)
    btn.Text = "AUTO SKILL ["..keyName.."]: OFF"
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function()
        getgenv()[varName] = not getgenv()[varName]
        btn.Text = "AUTO SKILL ["..keyName.."]: " .. (getgenv()[varName] and "ON" or "OFF")
        btn.BackgroundColor3 = getgenv()[varName] and Color3.fromRGB(0, 120, 200) or Color3.fromRGB(40, 40, 45)
        btn.TextColor3 = getgenv()[varName] and Color3.new(1,1,1) or Color3.fromRGB(200, 200, 200)
    end)
end
createGridSkillBtn("V", 0, "PP_Skill_V")
createGridSkillBtn("Z", 1, "PP_Skill_Z")
createGridSkillBtn("X", 2, "PP_Skill_X")
createGridSkillBtn("C", 3, "PP_Skill_C")

-- [[ 7. หมวดหมู่ที่ 3 (🛠️ อำนวยสะดวก) ]] --
local NoclipBtn = createNormalButton(Page3, "NOCLIP (ทะลุกำแพง): OFF", 5)

local SpeedLabel = Instance.new("TextLabel", Page3)
SpeedLabel.Size = UDim2.new(1, -10, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 45)
SpeedLabel.Text = "WALKSPEED (วิ่งเร็ว): 16"
SpeedLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 11
SpeedLabel.BackgroundTransparency = 1

local SpeedUpBtn = Instance.new("TextButton", Page3)
SpeedUpBtn.Size = UDim2.new(0.46, 0, 0, 30)
SpeedUpBtn.Position = UDim2.new(0.02, 0, 0, 70)
SpeedUpBtn.Text = "เพิ่มความเร็ว (+)"
SpeedUpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedUpBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedUpBtn.Font = Enum.Font.GothamBold
SpeedUpBtn.TextSize = 10
Instance.new("UICorner", SpeedUpBtn)

local SpeedDownBtn = Instance.new("TextButton", Page3)
SpeedDownBtn.Size = UDim2.new(0.46, 0, 0, 30)
SpeedDownBtn.Position = UDim2.new(0.51, 0, 0, 70)
SpeedDownBtn.Text = "ลดความเร็ว (-)"
SpeedDownBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedDownBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedDownBtn.Font = Enum.Font.GothamBold
SpeedDownBtn.TextSize = 10
Instance.new("UICorner", SpeedDownBtn)

local FlyBtn = Instance.new("TextButton", Page3)
FlyBtn.Size = UDim2.new(0.95, 0, 0, 35)
FlyBtn.Position = UDim2.new(0.025, 0, 0, 110)
FlyBtn.Text = "🚀 FLY GUI (เปิดโปรบิน)"
FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
FlyBtn.TextColor3 = Color3.new(1, 1, 1)
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.TextSize = 10
Instance.new("UICorner", FlyBtn)

-- [[ 8. ปุ่มวงกลมตกปลาทิพย์ (ขวาจอ) ]] --
local RealFishBtn = Instance.new("TextButton", sg)
RealFishBtn.Size = UDim2.new(0, 95, 0, 95)
RealFishBtn.Position = UDim2.new(0.82, 0, 0.60, 0)
RealFishBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
RealFishBtn.Text = "ตกปลา\nทิพย์"
RealFishBtn.TextColor3 = Color3.fromRGB(10, 10, 15)
RealFishBtn.Font = Enum.Font.GothamBold
RealFishBtn.TextSize = 16
RealFishBtn.Visible = false
RealFishBtn.BorderSizePixel = 0
Instance.new("UICorner", RealFishBtn).CornerRadius = UDim.new(1, 0)

-- [[ 9. คลิกทำงานปุ่มแบบนิ่ง มั่นคง ไม่บั๊กพิกัด ]] --
CastBtn.MouseButton1Click:Connect(function()
    getgenv().NWKZ_AutoCast = not getgenv().NWKZ_AutoCast
    CastBtn.Text = "AUTO CAST (เหวี่ยงเบ็ดออโต้): " .. (getgenv().NWKZ_AutoCast and "ON" or "OFF")
    CastBtn.BackgroundColor3 = getgenv().NWKZ_AutoCast and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

staticAnchor = false
AnchorBtn.MouseButton1Click:Connect(function()
    getgenv().NWKZ_Anchor = not getgenv().NWKZ_Anchor
    AnchorBtn.Text = "ANCHOR (ทำให้แถบอยู่ตรงกลาง): " .. (getgenv().NWKZ_Anchor and "ON" or "OFF")
    AnchorBtn.BackgroundColor3 = getgenv().NWKZ_Anchor and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

FishThipBtn.MouseButton1Click:Connect(function()
    getgenv().PP_FishingThipActive = not getgenv().PP_FishingThipActive
    RealFishBtn.Visible = getgenv().PP_FishingThipActive
    FishThipBtn.Text = "🟢 เปิดปิดปุ่มตกปลาทิพย์ (ขวาจอ): " .. (getgenv().PP_FishingThipActive and "ON" or "OFF")
    FishThipBtn.BackgroundColor3 = getgenv().PP_FishingThipActive and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

SkillAllBtn.MouseButton1Click:Connect(function()
    getgenv().PP_AutoSkillAll = not getgenv().PP_AutoSkillAll
    SkillAllBtn.Text = "AUTO ALL SKILLS (รวมกดทุกสกิล): " .. (getgenv().PP_AutoSkillAll and "ON" or "OFF")
    SkillAllBtn.BackgroundColor3 = getgenv().PP_AutoSkillAll and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

NoclipBtn.MouseButton1Click:Connect(function()
    getgenv().PP_Noclip = not getgenv().PP_Noclip
    NoclipBtn.Text = "NOCLIP (ทะลุกำแพง): " .. (getgenv().PP_Noclip and "ON" or "OFF")
    NoclipBtn.BackgroundColor3 = getgenv().PP_Noclip and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

-- ฟังก์ชันเสริมอื่น ๆ
SellBtn.MouseButton1Click:Connect(function()
    pcall(function() if RS:FindFirstChild("Events") and RS.Events:FindFirstChild("SellFish") then RS.Events.SellFish:FireServer("All") end end)
    SellBtn.Text = "SOLD OUT!" task.wait(0.5) SellBtn.Text = "💰 SELL ALL (ขายปลาทั้งหมด)"
end)

SpeedUpBtn.MouseButton1Click:Connect(function()
    getgenv().PP_WalkSpeed = math.clamp(getgenv().PP_WalkSpeed + 10, 16, 250)
    SpeedLabel.Text = "WALKSPEED (วิ่งเร็ว): " .. tostring(getgenv().PP_WalkSpeed)
end)

SpeedDownBtn.MouseButton1Click:Connect(function()
    getgenv().PP_WalkSpeed = math.clamp(getgenv().PP_WalkSpeed - 10, 16, 250)
    SpeedLabel.Text = "WALKSPEED (วิ่งเร็ว): " .. tostring(getgenv().PP_WalkSpeed)
end)

FlyBtn.MouseButton1Click:Connect(function()
    pcall(function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FLY-GUI-V11-205450"))() end)
    FlyBtn.Text = "🚀 FLY LOADED!" task.wait(1) FlyBtn.Text = "🚀 FLY GUI (เปิดโปรบิน)"
end)

RealFishBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if RS:FindFirstChild("Events") and RS.Events:FindFirstChild("Fishing") then RS.Events.Fishing:FireServer()
        elseif RS:FindFirstChild("Fishing") then RS.Fishing:FireServer() end
    end)
    RealFishBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    task.wait(0.05)
    RealFishBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 120)
end)

-- เปิดหน้าแรกอัตโนมัติเมื่อรันสคริปต์
showPage(Page1, Tab1Btn, 0)

-- [[ 10. ระบบย่อ/ปิด หน้าต่างหลัก ]] --
local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then TweenService:Create(Main, tweenInfoMain, {Size = MinimizedSize}):Play() Container.Visible = false MinBtn.Text = "⬜"
    else Container.Visible = true TweenService:Create(Main, tweenInfoMain, {Size = MainSize}):Play() MinBtn.Text = "—" end
end)

CloseBtn.MouseButton1Click:Connect(function()
    getgenv().NWKZ_Anchor = false getgenv().NWKZ_AutoCast = false getgenv().PP_Noclip = false getgenv().PP_FishingThipActive = false
    getgenv().PP_AutoSkillAll = false getgenv().PP_Skill_Z = false getgenv().PP_Skill_X = false getgenv().PP_Skill_C = false getgenv().PP_Skill_V = false
    RealFishBtn.Visible = false sg:Destroy()
end)

-- [[ 11. Loops เบื้องหลัง ]] --
task.spawn(function()
    while task.wait(0.1) do 
        pcall(function()
            if getgenv().PP_AutoSkillAll then
                local randomKey = skillKeys[math.random(1, #skillKeys)]
                VirtualInputManager:SendKeyEvent(true, randomKey, false, game) task.wait(0.02) VirtualInputManager:SendKeyEvent(false, randomKey, false, game)
            end
            if getgenv().PP_Skill_Z then VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Z, false, game) task.wait(0.02) VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Z, false, game) end
            if getgenv().PP_Skill_X then VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.X, false, game) task.wait(0.02) VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.X, false, game) end
            if getgenv().PP_Skill_C then VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.C, false, game) task.wait(0.02) VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.C, false, game) end
            if getgenv().PP_Skill_V then VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.V, false, game) task.wait(0.02) VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.V, false, game) end
        end)
    end
end)

RunService.Stepped:Connect(function()
    if getgenv().PP_Noclip and lp.Character then
        pcall(function()
            for _, part in ipairs(lp.Character:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end)
    end
end)

task.spawn(function()
    while task.wait(1.5) do 
        if getgenv().NWKZ_AutoCast then
            pcall(function()
                local MainGui = lp.PlayerGui:FindFirstChild("MainGui")
                local char = lp.Character
                if char and MainGui and MainGui:FindFirstChild("Fishing") then
                    if not char:GetAttribute("Fishing") and not MainGui.Fishing.Visible then 
                        if RS:FindFirstChild("Events") and RS.Events:FindFirstChild("Fishing") then RS.Events.Fishing:FireServer() end
                    end
                end
            end)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if getgenv().NWKZ_Anchor then
        pcall(function()
            local MainGui = lp.PlayerGui:FindFirstChild("MainGui")
            if MainGui and MainGui:FindFirstChild("Fishing") and MainGui.Fishing.Visible then
                local bar = MainGui.Fishing.BarFrame.Bar
                bar.Position = UDim2.new(0.5, 0, bar.Position.Y.Scale, 0)
                if RS:FindFirstChild("Fishing") then RS.Fishing:FireServer("1") end
            end
        end)
    end
    pcall(function()
        if lp.Character and lp.Character:FindFirstChild("Humanoid") then
            lp.Character.Humanoid.WalkSpeed = getgenv().PP_WalkSpeed
        end
    end)
end)

-- [[ 12. ระบบลากหน้าต่าง ]] --
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = input.Position startPos = Main.Position
        input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
    end
end)
TitleBar.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)
