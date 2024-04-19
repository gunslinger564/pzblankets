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
    local modData = sheet:getModData()
    local pattern = modData.movableData ~= nil and modData.movableData.bedcoverData ~= nil and modData.movableData.bedcoverData.pattern or nil

    local curtain = IsoCurtain.new(square:getCell(), square, spriteName, north)
    -- local curtain = IsoCurtain.new(square:getCell(), square, sprite, north, true)
    if pattern ~= nil then
        local overlay = BlanketObjects.PatternsInfo[pattern]["sCurtain"]:gsub("%d+$", function(s) return s + offset end)
        BlanketObjects.SpriteUtil.addPattern(curtain, overlay, modData.movableData.bedcoverData)
    end
    square:AddSpecialTileObject(curtain)
    curtain:transmitCompleteItemToServer()

    local container = sheet:getContainer()
    if container ~= nil then
        container:Remove(sheet)
    end
end

BlanketObjects.Util = Util
