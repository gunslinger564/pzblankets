require "TimedActions/ISAddSheetAction"

local BlanketObjects = require "BlanketObjects"

local HangBlanketAction = ISAddSheetAction:derive("HangBlanketAction")

function HangBlanketAction:new(character, item, time, sheetItem)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.item = item
    o.stopOnWalk = true
    o.stopOnRun = true
    o.maxTime = time
    o.sheetItem = sheetItem
    return o
end

function HangBlanketAction:isValid()
    if not self.character:isPrimaryHandItem(self.sheetItem) then return false end
    if IsoWindowFrame.isWindowFrame(self.item) then
        return IsoWindowFrame.getCurtain(self.item) == nil
    else
        return self.item:HasCurtains() == nil
    end
end

function HangBlanketAction:perform()
    BlanketObjects.Util.placeSheetCurtain(self.item, self.character, self.sheetItem)

    buildUtil.setHaveConstruction(self.item:getSquare(), true)
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self)
end

return HangBlanketAction
