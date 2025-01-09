require "TimedActions/ISAddSheetAction"

local BlanketObjects = require "BlanketObjects"

local UnhangBlanketAction = ISRemoveSheetAction:derive("UnhangBlanketAction")

function UnhangBlanketAction:new(character, curtain, time, itemType)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character
    o.item = curtain
    o.itemType = itemType
    o.stopOnWalk = true
    o.stopOnRun = true
    if o.character:isTimedActionInstant() then o.maxTime = 1 else o.maxTime = time end
    return o
end

function UnhangBlanketAction:isValid()
    return self.item:getObjectIndex() ~= -1
end

function UnhangBlanketAction:perform()
    local item = InventoryItemFactory.CreateItem(self.itemType)
    local sheetData = self.item:getModData().movableData ~= nil and self.item:getModData().movableData.bedcoverData or nil
    local itemData = item:getModData()
    if sheetData ~= nil then
        sheetData.openOverlay = nil
        sheetData.closedOverlay = nil
    end
    if sheetData ~= nil or itemData.movableData ~= nil then
        itemData.movableData = itemData.movableData or {}
        itemData.movableData.bedcoverData = sheetData
    end

    self.item:getSquare():transmitRemoveItemFromSquare(self.item)
    self.character:getInventory():AddItem(item)

    ISBaseTimedAction.perform(self)
end

BlanketObjects.UnhangBlanketAction = UnhangBlanketAction

return UnhangBlanketAction
