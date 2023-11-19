BlanketObjects = {}
BlanketObjects.Patches = {}
BlanketObjects.TextureTilesInfo = {}
BlanketObjects.TilesInfo = {
    ["Blankets.BlackBlanket"] = {"bedding_black"},
    ["Blankets.PinkBlanket"] = {"bedding_pastelPink"},
    ["Blankets.BlueBlanket"] = {"bedding_lightBlue"},
    ["Blankets.GreenBlanket"] = {"bedding_lightGreen"},
    ["Blankets.GreyBlanket"] = {"bedding_grey"},
    ["Blankets.RedBlanket"] = {"bedding_red"},
    ["Blankets.YellowBlanket"] = {"bedding_yellow"},
    ["Blankets.PurpleBlanket"] = {"bedding_purple"},
    ["Blankets.MilitaryGreenBlanket"] = {"bedding_militaryGreen"},
    ["Blankets.DarkBlueBlanket"] = {"bedding_darkBlue"},
}

for index,val in pairs(BlanketObjects.TilesInfo) do
 newName = index .. "WithSkulls"
BlanketObjects.TextureTilesInfo[newName] = {val[1],"skull_pattern"}
end  
for index,val in pairs(BlanketObjects.TextureTilesInfo) do
BlanketObjects.TilesInfo[index] = {val[1],val[2]}
end

BlanketObjects.PatternsInfo = {
    SkullPattern = {
        colourRolls = {
            Red = 10,
            Purple = 3,
            Yellow = 2,
            PaintTurquoise = 1,
            None = 10,
        },
        lFancy      = "bedding_skull_pattern_4",
        lModern     = "bedding_skull_pattern_16",
        lOak        = "bedding_skull_pattern_40",
        sBlue       = "bedding_skull_pattern_8",
        sFancy      = "bedding_skull_pattern_0",
        sHospital   = "bedding_skull_pattern_64",
        sSimple     = "bedding_skull_pattern_32",
    },
    SpiffoPattern = {
        lFancy      = "bedding_spiffo_pattern_4",
        lModern     = "bedding_spiffo_pattern_16",
        lOak        = "bedding_spiffo_pattern_40",
        sBlue       = "bedding_spiffo_pattern_8",
        sFancy      = "bedding_spiffo_pattern_0",
        sHospital   = "bedding_spiffo_pattern_64",
        sSimple     = "bedding_spiffo_pattern_32",
	colourRolls = { None = 1,},
    },
    PawsPattern = {
        lFancy      = "bedding_paws_pattern_4",
        lModern     = "bedding_paws_pattern_16",
        lOak        = "bedding_paws_pattern_40",
        sBlue       = "bedding_paws_pattern_8",
        sFancy      = "bedding_paws_pattern_0",
        sHospital   = "bedding_paws_pattern_64",
        sSimple     = "bedding_paws_pattern_32",
	colourRolls = { None = 1,},
    },
    None = 12,
}

BlanketObjects.OverlayColours = {
    Blue    = { r = 0.00, g = 0.00, b = 1.00 },
    Green   = { r = 0.00, g = 1.00, b = 0.00 },
    Purple  = { r = 0.50, g = 0.00, b = 0.50 },
    Red     = { r = 1.00, g = 0.00, b = 0.00 },
    Yellow  = { r = 0.80, g = 0.80, b = 0.00 },

    PaintBlack 		= {r=0.20,g=0.20,b=0.20},
	PaintBlue  		= {r=0.35,g=0.35,b=0.80},
	PaintBrown 		= {r=0.45,g=0.23,b=0.11},
	PaintCyan  		= {r=0.50,g=0.80,b=0.80},
	PaintGreen 		= {r=0.41,g=0.80,b=0.41},
	PaintGrey  		= {r=0.50,g=0.50,b=0.50},
	PaintLightBlue  = {r=0.55,g=0.55,b=0.87},
	PaintLightBrown = {r=0.59,g=0.44,b=0.21},
	PaintOrange		= {r=0.79,g=0.44,b=0.19},
	PaintPink  		= {r=0.81,g=0.60,b=0.60},
	PaintPurple		= {r=0.61,g=0.40,b=0.63},
	PaintRed   		= {r=0.63,g=0.10,b=0.10},
	PaintTurquoise  = {r=0.49,g=0.70,b=0.80},
	PaintWhite 		= {r=0.92,g=0.92,b=0.92},
	PaintYellow 	= {r=0.84,g=0.78,b=0.30},

}
