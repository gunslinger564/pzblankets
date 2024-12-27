BlanketObjects = {}
BlanketObjects.Patches = {}
BlanketObjects.TilesInfo = {
    ["Blankets.BlackBlanket"] = "bedding_black",
    ["Blankets.PinkBlanket"] = "bedding_pastelPink",
    ["Blankets.BlueBlanket"] = "bedding_lightBlue",
    ["Blankets.GreenBlanket"] = "bedding_lightGreen",
    ["Blankets.GreyBlanket"] = "bedding_grey",
    ["Blankets.RedBlanket"] = "bedding_red",
    ["Blankets.YellowBlanket"] = "bedding_yellow",
    ["Blankets.PurpleBlanket"] = "bedding_purple",
    ["Blankets.MilitaryGreenBlanket"] = "bedding_militaryGreen",
    ["Blankets.DarkBlueBlanket"] = "bedding_darkBlue",
    ["Blankets.WhiteBlanket"] = "bedding_white",
}

BlanketObjects.PatternsInfo = {
    SkullPattern = {
        colourRolls = {
            Red = 5,
            Purple = 3,
            Yellow = 2,
            Black = 5,
            PaintTurquoise = 1,
            None = 4,
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
        colourRolls = { None = 4,},
        lFancy      = "bedding_spiffo_pattern_4",
        lModern     = "bedding_spiffo_pattern_16",
        lOak        = "bedding_spiffo_pattern_40",
        sBlue       = "bedding_spiffo_pattern_8",
        sFancy      = "bedding_spiffo_pattern_0",
        sHospital   = "bedding_spiffo_pattern_64",
        sSimple     = "bedding_spiffo_pattern_32",
    },
    PawsPattern = {
        colourRolls = { None = 4,},
        lFancy      = "bedding_paws_pattern_4",
        lModern     = "bedding_paws_pattern_16",
        lOak        = "bedding_paws_pattern_40",
        sBlue       = "bedding_paws_pattern_8",
        sFancy      = "bedding_paws_pattern_0",
        sHospital   = "bedding_paws_pattern_64",
        sSimple     = "bedding_paws_pattern_32",
    },
    FloralPattern = {
        colourRolls = {
            Red = 4,
            Purple = 4,
            Yellow = 2,
            Black = 2,
            None = 4,
        },
        lFancy      = "bedding_floral_pattern_4",
        lModern     = "bedding_floral_pattern_16",
        lOak        = "bedding_floral_pattern_40",
        sBlue       = "bedding_floral_pattern_8",
        sFancy      = "bedding_floral_pattern_0",
        sHospital   = "bedding_floral_pattern_64",
        sSimple     = "bedding_floral_pattern_32",
    },
    PlanetsPattern = {
        colourRolls = { None = 4,},
        lFancy      = "bedding_planets_pattern_4",
        lModern     = "bedding_planets_pattern_16",
        lOak        = "bedding_planets_pattern_40",
        sBlue       = "bedding_planets_pattern_8",
        sFancy      = "bedding_planets_pattern_0",
        sHospital   = "bedding_planets_pattern_64",
        sSimple     = "bedding_planets_pattern_32",
    },
    None = 30,
}

BlanketObjects.OverlayColours = {
    Blue    = { r = 0.00, g = 0.00, b = 1.00 },
    Green   = { r = 0.00, g = 1.00, b = 0.00 },
    Purple  = { r = 0.50, g = 0.00, b = 0.50 },
    Red     = { r = 1.00, g = 0.00, b = 0.00 },
    Yellow  = { r = 0.80, g = 0.80, b = 0.00 },
    Black   = { r = 0.20, g = 0.20, b=  0.20 },
    Pink    = { r = 0.81, g = 0.60, b=  0.60 },
    
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

BlanketObjects.HSLColors = {
    ["Blue"]    = BlanketObjects.rgbToHsl(0.00,0.00,1.00),
    ["Green"]   = BlanketObjects.rgbToHsl(0.00,1.00,0.00),
    ["Red"]     = BlanketObjects.rgbToHsl(1.00,0.00,0.00),
    ["Purple"]  = BlanketObjects.rgbToHsl(0.50, 0, 0.50),
    ["Yellow"]  = BlanketObjects.rgbToHsl(0.80, 0.80, 0.00),
    ["Black"]   = BlanketObjects.rgbToHsl(0.20, 0.20, 0.20),
    ["Pink"]    = BlanketObjects.rgbToHsl(0.81,0.60,0.60),
    ["Orange"]	= BlanketObjects.rgbToHsl(0.79,0.44,0.19),
    ["Brown"]   = BlanketObjects.rgbToHsl(0.29,0.227,0.145),
    ["White"]   = BlanketObjects.rgbToHsl(1.00,1.00,1.00),
}
BlanketObjects.BlanketColors = {
White = Blankets.WhiteBlanket,
Black = Blankets.BlackBlanket,
Pink = Blankets.PinkBlanket,
Blue = Blankets.BlueBlanket,
Green = Blankets.GreenBlanket,
Red = Blankets.RedBlanket,
Yellow = Blankets.YellowBlanket,
Purple = Blankets.PurpleBlanket,
Grey = Blankets.GreyBlanket,
MilGreen = Blankets.MilitaryGreenBlanket,
DarkBlue = Blankets.DarkBlueBlanket,
}

function BlanketObjects.rgbToHsl(r, g, b)
    local r = r * 100
    local g = g * 100
    local b = b * 100
    r, g, b = r / 255, g / 255, b / 255
  
    local max, min = math.max(r, g, b), math.min(r, g, b)
    local h, s, l
  
    l = (max + min) / 2
  
    if max == min then
      h, s = 0, 0 -- achromatic
    else
      local d = max - min
      local s
      if l > 0.5 then s = d / (2 - max - min) else s = d / (max + min) end
      if max == r then
        h = (g - b) / d
        if g < b then h = h + 6 end
      elseif max == g then h = (b - r) / d + 2
      elseif max == b then h = (r - g) / d + 4
      end
      h = h / 6
    end

    return h or nil
end
