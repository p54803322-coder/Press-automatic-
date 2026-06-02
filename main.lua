local lp = game:GetService("Players").LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local MainGui = lp.PlayerGui:WaitForChild("MainGui")

getgenv().NWKZ_Anchor = false
getgenv().NWKZ_AutoCast = false
getgenv().PP_Noclip = false
getgenv().PP_WalkSpeed = 16
getgenv().PP_ClimbSpeed = 50

-- [[ 1. สร้าง ScreenGui ]] --
local sg = Instance.new("ScreenGui", lp.PlayerGui)
sg.Name = "PPINGYYY_Hub_v2"
sg.ResetOnSpawn = false

local MainSize = UDim2.new(0, 420, 0, 260)
local MinimizedSize = UDim2.new(0, 420, 0, 40)
local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

-- [[ 2. หน้าต่างหลัก (Main Frame) ]] --
local Main = Instance.new("Frame", sg)
Main.Size = MainSize
Main.Position = UDim2.new(0.05, 0, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 17)
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

-- เส้นนีออนด้านบน
local Line = Instance.new("Frame", Main)
Line.Size = UDim2.new(1, 0, 0, 2)
Line.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
Line.BorderSizePixel = 0

-- [[ 3. แถบหัวข้อ (Title Bar) ]] --
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(0.5, 0, 1, 0)
Title.Position = UDim2.new(0.03, 0, 0, 0)
Title.Text = "★PPINGYYY HUB★"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.BackgroundTransparency = 1

local MinBtn = Instance.new("TextButton", TitleBar)
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(0.83, 0, 0.25, 0)
MinBtn.Text = "—"
MinBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MinBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", MinBtn).CornerRadius = UDim.new(0, 5)

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(0.91, 0, 0.25, 0)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 5)

-- [[ 4. โครงสร้างแท็บ (Tab System Layout) ]] --
local Container = Instance.new("Frame", Main)
Container.Size = UDim2.new(1, 0, 1, -40)
Container.Position = UDim2.new(0, 0, 0, 40)
Container.BackgroundTransparency = 1

-- แถบซ้าย: ปุ่มเลือกหมวดหมู่ (Sidebar)
local Sidebar = Instance.new("Frame", Container)
Sidebar.Size = UDim2.new(0, 120, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
Sidebar.BorderSizePixel = 0

-- พื้นที่ขวา: แสดงเนื้อหาแต่ละหมวดหมู่ (Pages Container)
local Pages = Instance.new("Frame", Container)
Pages.Size = UDim2.new(1, -130, 1, -10)
Pages.Position = UDim2.new(0, 125, 0, 5)
Pages.BackgroundTransparency = 1

-- ฟังก์ชันสร้างปุ่มเมนูด้านซ้าย
local function createTabButton(name, text, posIndex)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Name = name
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

local Tab1Btn = createTabButton("Tab1Btn", "🎣 ตกปลาออโต้", 0)
local Tab2Btn = createTabButton("Tab2Btn", "⚡ สุ่มสกิล", 1)
local Tab3Btn = createTabButton("Tab3Btn", "🛠️ อำนวยความสะดวก", 2)

-- ฟังก์ชันสร้างหน้าเนื้อหาฝั่งขวา (CanvasGroup เพื่อให้เฟดอนิเมชั่นได้)
local function createPage()
    local page = Instance.new("CanvasGroup", Pages)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.GroupTransparency = 1 -- ซ่อนไว้ตอนแรก
    page.Visible = false
    return page
end

local Page1 = createPage() -- หมวดหมู่ 1
local Page2 = createPage() -- หมวดหมู่ 2
local Page3 = createPage() -- หมวดหมู่ 3

-- [[ 5. เนื้อหาหมวดหมู่ที่ 1: ตกปลาออโต้ ]] --
local AnchorBtn = Instance.new("TextButton", Page1)
AnchorBtn.Size = UDim2.new(1, 0, 0, 35)
AnchorBtn.Position = UDim2.new(0, 0, 0, 5)
AnchorBtn.Text = "ANCHOR (เบ็ดตรงกลาง): OFF"
AnchorBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
AnchorBtn.TextColor3 = Color3.new(1, 1, 1)
AnchorBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", AnchorBtn)

local CastBtn = Instance.new("TextButton", Page1)
CastBtn.Size = UDim2.new(1, 0, 0, 35)
CastBtn.Position = UDim2.new(0, 0, 0, 45)
CastBtn.Text = "AUTO CAST (ตกปลาอัตโนมัติ): OFF"
CastBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CastBtn.TextColor3 = Color3.new(1, 1, 1)
CastBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CastBtn)

