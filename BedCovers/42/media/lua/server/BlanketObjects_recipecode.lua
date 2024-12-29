require "recipecode"

Recipe.OnCreateItem = Recipe.OnCreateItem or {}
Recipe.OnTest = Recipe.OnTest or {}
Recipe.OnCreate = Recipe.OnCreate or {}



function RipBlanket_OnCreate(craftRecipeData, player)
	local nbr = ZombRand(2,6)
	nbr = nbr + (player:getPerkLevel(Perks.Tailoring) / 2)
	for i=1, nbr do
		player:getInventory():AddItem("Base.RippedSheets")
	end
end


function Recipe.OnCreate.sewPattern(craftRecipeData, player)
	local recipeName = craftRecipeData:getRecipe():getName()
	recipeName = string.gsub(recipeName, "%s+", "")
	local pattern
	for name in pairs(BlanketObjects.PatternsInfo) do
		if string.find(recipeName,name) then
			pattern = name
		end
	end
	if not pattern then return end
	local item = craftRecipeData:getFirstInputItemWithFlag("Blankets.Blanket")
	item:getModData().movableData ={bedcoverData = {pattern = pattern}}
end


function Recipe.OnCreate.dyePattern(craftRecipeData, player)
	local items = craftRecipeData:getAllConsumedItems()
	local dye = items:get(1)
	local blanket = items:get(0)

	local red = dye:getColorRed()
	local green = dye:getColorGreen()
	local blue = dye:getColorBlue()
	local itemHue = BlanketObjects.rgbToHsl(red,green,blue)

    local closestColor
    local smallestDifference = math.huge

    -- Find the closest color by checking the smallest difference in hue
	if itemHue then
		for c, value in pairs(BlanketObjects.HSLColors) do
			local difference = math.abs(itemHue - value)
			if difference < smallestDifference then
				smallestDifference = difference
				closestColor = c
			end
		end
	end

	if closestColor then
		blanket:getModData().movableData.bedcoverData.colourName = closestColor
	end
end


function Recipe.OnCreate.RemovePattern(craftRecipeData, player)
	local item = craftRecipeData:getFirstInputItemWithFlag("Blankets.Blanket")
		item:getModData().movableData.bedcoverData = item:getModData().movableData.bedcoverData or {}
		if item:getModData().movableData ~= nil then
			item:getModData().movableData.bedcoverData = nil
		end
end

function Recipe.OnCreate.BleachBlanket(craftRecipeData, player)
	local item = craftRecipeData:getFirstInputItemWithFlag("Blankets.Blanket")
	local result = craftRecipeData:getFirstCreatedItem()

		if  item:getModData() and item:getModData().movableData and item:getModData().movableData.bedcoverData then
				result:getModData().movableData = item:getModData().movableData or {}
				if (item:getModData().movableData.bedcoverData.colourName) then
					result:getModData().movableData.bedcoverData.colourName = nil
				end
		end
end

function Recipe.OnCreate.SewBlanket(craftRecipeData, player)
	local result = craftRecipeData:getFirstCreatedItem()
	if result:getModData().movableData ~= nil then
        result:getModData().movableData.bedcoverData = nil
    end
end

function Recipe.OnCreate.DyeBlanket(craftRecipeData, player)
	local item = craftRecipeData:getAllConsumedItems()
	local result
	local dye = item:get(1)
	local red = dye:getColorRed()
	local green = dye:getColorGreen()
	local blue = dye:getColorBlue()
	local itemHue = BlanketObjects.rgbToHsl(red,green,blue)

    local closestColor
    local smallestDifference = math.huge

    -- Find the closest color by checking the smallest difference in hue
	print("itemHue: "..itemHue)
	if itemHue then
		for c, value in pairs(BlanketObjects.HSLColors) do
			local difference = math.abs(itemHue - value)
			if difference < smallestDifference then
				smallestDifference = difference
				closestColor = c
			end
		end
	end
		print("closest color = " .. closestColor)
	if closestColor then
		result = instanceItem(BlanketObjects.BlanketColors[closestColor])
		print("result: "..BlanketObjects.BlanketColors[closestColor])
	end
	if result then
			result:getModData().movableData = item:get(0):getModData().movableData
			player:getInventory():AddItem(result)
	end
end

---@param item InventoryItem
function Recipe.OnCreateItem.BlanketItem(item)
	local rolledCombo = BlanketObjects.PatternRolls[ZombRand(BlanketObjects.PatternRolls.n)]
	if rolledCombo ~= nil then
		item:getModData().movableData = item:getModData().movableData or {}
		item:getModData().movableData.bedcoverData = rolledCombo
	end
end

function Recipe.OnTest.BleachBlanket(item)
	if string.find(item:getType(), "Blanket") then
		if string.find(item:getType(),"White")  then
			if item:getModData().movableData ~= nil then
				if item:getModData().movableData.bedcoverData ~= nil then
					return (item:getModData().movableData.bedcoverData.colourName ~= nil)
				else return false
				end
			else return false
			end
		else return true
		end
	else return true
	end
end

function Recipe.OnTest.ColourCheck(item)
	if string.find(item:getType(), "Blanket")  then
		if item:getModData().movableData ~= nil then
			if item:getModData().movableData.bedcoverData ~= nil then
				return (item:getModData().movableData.bedcoverData.colourName == nil and item:getModData().movableData.bedcoverData.pattern ~= nil)
			else return false
			end
		else return false
		end
		
	else return true
	end
end

function Recipe.OnTest.PatternCheck(item)
	if string.find(item:getType(), "Blanket") then
		return not (item:getModData().movableData ~= nil
		and item:getModData().movableData.bedcoverData ~= nil
		and item:getModData().movableData.bedcoverData.pattern ~= nil)
	else
		return true
	end
end

function Recipe.OnTest.RemovePattern(item, result)
	if string.find(item:getType(), "Blanket") then
		if item:getModData().movableData ~= nil then
			return item:getModData().movableData.bedcoverData ~= nil
		else return false
		end
	end
end
