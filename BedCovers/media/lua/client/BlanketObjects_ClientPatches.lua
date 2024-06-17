local BlanketObjects = require("BlanketObjects")

BlanketObjects.Patches["ISWorldObjectContextMenu.addRemoveCurtainOption"] = function ()
    local original = ISWorldObjectContextMenu.addRemoveCurtainOption
    local patch = require("placeCurtain").patchRemoveCurtain
    ISWorldObjectContextMenu.addRemoveCurtainOption = function(context, worldobjects, curtain, player)
        return patch(context, worldobjects, curtain, player) or original(context, worldobjects, curtain, player)
    end
end
