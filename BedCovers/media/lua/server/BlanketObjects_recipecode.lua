require "recipecode"

Recipe.OnCreateItem = Recipe.OnCreateItem or {}
Recipe.OnTest = Recipe.OnTest or {}
Recipe.OnCreate = Recipe.OnCreate or {}

function Recipe.OnGiveXP.Tailoring3(recipe, ingredients, result, player)
	player:getXp():AddXP(Perks.Tailoring, 3)
end

function RipBlanket_OnCreate(item,result,player)
	local nbr = ZombRand(2,6)
	nbr = nbr + (player:getPerkLevel(Perks.Tailoring) / 2)
	for i=1, nbr do
		player:getInventory():AddItem("Base.RippedSheets")
	end
end

function Recipe.OnCreate.SkullPattern(item,result,player) 
	for i=0,item:size()-1 do
		if string.find(item:get(i):getType(),"Blanket") then
			item:get(i):getModData().movableData ={bedcoverData = {pattern = "SkullPattern"}}
		end
	end
end

function Recipe.OnCreate.SpiffoPattern(item,result,player)
	for i=0,item:size()-1 do
		if string.find(item:get(i):getType(),"Blanket") then
			item:get(i):getModData().movableData ={bedcoverData = {pattern = "SpiffoPattern"}}
		end
	end
end

function Recipe.OnCreate.PawsPattern(item,result,player)
	for i=0,item:size()-1 do
		if string.find(item:get(i):getType(),"Blanket") then
			item:get(i):getModData().movableData ={bedcoverData = {pattern = "PawsPattern"}}
		end
	end
end

function Recipe.OnCreate.FloralPattern(item,result,player)
	for i=0,item:size()-1 do
		if string.find(item:get(i):getType(),"Blanket") then
			item:get(i):getModData().movableData ={bedcoverData = {pattern = "FloralPattern"}}
		end
	end
end

function Recipe.OnCreate.PlanetPattern(item,result,player)
	for i=0,item:size()-1 do
		if string.find(item:get(i):getType(),"Blanket") then
			item:get(i):getModData().movableData ={bedcoverData = {pattern = "PlanetsPattern"}}
		end
	end
end


function Recipe.OnCreate.dyePattern(items,result,player)
	local dye = nil
	local blanket = nil
	for i=0,items:size()-1 do
		if string.find(items:get(i):getType(),"HairDye") then
			dye = items:get(i)
		elseif string.find(items:get(i):getType(),"Blanket") and items:get(i):getModData().movableData.bedcoverData ~= nil then
			blanket = items:get(i)
		end
	end
	if dye and blanket then
		blanket:getModData().movableData.bedcoverData.colourName = string.match(dye:getType(),"HairDye(.+)")
	end
end

function Recipe.OnCreate.dyePurple(item,result,player)
	for i=0,item:size()-1 do
		if string.find(item:get(i):getType(),"Blanket") then
			item:get(i):getModData().movableData.bedcoverData.colourName = "Purple"
		end
	end
end

function Recipe.OnCreate.RemovePattern(item,result,player)
	for i=0,item:size()-1 do
		item:get(i):getModData().movableData.bedcoverData = item:get(i):getModData().movableData.bedcoverData or {}
		if item:get(i):getModData().movableData ~= nil then
			item:get(i):getModData().movableData.bedcoverData = nil
		end
	end
end

function Recipe.OnCreate.BleachBlanket(item,result,player)
	for i=0,item:size()-1 do
		if string.find(item:get(i):getType(),"Blanket") and item:get(i):getModData().movableData.bedcoverData ~= nil then
				result:getModData().movableData = item:get(i):getModData().movableData or {}
				if (item:get(i):getModData().movableData.bedcoverData.colourName) then
					result:getModData().movableData.bedcoverData.colourName = nil
				end
		end
	end
end

function Recipe.OnCreate.SewBlanket(item,result,player)
	if result:getModData().movableData ~= nil then
        result:getModData().movableData.bedcoverData = nil
    end
end

function Recipe.OnCreate.DyeBlanket(item,result,player)
	for i=0,item:size()-1 do
		if string.find(item:get(i):getType(),"Blanket")then
			result:getModData().movableData = item:get(i):getModData().movableData
		end
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

function Recipe.OnTest.RemovePattern(item)
	
	if string.find(item:getType(), "Blanket") then
		if item:getModData().movableData ~= nil then
			return item:getModData().movableData.bedcoverData ~= nil
		else return false
		end
	end
end
