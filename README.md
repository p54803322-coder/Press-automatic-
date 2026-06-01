-- [[ Heavyweight Fishing - Custom Skill Clicker GUI ]]
-- พัฒนาโดยเพื่อนสายกวนของมึง (ppingyyy Hub Edition)
-- รันใน Delta Executor ได้เลยไอ้เสือ!

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- ลบ GUI เก่าถ้ามีอยู่
if CoreGui:FindFirstChild("ppingyyy_SkillHub") then
    CoreGui["ppingyyy_SkillHub"]:Destroy()
end

-- สร้าง ScreenGui ยัดเข้า CoreGui (หลบระบบตรวจจับได้ดีกว่า PlayerGui)
local sg = Instance.new("ScreenGui")
sg.Name = "ppingyyy_SkillHub"
sg.ResetOnSpawn = false
sg.Parent = CoreGui

-- หน้าต่างหลัก (Main Frame) สีดำสนิทแบบดุดัน
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 310)
MainFrame.Position = UDim2.new(0.1, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- สีดำเข้ม
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- ลากไปมาบนจอมือถือได้
MainFrame.Parent = sg

-- ทำให้ขอบมนดูพรีเมียม
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- เส้นขอบเรืองแสงสีเทาเข้มตัดสไตล์ดาร์ก
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(40, 40, 45)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- หัวข้อ GUI (Title)
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "SKILL AUTO CLICK"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- ตัวจัดการเก็บสถานะเปิด/ปิดการกดสกิล
local SkillStates = {
    Z = false,
    X = false,
    C = false,
    V = false,
    B = false
}

-- ฟังก์ชันจำลองการกดปุ่มคีย์บอร์ด
local function PressKey(keyStr)
    local keyCode = Enum.KeyCode[keyStr]
    if keyCode then
        VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
        task.wait(0.05)
        VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
    end
end

-- ลูปทำงานเบื้องหลังคอยกดสกิลที่ถูกเปิดใช้งาน (รันทุกๆ 0.5 วินาทีเพื่อความเสถียร)
task.spawn(function()
    while true do
        task.wait(0.5)
        for key, enabled in pairs(SkillStates) do
            if enabled then
                pcall(function()
                    PressKey(key)
                end)
            end
        end
    end
end)

-- ฟังก์ชันสร้างปุ่มตามบรีฟเป๊ะๆ (เริ่มแรกสีขาว พอกดเปิดเป็นสีแดง ตัวอักษรสีขาวตลอด)
local function CreateSkillButton(keyName, posY)
    local Btn = Instance.new("TextButton")
    Btn.Name = "SkillBtn_" .. keyName
    Btn.Size = UDim2.new(0.85, 0, 0, 40)
    Btn.Position = UDim2.new(0.075, 0, 0, posY)
    Btn.Text = "AUTO " .. keyName .. " : OFF"
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255) -- ตัวอักษรสีขาว
    Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- เริ่มต้นสีขาวตามบรีฟ
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.Parent = MainFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Btn

    -- ใส่เส้นขอบตัวอักษรสีดำตอนปุ่มสีขาว จะได้อ่านออก
    local TextStroke = Instance.new("UIStroke")
    TextStroke.Color = Color3.fromRGB(0, 0, 0)
    TextStroke.Thickness = 1
    TextStroke.Parent = Btn

    Btn.MouseButton1Click:Connect(function()
        SkillStates[keyName] = not SkillStates[keyName]
        
        if SkillStates[keyName] then
            -- ตอนเปิดใช้งาน: ปุ่มเปลี่ยนเป็นสีแดง ตัวอักษรสีขาว
            Btn.Text = "AUTO " .. keyName .. " : ON"
            Btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0) -- สีแดง
            TextStroke.Enabled = false -- ปิดเส้นขอบตัวอักษรเพราะพื้นแดงตัดขาวชัดอยู่แล้ว
        else
            -- ตอนปิดใช้งาน: กลับไปเป็นสีขาว ตัวอักษรสีขาว (มีขอบดำ)
            Btn.Text = "AUTO " .. keyName .. " : OFF"
            Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- สีขาว
            TextStroke.Enabled = true
        end
    end)
end

-- สร้างปุ่ม Z, X, C, V, B เรียงลงมาอย่างสวยงาม
CreateSkillButton("Z", 50)
CreateSkillButton("X", 100)
CreateSkillButton("C", 150)
CreateSkillButton("V", 200)
CreateSkillButton("B", 250)

print("------- ppingyyy Custom UI Loaded Successfully! -------")
