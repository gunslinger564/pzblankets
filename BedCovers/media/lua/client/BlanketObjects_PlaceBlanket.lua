local BO = BlanketObjects

---@param character IsoPlayer
---@param bed IsoObject
---@param bedSheet String
---@param tileset String
function BO.placeBedSheet(character,bed,bedSheet,tileset)
	local bedSheetItem = character:getInventory():getFirstType(bedSheet)
	if character:getInventory():RemoveOneOf(bedSheet,false) then
		local objects = ArrayList.new()
		bed:getSpriteGridObjects(objects)
		-- if objects:size() < bed:getSprite():getSpriteGrid():getSpriteCount() then return character:Say("broken bed") end --text
		local patternGrid = BlanketObjects.SpriteUtil.getMatchingSpriteGridForData(bed,bedSheetItem:getModData())
		for i = 0, objects:size()- 1 do
			local obj = objects:get(i)
			obj:setSprite(getSprite((obj:getTextureName():gsub("furniture_bedding_01",tileset,1))))
			if patternGrid ~= nil then
				BlanketObjects.SpriteUtil.addPattern(obj,patternGrid:getSpriteFromIndex(i):getName(),bedSheetItem:getModData().movableData.bedcoverData)
			end
			obj:transmitUpdatedSpriteToServer()
		end
	end
end

---@param character IsoPlayer
---@param bed IsoObject
---@param tileset string
---@param item string
function BO.removeBedSheet(character,bed,tileset,item)
	if bed:getTextureName():find(tileset) == nil then return end
	local itemObj = character:getInventory():AddItem(item)
	if itemObj ~= nil then
		if not itemObj:getModData().movableData then itemObj:getModData().movableData = {} end
		itemObj:getModData().movableData.bedcoverData = (bed:getModData().movableData or {}).bedcoverData
	end
	local objects = ArrayList.new()
	bed:getSpriteGridObjects(objects)
	for i = 0, objects:size()- 1 do
		local obj = objects:get(i)
		obj:setSprite(getSprite((obj:getTextureName():gsub(tileset,"furniture_bedding_01",1))))
		BlanketObjects.SpriteUtil.removePattern(obj)
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
		if bed_tileset == "furniture_bedding_01" and bed:getProperties():Is("BedCoverType") then
			local inventory = character:getInventory()
			for item,tileset in pairs(BO.TilesInfo) do
				if inventory:containsType(item) then
					local optionBed = context:addOption(getText("ContextMenu_BO_PlaceBedSheet",getItemNameFromFullType(item)),character,BO.placeBedSheet,bed,item,tileset)
				end
			end
		else
			for item,tileset in pairs(BO.TilesInfo) do
				if bed_tileset == tileset then
					local removeBlanket = context:addOption(getText("ContextMenu_BO_RemoveBedSheet"),character,BO.removeBedSheet,bed,tileset,item)
					break
				end
			end
		end
	end
end

Events.OnFillWorldObjectContextMenu.Add(BO.OnPreFillWorldObjectContextMenu)
