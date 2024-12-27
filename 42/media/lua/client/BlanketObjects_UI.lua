BlanketObjects.Patches["ISInventoryPane.drawItemDetails"] = function()
    require "ISUI/ISInventoryPane"
    local original = ISInventoryPane.drawItemDetails

    ---@param self ISInventoryPane
    ---@param item InventoryItem | nil
    ---@param y integer
    ---@param xoff integer
    ---@param yoff integer
    ---@param red boolean
    ISInventoryPane.drawItemDetails = function(self,item,y,xoff,yoff,red)
		if not item then return end
        if item:getModule() ~= "Blankets" then return original(self,item,y,xoff,yoff,red) end

        local top = self.headerHgt + y * self.itemHgt + yoff
        local fgText = {r=0.6, g=0.8, b=0.5, a=0.6}
        local data = item:getModData().movableData ~= nil and item:getModData().movableData.bedcoverData or nil

        if not data then
            self:drawText(getText("IGUI_BedCovers_PatternName_None",item:getName()), 40 + 30 + xoff, top + (self.itemHgt - self.fontHgt) / 2, fgText.a, fgText.r, fgText.g, fgText.b, self.font)
        elseif not data.colourName then
            self:drawText(getText("IGUI_BedCovers_PatternName_Simple",item:getName(),getText("IGUI_BedCovers_Pattern_"..data.pattern)), 40 + 30 + xoff, top + (self.itemHgt - self.fontHgt) / 2, fgText.a, fgText.r, fgText.g, fgText.b, self.font)
        else
            self:drawText(getText("IGUI_BedCovers_PatternName_Coloured",item:getName(),getText("IGUI_BedCovers_Pattern_"..data.pattern),getText("IGUI_BedCovers_"..data.colourName)), 40 + 30 + xoff, top + (self.itemHgt - self.fontHgt) / 2, fgText.a, fgText.r, fgText.g, fgText.b, self.font)
        end
    end
end
