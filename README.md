-- [[ ppingyyy Hub v1.6 - Ultimate Control Edition ]]
-- เพิ่มระบบหดหน้าต่าง และ ปุ่มลบสคริปต์ระบบคอมเฟิร์มกวนตีน เอาไปยัด GitHub เลยมึง!

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- สั่งลบ GUI ตัวเก่าออกก่อนรันตัวใหม่
if CoreGui:FindFirstChild("ppingyyy_MainHub") then
    CoreGui["ppingyyy_MainHub"]:Destroy()
end

-- สร้างหน้าต่างสกรีน GUI
local sg = Instance.new("ScreenGui")
sg.Name = "ppingyyy_MainHub"
sg.ResetOnSpawn = false
sg.Parent = CoreGui

-- ====================================================================
-- [1. หน้าต่างหลัก (Main Frame) - ขยายความสูงขึ้นเป็น 320 รองรับปุ่มควบคุม]
-- ====================================================================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 230, 0, 320)
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

-- หัวข้อสคริปต์
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.6, 0, 0, 50)
Title.Position = UDim2.new(0.05, 0, 0, 5)
Title.Text = "PPINGYYY HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- เส้นคั่นใต้ชื่อสคริปต์
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0.85, 0, 0, 1)
Divider.Position = UDim2.new(0.075, 0, 0, 50)
Divider.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
Divider.BorderSizePixel = 0
Divider.Parent = MainFrame

-- โฟลเดอร์เก็บปุ่มกดสกิล (เอาไว้ซ่อนตอนหดหน้าต่าง)
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(1, 0, 1, -50)
Container.Position = UDim2.new(0, 0, 0, 50)
Container.BackgroundTransparency = 1
Container.Parent = MainFrame

-- ====================================================================
-- [2. ระบบปุ่มหด/ขยายหน้าต่าง และ ปุ่มลบสคริปต์]
-- ====================================================================
-- ปุ่มหดหน้าต่าง [-]
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(0.7, 0, 0, 12)
MinBtn.Text = "[-]"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 12
MinBtn.Parent = MainFrame

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

local isMinimized = false
MinBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        Container.Visible = false
        MainFrame.Size = UDim2.new(0, 230, 0, 50) -- หดเหลือแต่แถบบน
        MinBtn.Text = "[+]"
    else
        Container.Visible = true
        MainFrame.Size = UDim2.new(0, 230, 0, 320) -- กางออกเท่าเดิม
        MinBtn.Text = "[-]"
    end
end)

-- ปุ่มปิด/ลบสคริปต์ [X]
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(0.83, 0, 0, 12)
CloseBtn.Text = "[X]"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0) -- สีแดง
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 12
CloseBtn.Parent = MainFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

-- หน้าต่างยืนยันการลบ (Confirm Panel)
local ConfirmPanel = Instance.new("Frame")
ConfirmPanel.Size = UDim2.new(0.9, 0, 0.75, 0)
ConfirmPanel.Position = UDim2.new(0.05, 0, 0.2, 0)
ConfirmPanel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ConfirmPanel.BorderSizePixel = 0
ConfirmPanel.Visible = false -- ซ่อนไว้ก่อน
ConfirmPanel.ZIndex = 10
ConfirmPanel.Parent = MainFrame

local ConfirmCorner = Instance.new("UICorner")
ConfirmCorner.CornerRadius = UDim.new(0, 10)
ConfirmCorner.Parent = ConfirmPanel

-- ปุ่มเขียว: แน่ใจนะ?
local SureBtn = Instance.new("TextButton")
SureBtn.Size = UDim2.new(0.85, 0, 0, 40)
SureBtn.Position = UDim2.new(0.075, 0, 0, 40)
SureBtn.Text = "มึงแน่ใจใช่ไหมว่าจะลบ?"
SureBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SureBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0) -- สีเขียว
SureBtn.Font = Enum.Font.GothamBold
SureBtn.TextSize = 12
SureBtn.ZIndex = 11
SureBtn.Parent = ConfirmPanel

local SureCorner = Instance.new("UICorner")
SureCorner.CornerRadius = UDim.new(0, 8)
SureCorner.Parent = SureBtn

