if isClient() then return end

local Spawns = {}

local TSL
if getActivatedMods():contains("TargetSquareOnLoad") then
    TSL = require "!_TargetSquare_OnLoad"
    TSL.OnLoadCommands.setBedCovers = function(square,o) Spawns.SquareLoaded(square,o.tileset,o.bedcoverData) end
end

---chance is not cumulative
Spawns.Settings = {
    chanceNoCovers = 8,
    chanceCoversItem = 12,
}

---Sets square overlayDone so that the overlay is not removed. 
---This prevents LoadGridsquarePerformanceWorkaround.ItemPicker.instance.checkObject, TileOverlays.instance.updateTileOverlaySprite (from LoadGridsquarePerformanceWorkaround.LoadGridsquare).
---These shouldn't do anything on bed squares, minor setback. Can be replaced later by using the gloabl object load, not used currently because some of the bed squares can be on previously loaded chunks.
---@param square IsoGridSquare
---@param tileset String
---@param bedcoverData table
function Spawns.SquareLoaded(square,tileset,bedcoverData)
    local objects = square:getObjects()
    for i = objects:size() -1, 1, -1  do
        local obj = objects:get(i)
        if obj:getTextureName() ~= nil and obj:getTextureName():find("^furniture_bedding_01") ~= nil then
             print(string.format("zxLog TargetSquareOnLoad set sprite: xyz: %d,%d,%d sprite: ",square:getX(),square:getY(),square:getZ()),(obj:getTextureName():gsub("^furniture_bedding_01",tileset)))
            obj:setSprite(getSprite((obj:getTextureName():gsub("^furniture_bedding_01",tileset))))
            if bedcoverData ~= nil then
                BlanketObjects.SpriteUtil.addPattern(obj,BlanketObjects.SpriteUtil.getMatchingSprite(obj,bedcoverData.pattern,true):getName(),bedcoverData)
                square:setOverlayDone(true)
            end
            ---transmit?
            return
        end
    end
    -- print(string.format("zxLog TargetSquareOnLoad no object found: xyz: %d,%d,%d sprite: ",square:getX(),square:getY(),square:getZ()))
end

---@param isoObject IsoObject
function Spawns.OnNewWithSprite(isoObject)
    local rand = ZombRand(100)
    if rand < Spawns.Settings.chanceNoCovers then
        return
    end

    local randItem = BlanketObjects.ItemTypes[ZombRand(#BlanketObjects.ItemTypes)+1]
    if not TSL or rand < Spawns.Settings.chanceCoversItem then
        isoObject:getSquare():AddWorldInventoryItem(randItem, 0.5, 0.5, (isoObject:getProperties():Val("Surface") or 32) / 100 )
    else
        local patData = BlanketObjects.PatternRolls[ZombRand(BlanketObjects.PatternRolls.n)]
        local grid = isoObject:getSprite():getSpriteGrid()
        for x = isoObject:getX(), isoObject:getX() + grid:getWidth()-1 do
            for y = isoObject:getY(), isoObject:getY() + grid:getHeight()-1 do
                local sq = getSquare(x,y,isoObject:getZ())
                if sq ~= nil then
                    Spawns.SquareLoaded(sq,BlanketObjects.TilesInfo[randItem][1],patData)
                else
                    TSL.addCommand(x,y,isoObject:getZ(), { command = "setBedCovers", tileset = BlanketObjects.TilesInfo[randItem][1], bedcoverData = patData })
                end
            end
        end
    end
end

return Spawns