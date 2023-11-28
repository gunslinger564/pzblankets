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


function Recipe.OnCreate.dyePattern(items,result,player)
local dye = nil
local dyeT = {}
local blanket = nil
	for i=0,items:size()-1 do
		if string.find(items:get(i):getType(),"HairDye") then
			dye = items:get(i)
			table.insert(dyeT,string.match(dye:getType(),"HairDye(.+)"))
		elseif string.find(items:get(i):getType(),"Blanket") and items:get(i):getModData().movableData.bedcoverData ~= nil then
			blanket = items:get(i)
		end
	end
	if dye and blanket and not dyeT[2] then
		blanket:getModData().movableData.bedcoverData.colourName = string.match(dye:getType(),"HairDye(.+)")
	elseif blanket and dye and dyeT[2] then
		blanket:getModData().movableData.bedcoverData.colourName = Recipe.Oncreate.SortDye(dyeT)
		print("both Dyes found")
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

function Recipe.OnCreate.SewBlanket(item,result,player)
					result:getModData().movableData = result:getModData().movableData or {}
					result:getModData().movableData.bedcoverData = result:getModData().movableData.bedcoverData or {}
					result:getModData().movableData.bedcoverData.pattern = "None"
					result:getModData().movableData.bedcoverData.colourName = nil
end

---@param item InventoryItem
function Recipe.OnCreateItem.BlanketItem(item)
	local rolledCombo = BlanketObjects.PatternRolls[ZombRand(BlanketObjects.PatternRolls.n)]
	if rolledCombo ~= nil then
		item:getModData().movableData = item:getModData().movableData or {}
		item:getModData().movableData.bedcoverData = rolledCombo
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

---@param dyeTypes table
function Recipe.Oncreate.SortDye(dyeTypes)
	local dye = dyeType[1]
	local dye2 = dyeType[2]
	print(dyeType[1] .. " " .. dyeType[2])
	dyeCombos = {["BlueRed"] = {"Purple"}}
	for i,n in pairs(dyeCombos) do
		if string.find(dye, i) and string.find(dye2, i) then
		print{"dyeCombo Created"}
		return n[1]
		end
	end
end