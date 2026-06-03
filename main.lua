-- [[ ★PPINGYYY HUB★ - FLY GUI INTEGRATED VERSION ]] --
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

-- ตัวแปรระบบสกิลออโต้
getgenv().PP_AutoSkillAll = false
getgenv().PP_Skill_Z = false
getgenv().PP_Skill_X = false
getgenv().PP_Skill_C = false
getgenv().PP_Skill_V = false

local skillKeys = {Enum.KeyCode.Z, Enum.KeyCode.X, Enum.KeyCode.C, Enum.KeyCode.V}

-- [[ 1. สร้าง ScreenGui ]] --
local sg = Instance.new("ScreenGui")
sg.Name = "PPINGYYY_Hub_Ultimate"
sg.ResetOnSpawn = false

local success, err = pcall(function()
    sg.Parent = game:GetService("CoreGui")
end)
if not success then
    sg.Parent = lp:WaitForChild("PlayerGui")
end

local MainSize = UDim2.new(0, 420, 0, 180)
local MinimizedSize = UDim2.new(0, 420, 0, 40)
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

-- [[ 2. หน้าต่างหลัก พร้อมกรอบสีเขียวล้อมรอบทั้งแผ่น ]] --
local Main = Instance.new("Frame", sg)
Main.Size = MainSize
Main.Position = UDim2.new(0.1, 0, 0.3, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

local UIStroke = Instance.new("UIStroke", Main)
UIStroke.Color = Color3.fromRGB(0, 255, 150)
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

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
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, 10 + (posIndex * 40))
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(150, 150, 150)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    return btn
end

local Tab1Btn = createTabButton("🎣 ตกปลาออโต้", 0)
local Tab2Btn = createTabButton("⚡ สุ่มสกิล", 1)
local Tab3Btn = createTabButton("🛠️ อำนวยความสะดวก", 2)

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

-- [[ 5. ปุ่มหมวดหมู่ที่ 1 (ตกปลาออโต้) ]] --
local AnchorBtn = Instance.new("TextButton", Page1)
AnchorBtn.Size = UDim2.new(1, -10, 0, 35)
AnchorBtn.Position = UDim2.new(0, 0, 0, 5)
AnchorBtn.Text = "ANCHOR: OFF"
AnchorBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
AnchorBtn.TextColor3 = Color3.new(1, 1, 1)
AnchorBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", AnchorBtn)

local CastBtn = Instance.new("TextButton", Page1)
CastBtn.Size = UDim2.new(1, -10, 0, 35)
CastBtn.Position = UDim2.new(0, 0, 0, 45)
CastBtn.Text = "AUTO CAST: OFF"
CastBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CastBtn.TextColor3 = Color3.new(1, 1, 1)
CastBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CastBtn)

local SellBtn = Instance.new("TextButton", Page1)
SellBtn.Size = UDim2.new(1, -10, 0, 35)
SellBtn.Position = UDim2.new(0, 0, 0, 85)
SellBtn.Text = "SELL ALL (ขายปลาทั้งหมด)"
SellBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 40)
SellBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
SellBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SellBtn)

-- [[ 6. ปุ่มหมวดหมู่ที่ 2 (⚡ สุ่มสกิลอัตโนมัติ) ]] --
local SkillAllBtn = Instance.new("TextButton", Page2)
SkillAllBtn.Size = UDim2.new(1, -10, 0, 35)
SkillAllBtn.Position = UDim2.new(0, 0, 0, 5)
SkillAllBtn.Text = "AUTO ALL SKILLS (สุ่มกดทุกสกิล): OFF"
SkillAllBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
SkillAllBtn.TextColor3 = Color3.new(1, 1, 1)
SkillAllBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SkillAllBtn)

local function createSingleSkillBtn(keyName, posIndex, varName)
    local btn = Instance.new("TextButton", Page2)
    btn.Size = UDim2.new(0.46, 0, 0, 30)
    local xPos = (posIndex % 2 == 0) and 0 or 0.5
    local yPos = 50 + (math.floor(posIndex / 2) * 35)
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
        btn.TextColor3 = getgenv()[varName] and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
        btn.BackgroundColor3 = getgenv()[varName] and Color3.fromRGB(0, 120, 200) or Color3.fromRGB(40, 40, 45)
    end)
