-- [[ ⚡ ᴘᴘɪɴɢʏʏʏ ʜᴜʙ ⚡ ]]
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- ลบของเดิม
if CoreGui:FindFirstChild("ppingyyy_Hub") then CoreGui["ppingyyy_Hub"]:Destroy() end

local sg = Instance.new("ScreenGui", CoreGui)
sg.Name = "ppingyyy_Hub"

-- [Main Menu]
local Main = Instance.new("Frame", sg)
Main.Size = UDim2.new(0, 300, 0, 380); Main.Position = UDim2.new(0.5, -150, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 40); Main.Active = true; Main.Draggable = true
Main.Visible = true; Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)

-- [Logic ระบบ Tab]
local function CreateTab()
    local t = Instance.new("ScrollingFrame", Main)
    t.Size = UDim2.new(0.9, 0, 0.6, 0); t.Position = UDim2.new(0.05, 0, 0.1, 0)
    t.BackgroundTransparency = 1; t.Visible = false
    return t
end

-- สร้าง 3 Tab ปกติ + 1 Tab พิเศษด้านขวา
local Tab1 = CreateTab(); Tab1.Visible = true
local Tab2 = CreateTab()
local Tab3 = CreateTab()
local Tab4 = CreateTab() -- 🎁 Special อยู่ขวาสุด

-- [Coming Soon สำหรับ Tab 4]
local SpecialText = Instance.new("TextLabel", Tab4)
SpecialText.Size = UDim2.new(1, 0, 1, 0); SpecialText.Text = "COMING SOON"
SpecialText.TextColor3 = Color3.fromRGB(255, 215, 0); SpecialText.BackgroundTransparency = 1
SpecialText.Font = Enum.Font.GothamBold; SpecialText.TextSize = 30

-- [Tab Bar]
local TabBar = Instance.new("Frame", Main); TabBar.Size = UDim2.new(0.9, 0, 0, 40); TabBar.Position = UDim2.new(0.05, 0, 0.85, 0); TabBar.BackgroundTransparency = 1
local function MakeTabBtn(txt, t, pos)
    local b = Instance.new("TextButton", TabBar); b.Size = UDim2.new(0.22, 0, 1, 0); b.Text = txt; b.BackgroundColor3 = Color3.fromRGB(80, 80, 90)
    b.Position = pos; Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function()
        Tab1.Visible=(t==Tab1); Tab2.Visible=(t==Tab2); Tab3.Visible=(t==Tab3); Tab4.Visible=(t==Tab4)
    end)
end
-- เรียงปุ่ม 3 ปุ่ม + 1 ปุ่มขวา
MakeTabBtn("Tab 1", Tab1, UDim2.new(0,0,0,0)); MakeTabBtn("Tab 2", Tab2, UDim2.new(0.26,0,0,0)); MakeTabBtn("Tab 3", Tab3, UDim2.new(0.52,0,0,0)); MakeTabBtn("🎁", Tab4, UDim2.new(0.78,0,0,0))
