local BO = BlanketObjects

function BO.placeBedSheet(character,bed,bedSheet)
	local objects = ArrayList.new()
	bed:getSpriteGridObjects(objects)
	-- if objects:size() < bed:getSprite():getSpriteGrid():getSpriteCount() then return player:Say("broken") end --text
	
		for i = 0, objects:size()- 1 do
			local obj = objects:get(i)
			if bedSheet:getType() == "BlackBlanket" then
				obj:setSprite((obj:getTextureName():gsub("furniture_bedding_01","bedding_black",1)))
				character:getInventory():Remove(bedSheet)
			elseif bedSheet:getType() == "PinkBlanket" then
				obj:setSprite((obj:getTextureName():gsub("furniture_bedding_01","bedding_pastelPink",1)))
				character:getInventory():Remove(bedSheet)
			elseif bedSheet:getType() == "BlueBlanket" then
				obj:setSprite((obj:getTextureName():gsub("furniture_bedding_01","bedding_lightBlue",1)))
				character:getInventory():Remove(bedSheet)
			elseif bedSheet:getType() == "GreenBlanket" then
				obj:setSprite((obj:getTextureName():gsub("furniture_bedding_01","bedding_lightGreen",1)))
				character:getInventory():Remove(bedSheet)

			else
			end
				obj:transmitUpdatedSpriteToServer()
		end		
end
function BO.removeBedSheet(character,bed)
	local objects = ArrayList.new()
	bed:getSpriteGridObjects(objects)
			for i = 0, objects:size()- 1 do
			local obj = objects:get(i)
				if obj:getTextureName():find("black",1) then
					obj:setSprite((obj:getTextureName():gsub("bedding_black","furniture_bedding_01",1)))
					character:getInventory():AddItem("Blankets.BlackBlanket")
				elseif obj:getTextureName():find("Pink",1) then
					obj:setSprite((obj:getTextureName():gsub("bedding_pastelPink","furniture_bedding_01",1)))
					character:getInventory():AddItem("Blankets.PinkBlanket")
				elseif obj:getTextureName():find("Blue",1) then
					obj:setSprite((obj:getTextureName():gsub("bedding_lightBlue","furniture_bedding_01",1)))
					character:getInventory():AddItem("Blankets.BlueBlanket")
				elseif obj:getTextureName():find("Green",1) then
					obj:setSprite((obj:getTextureName():gsub("bedding_lightGreen","furniture_bedding_01",1)))
					character:getInventory():AddItem("Blankets.GreenBlanket")
				else
				end
					obj:transmitUpdatedSpriteToServer()
			end
end

function BO.OnPreFillWorldObjectContextMenu(player, context, worldobjects, test)
	if test and ISWorldObjectContextMenu.Test then return true end
	
	local bed = nil
	local character = getSpecificPlayer(player)
	local bedSheet = nil
	
	for key, value in pairs(worldobjects) do
		if value:getProperties():Is(IsoFlagType.bed) then
			bed = value
		end
	end				
	for i = 0, character:getInventory():getItems():size() - 1 do
		bedSheet = character:getInventory():getItems():get(i)
	end	
	
	if bedSheet:getType():find("Blanket",1) and bed ~= nil and bedSheet ~= nil then 
		print(bed:getTextureName())
		local optionBed = context:addOption(getText("ContextMenu_BO_PlaceBedSheet"),character,BO.placeBedSheet,bed,bedSheet)

		
	end
	
	  if bed ~= nil then
        if bed:getTextureName():find("^furniture",1) then
            
        elseif bed:getTextureName():find("black",1) or bed:getTextureName():find("Blue",1) or bed:getTextureName():find("Pink",1) or bed:getTextureName():find("Green",1) then
            local removeBlanket = context:addOption(getText("ContextMenu_BO_RemoveBedSheet"),character,BO.removeBedSheet,bed)
        end
    end

	--DEBUG
	-- bedSheet = InventoryItemFactory.CreateItem("FancyBlack") or InventoryItemFactory.CreateItem("Nails")
	--bedSheet = character:getInventory():AddItem("FancyBlack") or character:getInventory():AddItem("Nails")
	--local optionBed = context:addOption(getText("ContextMenu_BO_PlaceBedSheet").."Debug",character,BO.placeBedSheet,bed,bedSheet)
	
end

Events.OnFillWorldObjectContextMenu.Add(BO.OnPreFillWorldObjectContextMenu)

return BO

--[[ Notes
getPlayer():getInventory():AddItem('Moveables.Moveable'):ReadFromWorldSprite('guns_bedcovers_01_40')
getPlayer():getInventory():AddItem('Moveables.Moveable'):ReadFromWorldSprite('furniture_bedding_01_40')

		--- attached test
		
		-- local spriteWithSheet = getSprite((obj:getTextureName():gsub("furniture_bedding","guns_bedcovers",1))):newInstance()
		-- local attached = obj:getAttachedAnimSprite()
		-- if not attached then
		-- 	attached = ArrayList.new(4)
		-- 	obj:setAttachedAnimSprite(attached)
		-- end
		-- attached:add(spriteWithSheet)


]]

