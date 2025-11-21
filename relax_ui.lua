-- RELAX UI (Performance Edition)
-- Dibuat khusus untuk Delta Android (no heavy tween)

-- Parent Safety
local UIParent = nil

pcall(function() UIParent = gethui() end)
if not UIParent then
    pcall(function() UIParent = game.CoreGui end)
end
if not UIParent then
    pcall(function() UIParent = game.Players.LocalPlayer:WaitForChild("PlayerGui") end)
end
if not UIParent then
    warn("RELAX UI: Parent tidak ditemukan")
    return
end

-- Hapus UI lama jika ada
pcall(function()
    local old = UIParent:FindFirstChild("RELAX_UI")
    if old then old:Destroy() end
end)

-- Buat ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "RELAX_UI"
gui.ResetOnSpawn = false
gui.Parent = UIParent

-- FRAME UTAMA
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = gui
Main.Size = UDim2.new(0, 430, 0, 300)
Main.Position = UDim2.new(0.5, -215, 0.5, -150)
Main.BackgroundColor3 = Color3.fromRGB(45, 30, 15)
Main.BorderSizePixel = 0

-- Rounded corner
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = Main

-- TITLE BAR
local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(60, 40, 20)
Title.Text = "RELAX – Respect Loyalty X-Factor 👑"
Title.TextColor3 = Color3.fromRGB(255, 215, 85)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, 12)
corner2.Parent = Title

-- CONTENT AREA
local Body = Instance.new("Frame")
Body.Parent = Main
Body.Size = UDim2.new(1, -20, 1, -60)
Body.Position = UDim2.new(0, 10, 0, 50)
Body.BackgroundColor3 = Color3.fromRGB(30, 20, 10)

local corner3 = Instance.new("UICorner")
corner3.CornerRadius = UDim.new(0, 12)
corner3.Parent = Body

-- Label loading
local Info = Instance.new("TextLabel")
Info.Parent = Body
Info.Size = UDim2.new(1, 0, 1, 0)
Info.BackgroundTransparency = 1
Info.Text = "Menunggu fitur System Broken...\n(Loader aktif)"
Info.TextColor3 = Color3.fromRGB(255, 200, 0)
Info.TextScaled = true
Info.Font = Enum.Font.GothamBold

-- LOGO BUTTON (TOGGLE UI)
local Toggle = Instance.new("ImageButton")
Toggle.Name = "Toggle"
Toggle.Parent = gui
Toggle.Size = UDim2.new(0, 55, 0, 55)
Toggle.Position = UDim2.new(0.02, 0, 0.18, 0)
Toggle.BackgroundTransparency = 1
Toggle.Image = "rbxassetid://85365282533954"

local hidden = false

Toggle.MouseButton1Click:Connect(function()
    hidden = not hidden
    Main.Visible = not hidden
end)

print("RELAX UI Performance Loaded ✓")
