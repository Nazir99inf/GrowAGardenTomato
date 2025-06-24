local HttpService = game:GetService("HttpService")

local scriptUrl = "https://raw.githubusercontent.com/Nazir99inf/GrowAGardenTomato/refs/heads/main/script.lua"

-- Make HTTP GET Request
local success, response = pcall(function()
	return HttpService:GetAsync(scriptUrl)
end)

if success then
	local success2, result = pcall(function()
		return loadstring(response)
	end)

	if success2 and result then
		result() -- Execute loaded code
	else
		warn("Error loading script from response:", result)
	end
else
	warn("Failed to fetch script:", response)
end
