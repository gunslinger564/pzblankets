local onCurtainToggled = require("BlanketObjects").Util.onCurtainToggled

local Keys = {}

---@type OnKeyPressed_Callback
Keys.OnKeyPressed = function (key)
    if key == getCore():getKey("Interact") then
        local player = getPlayer()
        if not player or player:isDead() then return end
        if MainScreen.instance:isVisible() then return end

        ---FIXME add delay
        local square = player:getSquare()
        local objects = square:getSpecialObjects()
        for i = 0, objects:size() - 1 do
            local object = objects:get(i)
            if instanceof(object, "IsoCurtain") then
                onCurtainToggled(object)
            end
        end
    end
end

Events.OnKeyPressed.Add(Keys.OnKeyPressed)

return Keys
