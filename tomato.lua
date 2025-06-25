local Games = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nazir99inf/GrowAGardenTomato/refs/heads/main/game.lua"))()

for PlaceID, Execute in pairs(Games) do
    if PlaceID == game.PlaceId then
        loadstring(game:HttpGet(Execute))()
    end
end
