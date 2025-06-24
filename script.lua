-- Grow a Garden: Auto Tomato Collector Script

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")

local gui = player:WaitForChild("PlayerGui"):WaitForChild("TomatoGUI")
local toggleButton = gui:WaitForChild("ToggleButton")
local counterLabel = gui:WaitForChild("TomatoCounter")

local tomatoesFolder = workspace:WaitForChild("Tomatoes")
local autoCollect = false
local collectedCount = 0

-- 💡 Update UI Counter
local function updateCounter()
	counterLabel.Text = "Tomatoes Collected: " .. collectedCount
end

-- ✨ Collect Effect
local function playCollectEffect(tomato)
	local particle = Instance.new("ParticleEmitter")
	particle.Color = ColorSequence.new(Color3.new(1, 0, 0))
	particle.Lifetime = NumberRange.new(0.3)
	particle.Rate = 100
	particle.Speed = NumberRange.new(5)
	particle.Parent = tomato
	wait(0.3)
	particle:Destroy()
end

-- 🍅 Collect Tomato Logic
local function collectTomato(tomato)
	if tomato and tomato:IsA("BasePart") and tomato.Parent == tomatoesFolder then
		playCollectEffect(tomato)
		tomato:Destroy()
		collectedCount += 1
		updateCounter()
	end
end

-- 🔁 Auto Collector Loop
runService.RenderStepped:Connect(function()
	if not autoCollect then return end

	for _, tomato in pairs(tomatoesFolder:GetChildren()) do
		if tomato:IsA("BasePart") then
			local dist = (character.PrimaryPart.Position - tomato.Position).Magnitude
			if dist < 20 then -- within reach
				collectTomato(tomato)
			end
		end
	end
end)

-- 🎛️ Toggle Button
toggleButton.Text = "Auto Collect: OFF"
toggleButton.MouseButton1Click:Connect(function()
	autoCollect = not autoCollect
	toggleButton.Text = "Auto Collect: " .. (autoCollect and "ON" or "OFF")
end)

-- ✅ Initialize
updateCounter()
