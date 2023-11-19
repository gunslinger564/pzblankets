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
