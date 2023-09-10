if getActivatedMods():contains("TMC_TrueActions") then
    require "TrueActionsSetting"
    local TileInfo = BlanketObjects.TilesInfo
    local TA_WO_List = TrueActions.WorldLieObject
    for i = 0, 83 do
        local t = TA_WO_List["furniture_bedding_01_"..i]
        if t ~= nil then
            for _,tileset in pairs(TileInfo) do
                TA_WO_List[tileset.."_"..i] = t
            end
        end
    end
end
