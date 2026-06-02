-- [[ ⚡ PPINGYYY HUB v3.3 - ULTIMATE ALL-IN-ONE ⚡ ]]
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local TInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart)

if CoreGui:FindFirstChild("ppingyyy_Hub") then CoreGui["ppingyyy_Hub"]:Destroy() end

local sg = Instance.new("ScreenGui", CoreGui)
sg.Name = "ppingyyy_Hub"

-- [หน้าต่างหลัก]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 550, 0, 350); Main.Position = UDim2.new(0.5, -275, 0.5, -175)
Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

-- [ฟังก์ชันโกงต่างๆ (ตัวอย่างคำสั่ง)]
local Functions = {
    ["ตกปลาอัตโนมัติ"] = function() print("🐟 ตกปลาอยู่... อย่าเพิ่งกวน") end,
    ["กดสกิลอัตโนมัติ"] = function() print("⚔️ สกิลรัวๆ แล้ว!") end,
    ["ขายปลาทั้งหมด"] = function() print("💰 ขายเรียบ!") end,
    ["ทะลุกำแพง"] = function() print("🧱 เดินผ่านกำแพงแบบผี") end,
    ["ปีนกำแพง"] = function() print("🧗 ปีนยับๆ") end,
    ["บิน"] = function() print("🦅 บินละนะ") end
}

-- [สร้างปุ่มเมนู (ใส่ Loop โชว์ฟังก์ชัน)]
local i = 0
for name, func in pairs(Functions) do
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.4, 0, 0.15, 0); btn.Position = UDim2.new(0.05, 0, 0.15 + (i*0.18), 0)
    btn.Text = name; btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50); Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(func)
    i = i + 1
end

-- [ระบบเตือนลบ & ปิด]
local ConfirmBox = Instance.new("Frame", sg)
ConfirmBox.Size = UDim2.new(0, 300, 0, 150); ConfirmBox.Position = UDim2.new(0.5, -150, 0.5, -75); ConfirmBox.Visible = false
Instance.new("UICorner", ConfirmBox)
local CloseBtn = Instance.new("TextButton", Main); CloseBtn.Text = "X"; CloseBtn.Size = UDim2.new(0, 40, 0, 30); CloseBtn.Position = UDim2.new(0.92, 0, 0.05, 0)
CloseBtn.MouseButton1Click:Connect(function() ConfirmBox.Visible = true end)

local YesBtn = Instance.new("TextButton", ConfirmBox); YesBtn.Text = "ลบเลยกูไม่สน"; YesBtn.Position = UDim2.new(0.05, 0, 0.6, 0); YesBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
local NoBtn = Instance.new("TextButton", ConfirmBox); NoBtn.Text = "ไม่ลบ"; NoBtn.Position = UDim2.new(0.55, 0, 0.6, 0); NoBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
YesBtn.MouseButton1Click:Connect(function() sg:Destroy() end)
NoBtn.MouseButton1Click:Connect(function() ConfirmBox.Visible = false end)

-- [อนิเมชั่นหด]
local MinBtn = Instance.new("TextButton", Main); MinBtn.Text = "-"; MinBtn.Position = UDim2.new(0.82, 0, 0.05, 0)
MinBtn.MouseButton1Click:Connect(function()
    TweenService:Create(Main, TInfo, {Size = Main.Size.Y.Offset < 100 and UDim2.new(0, 550, 0, 350) or UDim2.new(0, 550, 0, 60)}):Play()
end)
