local getText = getText

local BlanketObjects = require "BlanketObjects"

local Util = {}

---Return combined blanket name
---@param item InventoryItem
---@return string
function Util.getBlanketName(item)
    local data = item:getModData().movableData ~= nil and item:getModData().movableData.bedcoverData or nil

    if not data then
        return getText("IGUI_BedCovers_PatternName_None", item:getName())
    elseif not data.colourName then
        return getText("IGUI_BedCovers_PatternName_Simple", item:getName(), getText("IGUI_BedCovers_Pattern_"..data.pattern))
    else
        return getText("IGUI_BedCovers_PatternName_Coloured", item:getName(), getText("IGUI_BedCovers_Pattern_"..data.pattern), getText("IGUI_BedCovers_"..data.colourName))
    end
end

---Place a curtain sheet
---@param window IsoWindow | IsoThumpable | IsoDoor | IsoObject
---@param character? IsoGameCharacter
---@param sheet InventoryItem
function Util.placeSheetCurtain(window, character, sheet)
    local squareOpposite, north, direction
    local square = window:getSquare()
    if instanceof(window, 'IsoDoor') or instanceof(window, 'IsoWindow') or instanceof(window, 'IsoThumpable') then
        squareOpposite = window:getOppositeSquare()
        north = window:getNorth()
    elseif IsoWindowFrame.isWindowFrame(window) then
        north = window:getProperties():Is(IsoFlagType.WindowN)
        local addSquare = IsoWindowFrame.getAddSheetSquare(window, character)
        squareOpposite = square ~= addSquare and addSquare or nil
    else
        error("not valid object")
    end
    if north then
        direction = "N"
        if squareOpposite == nil then
            --pass
        elseif character ~= nil then
            if character:getY() < window:getY() then
                direction = "S"
                square = squareOpposite
            end
        elseif square:getRoom() == nil and squareOpposite:getRoom() ~= nil then
            direction = "S"
            square = squareOpposite
        end
    else
        direction = "W"
        if squareOpposite == nil then
            --pass
        elseif character ~= nil then
            if character:getX() < window:getX() then
                direction = "E"
                square = squareOpposite
            end
        elseif square:getRoom() == nil and squareOpposite:getRoom() ~= nil then
            direction = "E"
            square = squareOpposite
        end
    end

    -- local sprite = BlanketObjects.SpriteUtil.getSpriteForFacing(BlanketObjects.SheetCurtainSprites[sheet:getFullType()], "E", direction)
    local offset = direction == "W" and 4 or direction == "E" and 5 or direction == "N" and 6 or direction == "S" and 7
    local spriteName = BlanketObjects.SheetCurtainSprites[sheet:getFullType()]:gsub("%d+$", function(s) return s + offset end)
    local data = sheet:getModData().movableData ~= nil and sheet:getModData().movableData.bedcoverData or nil

    local curtain = IsoCurtain.new(square:getCell(), square, spriteName, north)
    -- local curtain = IsoCurtain.new(square:getCell(), square, sprite, north, true)
    if data ~= nil then
        data.openOverlay = BlanketObjects.PatternsInfo[data.pattern]["sCurtain"]:gsub("%d+$", function(s) return s + offset end)
        data.closedOverlay = data.openOverlay:gsub("%d+$", function(s) return s - 4 end)
        local modData = curtain:getModData()
        modData.movableData = modData.movableData or {}
        modData.movableData.bedcoverData = data
    end
    square:AddSpecialTileObject(curtain)
    curtain:transmitCompleteItemToServer()

    local container = sheet:getContainer()
    if container ~= nil then
        container:Remove(sheet)
    end
    Util.onCurtainToggled(curtain)
end

---@param curtain IsoCurtain
function Util.onCurtainToggled(curtain)
    local data = curtain:getModData().movableData ~= nil and curtain:getModData().movableData.bedcoverData or nil
    if data == nil then return end
    local colour = data.colourName ~= nil and BlanketObjects.OverlayColours[data.colourName] or nil
    local spriteName
    if curtain:IsOpen() then
        spriteName = data.openOverlay
    else
        spriteName = data.closedOverlay
    end
    if colour ~= nil then
        curtain:setOverlaySprite(spriteName, colour.r, colour.g, colour.b, 0.5, true)
    else
        curtain:setOverlaySprite(spriteName, true)
    end
end

BlanketObjects.Util = Util
