local BO = BlanketObjects

---@param character IsoPlayer
---@param bed IsoObject
---@param bedSheet String
---@param tileset String
function BO.placeBedSheet(character,bed,bedSheet,tileset)
	print("placeBedSheet attempt")
	local bedSheetItem = character:getInventory():getFirstType(bedSheet)
	if character:getInventory():RemoveOneOf(bedSheet,false) then
		print("placeBedSheet removeing inventory item attempt")
		local objects = ArrayList.new()
		bed:getSpriteGridObjectsIncludingSelf(objects)

		--broken code
		--local patternGrid = BlanketObjects.SpriteUtil.getMatchingSpriteGridForData(bed,bedSheetItem:getModData())


		for i = 0, objects:size()- 1 do
			local obj = objects:get(i)
			local newName = obj:getTextureName():gsub("furniture_bedding_01",tileset,1)
			local newSprite = getSprite(newName)
			obj:addAttachedAnimSprite(newSprite)

			--broken code
		--	if patternGrid ~= nil then
		--		BlanketObjects.SpriteUtil.addPattern(obj,patternGrid:getSpriteFromIndex(i):getName(),bedSheetItem:getModData().movableData.bedcoverData)
		--	end
		
			obj:transmitUpdatedSpriteToServer()
		end
	end
end

---@param character IsoPlayer
---@param bed IsoObject
---@param tileset string
---@param item string
function BO.removeBedSheet(character,bed,tileset,item)
	--if bed:getTextureName():find(tileset) == nil then return end
	local itemObj = instanceItem(item)
	character:getInventory():addItem(itemObj)
	if itemObj ~= nil then
		if not itemObj:getModData().movableData then itemObj:getModData().movableData = {} end
		itemObj:getModData().movableData.bedcoverData = (bed:getModData().movableData or {}).bedcoverData
	end
	local objects = ArrayList.new()
	bed:getSpriteGridObjectsIncludingSelf(objects)
	for i = 0, objects:size()- 1 do
		local obj = objects:get(i)
		obj:clearAttachedAnimSprite()
		obj:transmitUpdatedSpriteToServer()
	end
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
		local bed_tileset = bed:getTextureName():match("(.+)_%d+$")
		print(bed_tileset)
		print("Attached Sprite Count:  "..bed:getAttachedAnimSpriteCount())
		if bed_tileset == "furniture_bedding_01" and bed:getProperties():Is("BedCoverType") and bed:getAttachedAnimSpriteCount() == 0 then
			local inventory = character:getInventory()
			for item,tileset in pairs(BO.TilesInfo) do
				if inventory:containsType(item) then
					local optionBed = context:addOption(getText("ContextMenu_BO_PlaceBedSheet",getItemNameFromFullType(item)),character,BO.placeBedSheet,bed,item,tileset)
				end
			end
		elseif bed_tileset == "furniture_bedding_01" and bed:getProperties():Is("BedCoverType") and bed:getAttachedAnimSpriteCount() >0  then
			local sprites = bed:getAttachedAnimSprite()
			local item
			local tileset
			for pickItem,pickTileset in pairs(BO.TilesInfo)do
				for i = 0, sprites:size()-1 do
					local spriteName = sprites:get(i):getName()
					spriteName = spriteName:gsub(spriteName:sub(-2),"")
					if string.find(spriteName,pickTileset) then
						item = pickItem
					end
				end
			end
			local removeBlanket = context:addOption(getText("ContextMenu_BO_RemoveBedSheet"),character,BO.removeBedSheet,bed,nil,item)
		end
	end
end

Events.OnFillWorldObjectContextMenu.Add(BO.OnPreFillWorldObjectContextMenu)

