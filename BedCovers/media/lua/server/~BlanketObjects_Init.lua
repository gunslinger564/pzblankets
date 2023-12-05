do
    ----------------------------------------------------------------------------------------------------------------------
    --- Blanket rolls

    BlanketObjects.ItemTypes = {}
    for k,_ in pairs(BlanketObjects.TilesInfo) do
        table.insert(BlanketObjects.ItemTypes,k)
    end

    BlanketObjects.PatternRolls = {}

    local rollMax = 0
    for pattern,patternInfo in pairs(BlanketObjects.PatternsInfo) do
        if pattern == "None" then
            rollMax = rollMax + patternInfo
        else
            for col,chance in pairs(patternInfo.colourRolls) do
                local t = { pattern = pattern, colourName = col ~= "None" and col or nil }
                for i = 1, chance do
                    table.insert(BlanketObjects.PatternRolls,t)
                end
                rollMax = rollMax + chance
            end
        end
    end
    BlanketObjects.PatternRolls.n = rollMax + (rollMax % 2)

    ----------------------------------------------------------------------------------------------------------------------
    --- Patches

    for _,f in pairs(BlanketObjects.Patches) do
        f()
    end
    BlanketObjects.Patches = nil
end