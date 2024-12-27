do
    local insert = table.insert
    local list = ProceduralDistributions.list
    local function addItems(dist,loot)
        for i = 1, #loot do
            insert(dist,loot[i])
        end
    end

    addItems(list.WardrobeWoman.junk.items,{
        "Blankets.BlackBlanket",    0.001,
        "Blankets.PinkBlanket",     0.050,
        "Blankets.BlueBlanket",     0.008,
        "Blankets.GreenBlanket",    0.008,
        "Blankets.GreyBlanket",     0.002,
        "Blankets.RedBlanket",      0.050,
        "Blankets.YellowBlanket",   0.020,
        "Blankets.PurpleBlanket",   0.010,
        "Blankets.WhiteBlanket",    0.010,
        "Blankets.MilitaryGreenBlanket",   0.001,
        "Blankets.DarkBlueBlanket", 0.010,
    })
    addItems(list.WardrobeWomanClassy.junk.items,{
        "Blankets.BlackBlanket",    0.001,
        "Blankets.PinkBlanket",     0.050,
        "Blankets.BlueBlanket",     0.008,
        "Blankets.GreenBlanket",    0.008,
        "Blankets.GreyBlanket",     0.002,
        "Blankets.RedBlanket",      0.050,
        "Blankets.YellowBlanket",   0.020,
        "Blankets.PurpleBlanket",   0.010,
        "Blankets.WhiteBlanket",    0.010,
        "Blankets.MilitaryGreenBlanket",   0.001,
        "Blankets.DarkBlueBlanket", 0.010,
    })
    addItems(list.WardrobeMan.junk.items,{
        "Blankets.BlackBlanket",    0.050,
        "Blankets.PinkBlanket",     0.001,
        "Blankets.BlueBlanket",     0.010,
        "Blankets.GreenBlanket",    0.010,
        "Blankets.GreyBlanket",     0.040,
        "Blankets.RedBlanket",      0.001,
        "Blankets.YellowBlanket",   0.001,
        "Blankets.PurpleBlanket",   0.010,
        "Blankets.WhiteBlanket",    0.010,
        "Blankets.MilitaryGreenBlanket",   0.020,
        "Blankets.DarkBlueBlanket", 0.020,
    })
    addItems(list.WardrobeManClassy.junk.items,{
        "Blankets.BlackBlanket",    0.050,
        "Blankets.PinkBlanket",     0.001,
        "Blankets.BlueBlanket",     0.010,
        "Blankets.GreenBlanket",    0.010,
        "Blankets.GreyBlanket",     0.040,
        "Blankets.RedBlanket",      0.001,
        "Blankets.YellowBlanket",   0.001,
        "Blankets.PurpleBlanket",   0.010,
        "Blankets.WhiteBlanket",    0.010,
        "Blankets.MilitaryGreenBlanket",   0.020,
        "Blankets.DarkBlueBlanket", 0.020,
    })
    addItems(list.CrateTailoring.junk.items,{
        "Blankets.BlackBlanket",    0.010,
        "Blankets.PinkBlanket",     0.010,
        "Blankets.BlueBlanket",     0.010,
        "Blankets.GreenBlanket",    0.010,
        "Blankets.GreyBlanket",     0.010,
        "Blankets.RedBlanket",      0.010,
        "Blankets.YellowBlanket",   0.010,
        "Blankets.PurpleBlanket",   0.010,
        "Blankets.WhiteBlanket",    0.010,
        "Blankets.MilitaryGreenBlanket",   0.010,
        "Blankets.DarkBlueBlanket", 0.010,
    })
    addItems(list.LaundryLoad2.junk.items,{
        "Blankets.BlackBlanket",    0.001,
        "Blankets.PinkBlanket",     0.001,
        "Blankets.BlueBlanket",     0.001,
        "Blankets.GreenBlanket",    0.001,
        "Blankets.GreyBlanket",     0.001,
        "Blankets.RedBlanket",      0.001,
        "Blankets.YellowBlanket",   0.001,
        "Blankets.PurpleBlanket",   0.001,
        "Blankets.WhiteBlanket",    0.010,
        "Blankets.MilitaryGreenBlanket",   0.0001,
        "Blankets.DarkBlueBlanket", 0.001,
    })

end