-- ปุ่มแดง: ลบเลยหุบปาก!!
local ShutUpBtn = Instance.new("TextButton")
ShutUpBtn.Size = UDim2.new(0.85, 0, 0, 40)
ShutUpBtn.Position = UDim2.new(0.075, 0, 0, 110)
ShutUpBtn.Text = "ลบเลยหุบปาก"
ShutUpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ShutUpBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0) -- สีแดงเดือด
ShutUpBtn.Font = Enum.Font.GothamBold
ShutUpBtn.TextSize = 13
ShutUpBtn.ZIndex = 11
ShutUpBtn.Parent = ConfirmPanel

local ShutUpCorner = Instance.new("UICorner")
ShutUpCorner.CornerRadius = UDim.new(0, 8)
ShutUpCorner.Parent = ShutUpBtn

-- ปุ่มยกเลิก (เผื่อกดพลาด)
local CancelBtn = Instance.new("TextButton")
CancelBtn.Size = UDim2.new(0.85, 0, 0, 30)
CancelBtn.Position = UDim2.new(0.075, 0, 0, 170)
CancelBtn.Text = "เปลี่ยนใจไม่ลบละ"
CancelBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
CancelBtn.BackgroundTransparency = 1
CancelBtn.Font = Enum.Font.GothamBold
CancelBtn.TextSize = 11
CancelBtn.ZIndex = 11
CancelBtn.Parent = ConfirmPanel

-- เปิดหน้าต่างยืนยันตอนกด [X]
CloseBtn.MouseButton1Click:Connect(function()
    if isMinimized then
        -- ถ้าหดหน้าต่างอยู่ ให้กางออกก่อนเพื่อให้เห็นเมนูยืนยัน
        Container.Visible = true
        MainFrame.Size = UDim2.new(0, 230, 0, 320)
        MinBtn.Text = "[-]"
        isMinimized = false
    end
    ConfirmPanel.Visible = true
end)

CancelBtn.MouseButton1Click:Connect(function()
    ConfirmPanel.Visible = false
end)

-- ลอจิกการทำลายสคริปต์ทิ้ง (ใช้กับทั้งสองปุ่มลบ)
local function DestroyHub()
    sg:Destroy()
    print("------- ppingyyy Hub Closed and Destroyed! -------")
end

SureBtn.MouseButton1Click:Connect(DestroyHub)
ShutUpBtn.MouseButton1Click:Connect(DestroyHub)

-- ====================================================================
-- [3. ส่วนของระบบทำงาน (Logic & Random Combo)]
-- ====================================================================
local SkillStates = { Z = false, X = false, C = false, V = false }

local function PressKey(keyStr)
    local keyCode = Enum.KeyCode[keyStr]
    if keyCode then
        VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
    end
end

task.spawn(function()
    while true do
        task.wait(0.5)
        local activeSkills = {}
        for key, isEnabled in pairs(SkillStates) do
            if isEnabled and key ~= "V" then table.insert(activeSkills, key) end
        end
        if SkillStates["V"] then
            pcall(function() PressKey("V") end)
            task.wait(0.3)
        end
        if #activeSkills > 0 then
            pcall(function()
                local randomIndex = math.random(1, #activeSkills)
                PressKey(activeSkills[randomIndex])
            end)
        end
    end
end)

-- ====================================================================
-- [4. ฟังก์ชันสร้างปุ่มกดสกิล (ยัดลง Container เพื่อให้หดซ่อนได้)]
-- ====================================================================
local function CreateButton(keyName, posY)
    local Btn = Instance.new("TextButton")
    Btn.Name = "Btn_" .. keyName
    Btn.Size = UDim2.new(0.85, 0, 0, 40)
    Btn.Position = UDim2.new(0.075, 0, 0, posY)
    Btn.Text = "AUTO " .. keyName .. " : OFF"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255) 
    Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.Parent = Container -- ยัดเข้า Container

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Btn

    local TextStroke = Instance.new("UIStroke")
    TextStroke.Color = Color3.fromRGB(0, 0, 0)
    TextStroke.Thickness = 1.2
    TextStroke.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        SkillStates[keyName] = not SkillStates[keyName]
        if SkillStates[keyName] then
            Btn.Text = "AUTO " .. keyName .. " : ON"
            Btn.BackgroundColor3 = Color3.fromRGB(210, 0, 0)
            TextStroke.Enabled = false 
        else
            Btn.Text = "AUTO " .. keyName .. " : OFF"
            Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextStroke.Enabled = true 
        end
    end)
end

-- สร้างปุ่มสกิล
CreateButton("Z", 15)
CreateButton("X", 65)
CreateButton("C", 115)
CreateButton("V", 165)

print("------- ★ [ppingyyy Hub v1.6] Ultimate Version Loaded! ★ -------")
