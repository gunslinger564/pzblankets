local BO = BlanketObjects

function BO.placeBedSheet(character,bed,bedSheet,tileset)
	if character:getInventory():RemoveOneOf(bedSheet,false) then
		local objects = ArrayList.new()
		bed:getSpriteGridObjects(objects)
		-- if objects:size() < bed:getSprite():getSpriteGrid():getSpriteCount() then return player:Say("broken") end --text
		
		for i = 0, objects:size()- 1 do
			local obj = objects:get(i)

			obj:setSprite(getSprite((obj:getTextureName():gsub("furniture_bedding_01",tileset,1))))
			if tileset[2] ~= nil then
				local patternSheet = tileset[2] .. "_" .. string.match(obj:getTextureName(),"%d+$")
				obj:setOverlaySprite(patternSheet)
				obj:getModData().patternOverlay = tileset[2]
				obj:transmitModData()
			end
			obj:transmitUpdatedSpriteToServer()
		end
	end
end

function BO.removeBedSheet(character,bed,tileset,item)
	if bed:getTextureName():find(tileset[1]) ~= nil then return end

	local objects = ArrayList.new()
	bed:getSpriteGridObjects(objects)
	for i = 0, objects:size()- 1 do
		local obj = objects:get(i)
        obj:setSprite(getSprite((obj:getTextureName():gsub(tileset[1],"furniture_bedding_01",1))))
		obj:transmitUpdatedSpriteToServer()
	end
	character:getInventory():AddItem(item)
end

function BO.OnPreFillWorldObjectContextMenu(player, context, worldobjects, test)
	if test and ISWorldObjectContextMenu.Test then return true end
	
	local bed = bed
	
	if not bed then
		for _,wo in ipairs(worldobjects) do
			if wo:getProperties():Is(IsoFlagType.bed) then
				bed = wo
			end
		end
	end
	
	if bed ~= nil then
        local character = getSpecificPlayer(player)
        local bed_tileset = bed:getTextureName():gsub("_%d+$","")
		if bed_tileset == "furniture_bedding_01" and not BO.IgnoreTileList[bed:getTextureName()] then
            local inventory = character:getInventory()
				for item,tileset in pairs(BO.TilesInfo) do
					if inventory:containsType(item) then
						local optionBed = context:addOption(getText("ContextMenu_BO_PlaceBedSheet",getItemNameFromFullType(item)),character,BO.placeBedSheet,bed,item,tileset)
					end	
				end
			
		end
		else
            for item,tileset in pairs(BO.TilesInfo) do
                if bed_tileset == tileset[1] then 
                    local removeBlanket = context:addOption(getText("ContextMenu_BO_RemoveBedSheet"),character,BO.removeBedSheet,bed,tileset,item)
			break
                end
            end
	end
end


Events.OnFillWorldObjectContextMenu.Add(BO.OnPreFillWorldObjectContextMenu)