local SellBtn = Instance.new("TextButton", Page1)
SellBtn.Size = UDim2.new(1, 0, 0, 35)
SellBtn.Position = UDim2.new(0, 0, 0, 85)
SellBtn.Text = "SELL ALL (ขายปลาทั้งหมด)"
SellBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 40)
SellBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
SellBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SellBtn)

-- [[ 6. เนื้อหาหมวดหมู่ที่ 2: สุ่มกดสกิลอัตโนมัติ ]] --
local SkillLabel = Instance.new("TextLabel", Page2)
SkillLabel.Size = UDim2.new(1, 0, 0, 30)
SkillLabel.Text = "[ ระบบสุ่มกดสกิลคอมโบ ]"
SkillLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
SkillLabel.Font = Enum.Font.GothamBold
SkillLabel.BackgroundTransparency = 1

-- มึงสามารถเอา Logic ปุ่มสุ่มกดคีย์บอร์ดที่กูเคยเขียนให้ในแชตแรกมายัดใส่เพิ่มในหน้านี้ได้เลย!

-- [[ 7. เนื้อหาหมวดหมู่ที่ 3: อำนวยความสะดวก ]] --
local NoclipBtn = Instance.new("TextButton", Page3)
NoclipBtn.Size = UDim2.new(1, 0, 0, 35)
NoclipBtn.Position = UDim2.new(0, 0, 0, 5)
NoclipBtn.Text = "NOCLIP (ทะลุกำแพง): OFF"
NoclipBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
NoclipBtn.TextColor3 = Color3.new(1, 1, 1)
NoclipBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", NoclipBtn)

-- ข้อความบอกความเร็วเดิน
local SpeedLabel = Instance.new("TextLabel", Page3)
SpeedLabel.Size = UDim2.new(1, 0, 0, 20)
SpeedLabel.Position = UDim2.new(0, 0, 0, 50)
SpeedLabel.Text = "WALKSPEED (ความเร็วเดิน): 16"
SpeedLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
SpeedLabel.Font = Enum.Font.Gotham
SpeedLabel.TextSize = 12
SpeedLabel.BackgroundTransparency = 1

-- ปุ่มจำลองปรับความเร็ว (แบบง่ายสำหรับ Delta กดเพิ่มความเร็วทีละนิด)
local SpeedUpBtn = Instance.new("TextButton", Page3)
SpeedUpBtn.Size = UDim2.new(0.48, 0, 0, 30)
SpeedUpBtn.Position = UDim2.new(0, 0, 0, 75)
SpeedUpBtn.Text = "เพิ่มความเร็วเดิน (+)"
SpeedUpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedUpBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedUpBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SpeedUpBtn)

local SpeedDownBtn = Instance.new("TextButton", Page3)
SpeedDownBtn.Size = UDim2.new(0.48, 0, 0, 30)
SpeedDownBtn.Position = UDim2.new(0.52, 0, 0, 75)
SpeedDownBtn.Text = "ลดความเร็วเดิน (-)"
SpeedDownBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
SpeedDownBtn.TextColor3 = Color3.new(1, 1, 1)
SpeedDownBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SpeedDownBtn)


-- [[ 8. ระบบ Animation ตอนจิ้มสลับหมวดหมู่ (Tab Switching Tween) ]] --
local activePage = nil
local activeBtn = nil

local function showPage(targetPage, targetBtn)
    if activePage == targetPage then return end
    
    -- ล้างสถานะปุ่มเก่า
    if activeBtn then
        TweenService:Create(activeBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(150, 150, 150), BackgroundColor3 = Color3.fromRGB(20, 20, 25)}):Play()
    end
    -- ไฮไลต์ปุ่มใหม่ที่กด
    TweenService:Create(targetBtn, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(0, 255, 150), BackgroundColor3 = Color3.fromRGB(25, 35, 30)}):Play()
    activeBtn = targetBtn

    -- อนิเมชั่นเฟดหน้าเก่าออก
    if activePage then
        local fadeOut = TweenService:Create(activePage, TweenInfo.new(0.15), {GroupTransparency = 1})
        fadeOut:Play()
        fadeOut.Completed:Connect(function()
            activePage.Visible = false
        end)
    end

    -- อนิเมชั่นเฟดหน้าใหม่เข้า (Smooth Transition)
    targetPage.Visible = true
    targetPage.GroupTransparency = 1
    TweenService:Create(targetPage, TweenInfo.new(0.25), {GroupTransparency = 0}):Play()
    activePage = targetPage
