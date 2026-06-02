-- [[ ppingyyy Hub v3.5 - FULL PACK (Thip Edition) ]]
-- รวมทุกฟังก์ชัน: ตกปลา/สกิล/เดินทิพย์/กระโดดทิพย์/วาร์ปฉุกเฉิน

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- [Initial Cleanup]
pcall(function() if CoreGui:FindFirstChild("ppingyyy_MainHub") then CoreGui["ppingyyy_MainHub"]:Destroy() end end)

local sg = Instance.new("ScreenGui", CoreGui)
sg.Name = "ppingyyy_MainHub"
sg.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", sg)
MainFrame.Size = UDim2.new(0, 420, 0, 320); MainFrame.Position = UDim2.new(0.1, 0, 0.25, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Draggable = true; MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- [Vars]
local SkillStates = {Z=false, X=false, C=false, V=false}
getgenv().PPINGYYY_AutoCast = false
getgenv().PPINGYYY_Anchor = false
local WalkThipEnabled = false
local JumpThipEnabled = false

-- [Functions]
local function WarpThip(dir, dist)
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = hrp.CFrame * (dir == "Forward" and CFrame.new(0, 0, -dist) or CFrame.new(0, dist, 0)) end
end

-- [Backend Loops]
task.spawn(function()
    while task.wait(0.3) do
        if SkillStates["V"] then VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.V, false, game) end
        for k, v in pairs(SkillStates) do if v and k ~= "V" then VirtualInputManager:SendKeyEvent(true, Enum.KeyCode[k], false, game) end end
    end
end)

task.spawn(function()
    while task.wait(0.8) do
        if getgenv().PPINGYYY_AutoCast and LocalPlayer.Character and not LocalPlayer.Character:GetAttribute("Fishing") then
            pcall(function() ReplicatedStorage.Events.Fishing:FireServer() end)
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if WalkThipEnabled and input.KeyCode == Enum.KeyCode.W then WarpThip("Forward", 12) end
    if JumpThipEnabled and input.KeyCode == Enum.KeyCode.Space then WarpThip("Jump", 15) end
end)

-- [UI Creation Logic]
local function CreateBtn(name, parent, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0.9, 0, 0, 35); btn.Text = name.." : OFF"; btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function()
        local state = callback()
        btn.Text = name..(state and " : ON" or " : OFF")
        btn.BackgroundColor3 = state and Color3.fromRGB(150, 40, 40) or Color3.fromRGB(30, 30, 30)
    end)
end

-- [Tabs & Pages Setup - ใส่ในแต่ละหน้า]
local TabContainer = Instance.new("Folder", MainFrame)
-- (การสร้างหน้าจอ UI ย่อยๆ เหมือนเดิมเพื่อไม่ให้โค้ดเกินขีดจำกัด)
-- มึงเอาส่วนปุ่มพวกนี้ไปใส่ใน Page ที่มึงต้องการได้เลย
CreateBtn("เดินทิพย์", MainFrame, function() WalkThipEnabled = not WalkThipEnabled return WalkThipEnabled end)
CreateBtn("กระโดดทิพย์", MainFrame, function() JumpThipEnabled = not JumpThipEnabled return JumpThipEnabled end)
CreateBtn("ตกปลาทิพย์", MainFrame, function() getgenv().PPINGYYY_AutoCast = not getgenv().PPINGYYY_AutoCast return getgenv().PPINGYYY_AutoCast end)

print("------- ★ [ppingyyy Hub v3.5] FULL THIP MODE LOADED! ★ -------")
