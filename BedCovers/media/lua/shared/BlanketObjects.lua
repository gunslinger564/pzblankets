BlanketObjects = {}
BlanketObjects.TextureTilesInfo = {}
BlanketObjects.TilesInfo = {
    ["Blankets.BlackBlanket"] = "bedding_black",
    ["Blankets.PinkBlanket"] = "bedding_pastelPink",
    ["Blankets.BlueBlanket"] = "bedding_lightBlue",
    ["Blankets.GreenBlanket"] = "bedding_lightGreen",
    ["Blankets.GreyBlanket"] = "bedding_grey",
    ["Blankets.RedBlanket"] = "bedding_red",
    ["Blankets.YellowBlanket"] = "bedding_yellow",
    ["Blankets.PurpleBlanket"] = "bedding_purple",
}

for index,val in pairs(BlanketObjects.TilesInfo) do
	newName = index .. "WithSkulls"
		BlanketObjects.TextureTilesInfo[newName] = "skull_pattern"
end

BlanketObjects.IgnoreTileList = {}
for i = 36, 39 do BlanketObjects.IgnoreTileList["furniture_bedding_01_"..i] = true end
for i = 56, 59 do BlanketObjects.IgnoreTileList["furniture_bedding_01_"..i] = true end
for i = 84, 87 do BlanketObjects.IgnoreTileList["furniture_bedding_01_"..i] = true end

BlanketObjects.ItemTypes = {}
for k,_ in pairs(BlanketObjects.TilesInfo) do
	table.insert(BlanketObjects.ItemTypes,k)
end
