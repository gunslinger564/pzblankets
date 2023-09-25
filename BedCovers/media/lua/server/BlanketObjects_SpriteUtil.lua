local SpriteUtil = {}

---@param isoObject IsoObject
---@param spriteName string
---@param bedcoverData table
function SpriteUtil.addPattern(isoObject,spriteName,bedcoverData)
    local colour = bedcoverData.colourName ~= nil and BlanketObjects.OverlayColours[bedcoverData.colourName] or nil
    if colour ~= nil then
        isoObject:setOverlaySprite(spriteName,colour.r,colour.g,colour.b,0.5,true) ---fixme test
    else
        isoObject:setOverlaySprite(spriteName,true)
    end
    if not isoObject:getModData().movableData then isoObject:getModData().movableData = {} end
    isoObject:getModData().movableData.bedcoverData = bedcoverData
    isoObject:transmitModData()
end

---@param isoObject IsoObject
function SpriteUtil.removePattern(isoObject)
    if isoObject:getModData().movableData ~= nil and isoObject:getModData().movableData.bedcoverData ~= nil then
        isoObject:setOverlaySprite(nil)
        isoObject:getModData().movableData.bedcoverData = nil
        isoObject:transmitModData()
    end
end

---@param sprite IsoSprite
---@param curFacing string
---@param targetFacing string
---@return IsoSprite
function SpriteUtil.getSpriteForFacing(sprite,curFacing,targetFacing)
    if curFacing == targetFacing then return sprite end
    local offset = sprite:getProperties():Val(targetFacing .. "offset") or sprite:getProperties():Val(tostring(IsoDirections.reverse(IsoDirections[targetFacing])) .. "offset")
    if offset ~= nil then
        return getSprite(sprite:getName():gsub("%d+$",function(s) return s + offset end))
    else
        print(string.format("BedCovers: sprite %s has no matching facing for %s",tostring(sprite:getName()),tostring(targetFacing)))
        return sprite
    end
end

---@param isoObject IsoObject
---@param pattern String
---@param matchPosition boolean
---@return IsoSprite
function SpriteUtil.getMatchingSprite(isoObject,pattern,matchPosition)
    local sprite = getSprite(BlanketObjects.PatternsInfo[pattern][isoObject:getProperties():Val("BedCoverType")])
    if sprite:getID() == 20000000 then
        print(string.format("BedCovers: invalid sprite name match for sprite: %s, BedCoverType: %s ",isoObject:getTextureName(),isoObject:getProperties():Val("BedCoverType")))
        return sprite
    end
    sprite = SpriteUtil.getSpriteForFacing(sprite,sprite:getProperties():Val("Facing"),isoObject:getProperties():Val("Facing"))
    if matchPosition then
        sprite = sprite:getSpriteGrid():getSpriteFromIndex(isoObject:getSprite():getSpriteGrid():getSpriteIndex(isoObject:getSprite()))
    end
    return sprite
end

---@param object IsoObject
---@param modData table
---@return IsoSpriteGrid | nil
function SpriteUtil.getMatchingSpriteGridForData(object,modData)
    if modData.movableData == nil then return nil end
    if modData.movableData.bedcoverData == nil then return nil end
    return SpriteUtil.getMatchingSprite(object,modData.movableData.bedcoverData.pattern,false):getSpriteGrid()
end

---@param isoObject IsoObject
function SpriteUtil.OnObjectAdded(isoObject)
    if isoObject:getModData().movableData ~= nil and isoObject:getModData().movableData.bedcoverData ~= nil then
        SpriteUtil.addPattern(isoObject,SpriteUtil.getMatchingSprite(isoObject,isoObject:getModData().movableData.bedcoverData.pattern,true):getName(),isoObject:getModData().movableData.bedcoverData)
        -- isoObject:transmitUpdatedSpriteToClients()
        isoObject:transmitUpdatedSpriteToServer()
    end
end

if not isServer() then
    Events.OnObjectAdded.Add(SpriteUtil.OnObjectAdded)
end

if not isClient() then

end

---@param manager IsoSpriteManager
function SpriteUtil.OnLoadedTileDefinitions(manager)
    local Spawns = require "BlanketObjects_Spawns"

    local GroupNameToProp = {
        ["Large Fancy"] = "lFancy",
		["Large Modern"] = "lModern",
		["Large Oak"] = "lOak",
		["Blue"] = "sBlue",
		["Fancy"] = "sFancy",
		["Hospital"] = "sHospital",
		["Simple"] = "sSimple",
    }
    
    for i = 0, 83 do
        local name = "furniture_bedding_01_"..i
        local props = getSprite(name):getProperties()
        if GroupNameToProp[props:Val("GroupName")] then
            props:Set("BedCoverType",GroupNameToProp[props:Val("GroupName")],false)
            if props:Val("SpriteGridPos") == "0,0" then
                MapObjects.OnNewWithSprite(name,Spawns.OnNewWithSprite,10)
            end
        end
    end

    -- local activatedMods = getActivatedMods()
end

Events.OnLoadedTileDefinitions.Add(SpriteUtil.OnLoadedTileDefinitions)

BlanketObjects.SpriteUtil = SpriteUtil
