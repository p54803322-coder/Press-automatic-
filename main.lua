-- [[ ⚡ PPINGYYY HUB v3.2 ⭐ ]]
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("ppingyyy_Hub") then CoreGui["ppingyyy_Hub"]:Destroy() end

local sg = Instance.new("ScreenGui", CoreGui)
sg.Name = "ppingyyy_Hub"

-- [หน้าต่างหลัก]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 500, 0, 300); Main.Position = UDim2.new(0.5, -250, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Main.Active = true; Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
Main.ClipsDescendants = true

-- [ส่วนข้อความพิเศษ]
local SpecialContent = Instance.new("Frame", Main)
SpecialContent.Size = UDim2.new(0.65, 0, 0.8, 0); SpecialContent.Position = UDim2.new(0.32, 0, 0.15, 0)
SpecialContent.BackgroundTransparency = 1; SpecialContent.Visible = false

local ComingSoonText = Instance.new("TextLabel", SpecialContent)
ComingSoonText.Size = UDim2.new(1, 0, 1, 0); ComingSoonText.Text = "COMING SOON"
ComingSoonText.TextColor3 = Color3.fromRGB(255, 215, 0); ComingSoonText.BackgroundTransparency = 1
ComingSoonText.Font = Enum.Font.GothamBold; ComingSoonText.TextSize = 40

-- [หัวข้อพร้อมดาว ⭐]
local Title = Instance.new("TextLabel", Main)
Title.Text = "PPINGYYY HUB v3.2 ⭐"; Title.Size = UDim2.new(0.5, 0, 0.2, 0)
Title.TextColor3 = Color3.new(1, 1, 1); Title.BackgroundTransparency = 1; Title.Font = Enum.Font.GothamBold

-- [ปุ่ม Min/Close]
local MinBtn = Instance.new("TextButton", Main)
MinBtn.Size = UDim2.new(0, 40, 0, 30); MinBtn.Position = UDim2.new(0.82, 0, 0.05, 0)
MinBtn.Text = "-"; MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60); Instance.new("UICorner", MinBtn)

local CloseBtn = Instance.new("TextButton", Main)
CloseBtn.Size = UDim2.new(0, 40, 0, 30); CloseBtn.Position = UDim2.new(0.92, 0, 0.05, 0)
CloseBtn.Text = "X"; CloseBtn.BackgroundColor3 = Color3.fromRGB(180, 20, 20); Instance.new("UICorner", CloseBtn)

-- [ฟังก์ชันสร้างปุ่มเมนู]
local function CreateMenuBtn(txt, pos, isSpecial)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.3, 0, 0.15, 0); btn.Position = UDim2.new(0.02, 0, 0, pos)
    btn.Text = txt; btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40); Instance.new("UICorner", btn)
    
    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.32, 0, 0.17, 0)}):Play()
        task.wait(0.1); TweenService:Create(btn, TweenInfo.new(0.3), {Size = UDim2.new(0.3, 0, 0.15, 0)}):Play()
        SpecialContent.Visible = isSpecial
    end)
    return btn
end

-- ปุ่มเมนู
CreateMenuBtn("⚔️ ออโต้สกิล", 60, false)
CreateMenuBtn("🎣 ออโต้ตกปลา", 120, false)
CreateMenuBtn("🔧 อำนวยความสะดวก", 180, false)
CreateMenuBtn("❓ โหมดพิเศษ", 240, true)

-- [อนิเมชั่นหด]
MinBtn.MouseButton1Click:Connect(function()
    local isMin = Main.Size.Y.Offset < 50
    TweenService:Create(Main, TweenInfo.new(0.4, Enum.EasingStyle.Quart), {Size = isMin and UDim2.new(0, 500, 0, 300) or UDim2.new(0, 500, 0, 40)}):Play()
end)

CloseBtn.MouseButton1Click:Connect(function() sg:Destroy() end)
