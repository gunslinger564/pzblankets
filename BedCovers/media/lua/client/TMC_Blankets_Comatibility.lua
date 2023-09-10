if getActivatedMods():contains("TMC_TrueActions") then
    require "TrueActionsSetting"
    local TA_WO_List = TrueActions.WorldLieObject
    for i = 0, 84 do
        local t = TA_WO_List["furniture_bedding_01_"..i]
        if t ~= nil then
            --TODO definitions loop
            for _,name in ipairs({"bedding_black","bedding_pastelPink"}) do
                TA_WO_List[name.."_"..i] = t
            end
        end
    end
end
