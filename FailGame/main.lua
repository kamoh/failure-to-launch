-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Generate Physics Engine
local physics = require("physics")
physics.start()
physics.setGravity(0,4)
physics.setDrawMode("hybrid")

display.setStatusBar(display.HiddenStatusBar)
display.newImage("media/images/guide.png")
display.newText("Testing Mo!",5,5,native.systemFont, 16*2)

system.activate("multitouch")
-- screenHeight = display.contentHeight
-- screenWidth = display.contentWidth

local dude = display.newRect (10,10,100,100)
local leftWall = display.newRect (0, 0, 1, display.contentHeight);
local rightWall = display.newRect (display.contentWidth, 0, 1, display.contentHeight);
local ceiling = display.newRect (0, 0, display.contentWidth, 1);
local floor = display.newRect(0,display.contentHeight, display.contentWidth,1)
 

physics.addBody(dude, "dynamic", {density=0.1, friction=0.0, bounce=0.9, radius=10})

physics.addBody (leftWall, "static",  { bounce = 0.1 } )
physics.addBody (rightWall, "static", { bounce = 0.1 } )
physics.addBody (ceiling, "static",   { bounce = 0.1 } )
physics.addBody (floor, "static", {bounce = 0.1} )

local onTouch = function(event)
	if event.phase == "began" then
		dude.x = event.x
		dude.y = event.y

	end
	if event.phase == "moved" then
		dude.x = event.x
		dude.y = event.y
	end

	return true

end

Runtime:addEventListener("touch", onTouch)