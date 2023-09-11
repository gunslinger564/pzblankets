if isClient() then return end

local Spawns = {}

local TSL
if getActivatedMods():contains("TargetSquareOnLoad") then
    TSL = require "!_TargetSquare_OnLoad"
    TSL.OnLoadCommands.setBedCovers = function(square,o) Spawns.SquareLoaded(square,o.tileset) end
end

Spawns.Settings = {
    chanceNoCovers = 8,
    chanceCoversItem = 12,
}

do
    local cal = Calendar.getInstance()
    cal:set(2023,8,9,0,0) --subtract 1 from month and date you want
    local daysDuration = 10
    local dMul = 86400000
    Spawns.Settings.BlanketCoversExtra_Start = math.floor(cal:getTimeInMillis()/dMul)*dMul
    Spawns.Settings.BlanketCoversExtra_End = Spawns.Settings.BlanketCoversExtra_Start + dMul * daysDuration
end

---@param square IsoGridSquare
---@param tileset String
function Spawns.SquareLoaded(square,tileset)
    local objects = square:getObjects()
    for i = objects:size() -1, 1, -1  do
        local obj = objects:get(i)
        if obj:getTextureName() ~= nil and obj:getTextureName():find("^furniture_bedding_01") ~= nil then
            -- print(string.format("zxLog TargetSquareOnLoad set sprite: xyz: %d,%d,%d sprite: ",square:getX(),square:getY(),square:getZ()),(obj:getTextureName():gsub("^furniture_bedding_01",tileset)))
            obj:setSprite(getSprite((obj:getTextureName():gsub("^furniture_bedding_01",tileset))))
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
        isoObject:getSquare():AddWorldInventoryItem(randItem, 0.6, 0.6, 0.16)
    else
        local grid = isoObject:getSprite():getSpriteGrid()
        for x = isoObject:getX(), isoObject:getX() + grid:getWidth()-1 do
            for y = isoObject:getY(), isoObject:getY() + grid:getHeight()-1 do
                local sq = getSquare(x,y,isoObject:getZ())
                if sq ~= nil then
                    Spawns.SquareLoaded(sq,BlanketObjects.TilesInfo[randItem])
                else
                    TSL.instance.addCommand(x,y,isoObject:getZ(), { command = "setBedCovers", tileset = BlanketObjects.TilesInfo[randItem] })
                end
            end
        end
    end
end

---Spawn blanket items!
---@param isoObject IsoObject
function Spawns.OnLoadWithSprite(isoObject)
    if isoObject:getModData().spawnedBlanket then return end
    local time = Calendar.getInstance():getTimeInMillis()
    if time > Spawns.Settings.BlanketCoversExtra_Start and time < Spawns.Settings.BlanketCoversExtra_End then
        isoObject:getModData().spawnedBlanket = true
        isoObject:transmitModData()
        local randItem = BlanketObjects.ItemTypes[ZombRand(#BlanketObjects.ItemTypes)+1]
        isoObject:getSquare():AddWorldInventoryItem(randItem, 0.6, 0.6, 0.16)
    end
end

function Spawns.OnLoadedTileDefinitions()
    local ignore = BlanketObjects.IgnoreTileList or {}
    local addOnLoad = Spawns.Settings.BlanketCoversExtra_End > Calendar.getInstance():getTimeInMillis()

    for i = 0, 83 do
        local s = "furniture_bedding_01_"..i
        if not ignore[s] and getSprite(s):getProperties():Val("SpriteGridPos") == "0,0" then
            MapObjects.OnNewWithSprite(s,Spawns.OnNewWithSprite,5)
            if addOnLoad then MapObjects.OnLoadWithSprite(s,Spawns.OnLoadWithSprite,5) end
        end
    end

end

Events.OnLoadedTileDefinitions.Add(Spawns.OnLoadedTileDefinitions)

return Spawns