end

createSingleSkillBtn("Z", 0, "PP_Skill_Z")
createSingleSkillBtn("X", 1, "PP_Skill_X")
createSingleSkillBtn("C", 2, "PP_Skill_C")
createSingleSkillBtn("V", 3, "PP_Skill_V")

-- [[ 7. ปุ่มหมวดหมู่ที่ 3 (🛠️ อำนวยความสะดวก) ]] --
local NoclipBtn = Instance.new("TextButton", Page3)
NoclipBtn.Size = UDim2.new(1, -10, 0, 35)
NoclipBtn.Position = UDim2.new(0, 0, 0, 5)
NoclipBtn.Text = "NOCLIP (ทะลุกำแพง): OFF"
NoclipBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
NoclipBtn.TextColor3 = Color3.new(1, 1, 1)
NoclipBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", NoclipBtn)

local SpeedLabel = Instance.new("TextLabel", Page3)
SpeedLabel.Size = UDim2.new(1, -10, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 50)
SpeedLabel.Text = "WALKSPEED (ความเร็วเดิน): 16"
SpeedLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 12
SpeedLabel.BackgroundTransparency = 1

local SpeedUpBtn = Instance.new("TextButton", Page3)
SpeedUpBtn.Size = UDim2.new(0.46, 0, 0, 30)
SpeedUpBtn.Position = UDim2.new(0, 0, 0, 75)
SpeedUpBtn.Text = "เพิ่มความเร็วเดิน (+)"
SpeedUpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedUpBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedUpBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SpeedUpBtn)

local SpeedDownBtn = Instance.new("TextButton", Page3)
SpeedDownBtn.Size = UDim2.new(0.46, 0, 0, 30)
SpeedDownBtn.Position = UDim2.new(0.5, 0, 0, 75)
SpeedDownBtn.Text = "ลดความเร็วเดิน (-)"
SpeedDownBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedDownBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedDownBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SpeedDownBtn)

-- 🔥 ปุ่มเปิดใช้สคริปต์บิน FLY GUI ตามสั่ง
local FlyBtn = Instance.new("TextButton", Page3)
FlyBtn.Size = UDim2.new(1, -10, 0, 35)
FlyBtn.Position = UDim2.new(0, 0, 0, 115)
FlyBtn.Text = "🚀 FLY GUI (เปิดโปรบิน)"
FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
FlyBtn.TextColor3 = Color3.new(1, 1, 1)
FlyBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", FlyBtn)

-- [[ 8. ระบบสลับแท็บเมนู ]] --
local activePage = nil local activeBtn = nil
local function showPage(targetPage, targetBtn)
    if activePage == targetPage then return end
    if activeBtn then activeBtn.TextColor3 = Color3.fromRGB(150, 150, 150) activeBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 25) end
    targetBtn.TextColor3 = Color3.fromRGB(0, 255, 150) targetBtn.BackgroundColor3 = Color3.fromRGB(25, 35, 30) activeBtn = targetBtn
    if activePage then activePage.Visible = false end targetPage.Visible = true activePage = targetPage
end
Tab1Btn.MouseButton1Click:Connect(function() showPage(Page1, Tab1Btn) end)
Tab2Btn.MouseButton1Click:Connect(function() showPage(Page2, Tab2Btn) end)
Tab3Btn.MouseButton1Click:Connect(function() showPage(Page3, Tab3Btn) end)
showPage(Page1, Tab1Btn)

-- [[ 9. ฟังก์ชันปุ่มต่างๆ ]] --
local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then TweenService:Create(Main, tweenInfo, {Size = MinimizedSize}):Play() Container.Visible = false MinBtn.Text = "⬜"
    else Container.Visible = true TweenService:Create(Main, tweenInfo, {Size = MainSize}):Play() MinBtn.Text = "—" end
end)

CloseBtn.MouseButton1Click:Connect(function()
    getgenv().NWKZ_Anchor = false getgenv().NWKZ_AutoCast = false getgenv().PP_Noclip = false getgenv().PP_AutoSkillAll = false
    sg:Destroy()
end)

