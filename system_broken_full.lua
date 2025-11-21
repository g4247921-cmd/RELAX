-- RELAX SYSTEM FULL FEATURES (Performance Build)
-- Dibuat ulang agar stabil untuk Delta Android
-- Tanpa TouchFling, Anti-Fling tetap aktif, semua fitur lengkap

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Root = Character:WaitForChild("HumanoidRootPart")

print("RELAX Features Loaded ✓")

----------------------------------------------------
-- ANTI FLING
----------------------------------------------------
local function AntiFling()
	task.spawn(function()
		while true do
			task.wait(0.5)
			for _, v in pairs(Players:GetPlayers()) do
				if v ~= LocalPlayer then
					pcall(function()
						local hrp = v.Character:FindFirstChild("HumanoidRootPart")
						if hrp and hrp.Velocity.Magnitude > 200 then
							hrp.Velocity = Vector3.new(0,0,0)
							hrp.RotVelocity = Vector3.new(0,0,0)
						end
					end)
				end
			end
		end
	end)
end
AntiFling()

----------------------------------------------------
-- REJOIN
----------------------------------------------------
_G.REJOIN = function()
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

----------------------------------------------------
-- SERVER HOP
----------------------------------------------------
_G.SERVERHOP = function()
	local servers = {}
	local Http = game:GetService("HttpService")
	local req = game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")
	local data = Http:JSONDecode(req)
	for _, v in pairs(data.data) do
		if tonumber(v.playing) < tonumber(v.maxPlayers) then
			TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id, LocalPlayer)
			break
		end
	end
end

----------------------------------------------------
-- WALKSPEED / JUMPPOWER
----------------------------------------------------
_G.SetWalk = function(num)
	pcall(function()
		Character.Humanoid.WalkSpeed = num
	end)
end

_G.SetJump = function(num)
	pcall(function()
		Character.Humanoid.JumpPower = num
	end)
end

----------------------------------------------------
-- FLY
----------------------------------------------------
_G.FLYING = false
_G.StartFly = function(speed)
	_G.FLYING = true
	local BodyGyro = Instance.new("BodyGyro", Root)
	local BodyVel = Instance.new("BodyVelocity", Root)
	BodyGyro.P = 9e4
	BodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)
	BodyVel.Velocity = Vector3.new(0,0,0)
	BodyVel.MaxForce = Vector3.new(9e9,9e9,9e9)

	while _G.FLYING and task.wait() do
		local cam = workspace.CurrentCamera.CFrame
		BodyGyro.CFrame = cam
		BodyVel.Velocity = cam.LookVector * speed
	end

	BodyGyro:Destroy()
	BodyVel:Destroy()
end

_G.StopFly = function()
	_G.FLYING = false
end

----------------------------------------------------
-- NOCLIP
----------------------------------------------------
_G.NOCLIP = false
task.spawn(function()
	while task.wait() do
		if _G.NOCLIP then
			pcall(function()
				for _, v in pairs(Character:GetDescendants()) do
					if v:IsA("BasePart") then v.CanCollide = false end
				end
			end)
		end
	end
end)

----------------------------------------------------
-- ANTI VOID
----------------------------------------------------
task.spawn(function()
	while task.wait(0.2) do
		if Character.HumanoidRootPart.Position.Y < -5 then
			Character.HumanoidRootPart.CFrame = CFrame.new(0,5,0)
		end
	end
end)

----------------------------------------------------
-- AUTO RESPAWN
----------------------------------------------------
LocalPlayer.CharacterAdded:Connect(function(char)
	Character = char
	Humanoid = char:WaitForChild("Humanoid")
	Root = char:WaitForChild("HumanoidRootPart")
end)

----------------------------------------------------
-- TELEPORT (SIMPLE)
----------------------------------------------------
_G.TP = function(x,y,z)
	Root.CFrame = CFrame.new(x,y,z)
end

----------------------------------------------------
-- PUSH TOOL (Jika ada tool)
----------------------------------------------------
_G.Push = function()
	local tool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
	if tool then
		for _, p in pairs(Players:GetPlayers()) do
			if p ~= LocalPlayer and p.Character then
				local hrp = p.Character:FindFirstChild("HumanoidRootPart")
				if hrp then
					Root.CFrame = hrp.CFrame * CFrame.new(0,0,-2)
				end
			end
		end
	end
end

----------------------------------------------------
-- ESP (simple)
----------------------------------------------------
function _G.ESP(on)
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer then
			pcall(function()
				if on then
					if not p.Character:FindFirstChild("ESP") then
						local hl = Instance.new("Highlight", p.Character)
						hl.Name = "ESP"
						hl.FillColor = Color3.fromRGB(255, 200, 0)
						hl.FillTransparency = 0.5
						hl.OutlineColor = Color3.fromRGB(255,255,255)
					end
				else
					local esp = p.Character:FindFirstChild("ESP")
					if esp then esp:Destroy() end
				end
			end)
		end
	end
end

----------------------------------------------------
-- CHAT BYPASS (simple)
----------------------------------------------------
_G.Say = function(txt)
	game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(txt,"All")
end

----------------------------------------------------
-- TARGET SYSTEM (simple)
----------------------------------------------------
_G.Target = nil

_G.SetTarget = function(name)
	for _, p in pairs(Players:GetPlayers()) do
		if p.Name:lower():sub(1,#name) == name:lower() then
			_G.Target = p
			return true
		end
	end
	return false
end

_G.ViewTarget = function()
	if _G.Target and _G.Target.Character then
		workspace.CurrentCamera.CameraSubject = _G.Target.Character:FindFirstChild("Humanoid")
	end
end

_G.UnView = function()
	workspace.CurrentCamera.CameraSubject = LocalPlayer.Character:FindFirstChild("Humanoid")
end

_G.Bring = function()
	if _G.Target and _G.Target.Character then
		local hrp = _G.Target.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			Root.CFrame = hrp.CFrame * CFrame.new(0,0,3)
		end
	end
end

----------------------------------------------------
-- END
----------------------------------------------------
print("RELAX Features FULL Loaded ✓")