end

-- ผูกระบบจิ้มปุ่มสลับหน้า
Tab1Btn.MouseButton1Click:Connect(function() showPage(Page1, Tab1Btn) end)
Tab2Btn.MouseButton1Click:Connect(function() showPage(Page2, Tab2Btn) end)
Tab3Btn.MouseButton1Click:Connect(function() showPage(Page3, Tab3Btn) end)

showPage(Page1, Tab1Btn) -- เปิดมาให้แสดงหน้าแรกเริ่มต้น

-- [[ 9. ฟังก์ชันการทำงานปุ่มทั้งหมด ]] --

-- ย่อ/ขยาย หน้าต่างเมนู
local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(Main, tweenInfo, {Size = MinimizedSize}):Play()
        TweenService:Create(Container, tweenInfo, {BackgroundTransparency = 1}):Play()
        Container.Visible = false
        MinBtn.Text = "⬜"
    else
        Container.Visible = true
        TweenService:Create(Main, tweenInfo, {Size = MainSize}):Play()
        MinBtn.Text = "—"
    end
end)

-- ปิดสคริปต์
CloseBtn.MouseButton1Click:Connect(function()
    getgenv().NWKZ_Anchor = false
    getgenv().NWKZ_AutoCast = false
    getgenv().PP_Noclip = false
    sg:Destroy()
end)

-- ฟังก์ชันของปุ่มระบบเดิม
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
    RS.Events.SellFish:FireServer("All")
    SellBtn.Text = "SOLD OUT!"
    task.wait(0.5)
    SellBtn.Text = "SELL ALL (ขายปลาทั้งหมด)"
end)

-- ปุ่มระบบอำนวยความสะดวก (หมวด 3)
NoclipBtn.MouseButton1Click:Connect(function()
    getgenv().PP_Noclip = not getgenv().PP_Noclip
    NoclipBtn.Text = "NOCLIP (ทะลุกำแพง): " .. (getgenv().PP_Noclip and "ON" or "OFF")
    NoclipBtn.BackgroundColor3 = getgenv().PP_Noclip and Color3.fromRGB(0, 150, 80) or Color3.fromRGB(150, 0, 0)
end)

SpeedUpBtn.MouseButton1Click:Connect(function()
    getgenv().PP_WalkSpeed = math.clamp(getgenv().PP_WalkSpeed + 10, 16, 250)
    SpeedLabel.Text = "WALKSPEED (ความเร็วเดิน): " .. tostring(getgenv().PP_WalkSpeed)
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = getgenv().PP_WalkSpeed
    end
end)

SpeedDownBtn.MouseButton1Click:Connect(function()
    getgenv().PP_WalkSpeed = math.clamp(getgenv().PP_WalkSpeed - 10, 16, 250)
    SpeedLabel.Text = "WALKSPEED (ความเร็วเดิน): " .. tostring(getgenv().PP_WalkSpeed)
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = getgenv().PP_WalkSpeed
    end
end)

-- [[ 10. Loops ฟังก์ชันเบื้องหลัง (รวมระบบ Noclip/Speed) ]] --
RunService.Stepped:Connect(function()
    -- บังคับให้ทะลุกำแพงถ้าเปิดโหมด Noclip
    if getgenv().PP_Noclip and lp.Character then
        for _, part in ipairs(lp.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1.5) do
        if getgenv().NWKZ_AutoCast then
            pcall(function()
                local char = lp.Character
                if char and not char:GetAttribute("Fishing") and not MainGui.Fishing.Visible then
                    RS.Events.Fishing:FireServer()
                end
            end)
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if getgenv().NWKZ_Anchor then
        pcall(function()
            if MainGui.Fishing.Visible then
                local bar = MainGui.Fishing.BarFrame.Bar
                bar.Position = UDim2.new(0.5, 0, bar.Position.Y.Scale, 0)
                RS.Fishing:FireServer("1")
            end
        end)
    end
    -- ล็อกความเร็วเดิน/ปีนกำแพงของตัวละครตลอดเวลา
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.WalkSpeed = getgenv().PP_WalkSpeed
        lp.Character.Humanoid.ClimbSpeed = getgenv().PP_ClimbSpeed
    end
end)

-- [[ 11. ระบบ Smooth Dragging System สำหรับลากบนมือถือ ]] --
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
.
