-- อัปเดต: ลบหมวดหมู่ 4 (ระบบฉุกเฉิน) ออกแล้ว
-- ล็อกการเข้าถึง: เฉพาะคนถือบัตร (คนเขียนสคริปต์) เท่านั้น!

local AuthorizedUser = "ppingyyy" -- แก้ตรงนี้เป็นชื่อในเกมมึง

local function CreateTabButton(name, posY, targetPage, isEmergency)
    if isEmergency and LocalPlayer.Name ~= AuthorizedUser then return end -- ระบบล็อก: คนอื่นห้ามเห็น
    
    local TBtn = Instance.new("TextButton")
    TBtn.Size = UDim2.new(1, 0, 0, 30)
    TBtn.Position = UDim2.new(0, 0, 0, posY)
    TBtn.Text = name
    TBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    TBtn.Font = Enum.Font.GothamBold
    TBtn.TextSize = 10
    TBtn.Parent = TabBar
    Instance.new("UICorner", TBtn).CornerRadius = UDim.new(0, 6)

    TBtn.MouseButton1Click:Connect(function()
        pcall(function() ClickSound:Play() end)
        -- สั่งปิดทุกหน้าให้หมดก่อน
        Page1_Skills.Visible = false
        Page2_Fishing.Visible = false
        Page3_Utils.Visible = false
        -- หน้า Page4_Emergency โดนลบไปแล้ว ไม่ต้องเรียกใช้
        
        targetPage.Visible = true
        for _, v in pairs(TabBar:GetChildren()) do 
            if v:IsA("TextButton") then v.BackgroundColor3 = Color3.fromRGB(25, 25, 30) end 
        end
        TBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    end)
end

-- สร้างแค่ 3 หมวดหมู่พอ
CreateTabButton("⚔️ ออโต้สกิล", 5, Page1_Skills)
CreateTabButton("🎣 ออโต้ตกปลา", 38, Page2_Fishing)
CreateTabButton("🛠️ อำนวยความสะดวก", 71, Page3_Utils)
