require "recipecode"

function Recipe.OnGiveXP.Tailoring3(recipe, ingredients, result, player)
    player:getXp():AddXP(Perks.Tailoring, 3)
end

function RipBlanket.Oncreate(item,result,player)
     local nbr = ZombRand(2,6)
        nbr = nbr + (player:getPerkLevel(Perks.Tailoring) / 2)
        for i, nbr do
        player:getInventory():AddItem("Base.RippedSheets")
        end
end
