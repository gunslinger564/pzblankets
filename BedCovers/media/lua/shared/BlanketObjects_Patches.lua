local Patches = require("BlanketObjects").Patches

Patches["toggleCurtain"] = function ()
    local onCurtainToggled = require("BlanketObjects").Util.onCurtainToggled
    local function patch (original)
        return function (curtain, character)
            original(curtain, character)
            onCurtainToggled(curtain)
        end
    end
    local function patchSilent (original)
        return function (curtain)
            original(curtain)
            onCurtainToggled(curtain)
        end
    end

    local mti = __classmetatables[IsoCurtain.class].__index
    mti.ToggleDoor = patch(mti.ToggleDoor)
    mti.ToggleDoorSilent = patchSilent(mti.ToggleDoorSilent)
end