AnchorBtn.MouseButton1Click:Connect(function()
    getgenv().NWKZ_Anchor = not getgenv().NWKZ_Anchor
    AnchorBtn.Text = "ANCHOR: " .. (getgenv().NWKZ_Anchor and "ON" or "OFF")
    AnchorBtn.BackgroundColor3 = getgenv().NWKZ_Anchor and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

CastBtn.MouseButton1Click:Connect(function()
    getgenv().NWKZ_AutoCast = not getgenv().NWKZ_AutoCast
    CastBtn.Text = "AUTO CAST: " .. (getgenv().NWKZ_AutoCast and "ON" or "OFF")
    CastBtn.BackgroundColor3 = getgenv().NWKZ_AutoCast and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

SellBtn.MouseButton1Click:Connect(function()
    pcall(function() if RS:FindFirstChild("Events") and RS.Events:FindFirstChild("SellFish") then RS.Events.SellFish:FireServer("All") end end)
    SellBtn.Text = "SOLD OUT!" task.wait(0.5) SellBtn.Text = "SELL ALL (ขายปลาทั้งหมด)"
end)

SkillAllBtn.MouseButton1Click:Connect(function()
    getgenv().PP_AutoSkillAll = not getgenv().PP_AutoSkillAll
    SkillAllBtn.Text = "AUTO ALL SKILLS (สุ่มกดทุกสกิล): " .. (getgenv().PP_AutoSkillAll and "ON" or "OFF")
    SkillAllBtn.BackgroundColor3 = getgenv().PP_AutoSkillAll and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

NoclipBtn.MouseButton1Click:Connect(function()
    getgenv().PP_Noclip = not getgenv().PP_Noclip
    NoclipBtn.Text = "NOCLIP (ทะลุกำแพง): " .. (getgenv().PP_Noclip and "ON" or "OFF")
    NoclipBtn.BackgroundColor3 = getgenv().PP_Noclip and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

SpeedUpBtn.MouseButton1Click:Connect(function()
    getgenv().PP_WalkSpeed = math.clamp(getgenv().PP_WalkSpeed + 10, 16, 250)
    SpeedLabel.Text = "WALKSPEED (ความเร็วเดิน): " .. tostring(getgenv().PP_WalkSpeed)
end)

SpeedDownBtn.MouseButton1Click:Connect(function()
    getgenv().PP_WalkSpeed = math.clamp(getgenv().PP_WalkSpeed - 10, 16, 250)
    SpeedLabel.Text = "WALKSPEED (ความเร็วเดิน): " .. tostring(getgenv().PP_WalkSpeed)
end)

-- โหลดสคริปต์บินนอกตาม URL ที่กำหนดเมื่อกดปุ่ม
FlyBtn.MouseButton1Click:Connect(function()
    pcall(function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FLY-GUI-V11-205450"))()
    end)
    FlyBtn.Text = "🚀 FLY LOADED!"
    task.wait(1)
    FlyBtn.Text = "🚀 FLY GUI (เปิดโปรบิน)"
end)

-- [[ 10. Loops หลังบ้านระบบเบื้องหลัง ]] --
task.spawn(function()
    while task.wait(0.2) do 
        pcall(function()
            if getgenv().PP_AutoSkillAll then
                local randomKey = skillKeys[math.random(1, #skillKeys)]
                VirtualInputManager:SendKeyEvent(true, randomKey, false, game)
                task.wait(0.05)
                VirtualInputManager:SendKeyEvent(false, randomKey, false, game)
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
    while task.wait(0.45) do 
        if getgenv().NWKZ_AutoCast then
            pcall(function()
                local MainGui = lp.PlayerGui:FindFirstChild("MainGui")
                local char = lp.Character
                if char and MainGui and MainGui:FindFirstChild("Fishing") then
                    if not char:GetAttribute("Fishing") and not MainGui.Fishing.Visible then RS.Events.Fishing:FireServer() end
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

-- [[ 11. ระบบลากหน้าต่าง ]] --
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

