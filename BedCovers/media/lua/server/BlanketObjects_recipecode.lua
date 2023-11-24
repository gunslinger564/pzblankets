require "recipecode"

Recipe.OnCreateItem = Recipe.OnCreateItem or {}

function Recipe.OnGiveXP.Tailoring3(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Tailoring, 3)
end

function RipBlanket_Oncreate(item,result,player)
     local nbr = ZombRand(2,6)
        nbr = nbr + (player:getPerkLevel(Perks.Tailoring) / 2)
        for i=1, nbr do
        player:getInventory():AddItem("Base.RippedSheets")
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

function Recipe.OnCreateItem.SkullPattern(item,result,player) 
	if item:getModData().movableData ~= nil and item:getModData().movableData.bedcoverData == "None" or nil then
		item:getModData().movableData = item:getModData().movableData or {}
		local data = item:getModData().movableData.bedcoverData
		data.colourName = nil
		data.pattern = "SkullPattern"
	end
end


function Recipe.OncreateItem.dyePattern(item,result,player)
	item:getModData().movableData = item:getModData().movableData or {}
	for i,_ in pairs(BlanketObjects.OverlayColours)
		if string.find(item:getName() ,i)
			item:getModData().movableData.bedcoverData.colourName = i
		end
	end
end

function Recipe.OnCanPerform.PatternCheck(recipe, playerObj, item)
	item:getModData().movableData = item:getModData().movableData or {}
	if item:getModData().movableData.bedcoverData.pattern == "None" or nil then
		return true
	end

end

function Recipe.OnCanPerform.ColourCheck(recipe, playerObj, item)
	item:getModData().movableData = item:getModData().movableData or {}
	if item:getModData().movableData.bedcoverData.colourName = nil then
		return true
	end
end
