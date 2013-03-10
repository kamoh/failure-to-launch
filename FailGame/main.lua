-- constants
local wallWidth = 5
local wallLength = 2

local physics = require "physics"
physics.start()

--physics.setScale( 60 ) -- a value that seems good for small objects (based on playtesting)
--physics.setGravity( 0, 0 )

display.setStatusBar( display.HiddenStatusBar )

local game = display.newGroup()

local leftWall = display.newRect(0, -display.contentHeight * (wallLength - 1), wallWidth, display.contentHeight * wallLength)
game:insert(leftWall)
local rightWall = display.newRect(display.contentWidth - wallWidth, -display.contentHeight * (wallLength - 1), wallWidth, display.contentHeight * wallLength)
game:insert(rightWall)
local floor = display.newRect(0, display.contentHeight - wallWidth, display.contentWidth, wallWidth)
game:insert(floor)
local ceiling = display.newRect(0, -display.contentHeight * (wallLength - 1), display.contentWidth, wallWidth)
game:insert(ceiling)

physics.addBody(leftWall, "static", {bounce = 0.1})
physics.addBody(rightWall, "static", {bounce = 0.1})
physics.addBody(floor, "static", {bounce = 0.1})
physics.addBody(ceiling, "static", {bounce = 0.1})

-- Create cueball
local cueball = display.newImage( "images/ball_white.png" )
cueball.x = display.contentWidth/2
cueball.y = display.contentHeight/2
game:insert(cueball)

physics.addBody( cueball, ballBody )
cueball.linearDamping = 0.3
cueball.angularDamping = 0.8
cueball.isBullet = true -- force continuous collision detection, to stop really fast shots from passing through other balls
cueball.color = "white"

target = display.newImage( "images/target.png" )
target.x = cueball.x
target.y = cueball.y
target.alpha = 0
game:insert(target)

local function resetCueball()
	cueball.alpha = 0
	cueball.x = 384
	cueball.y = 780
	cueball.xScale = 2.0
	cueball.yScale = 2.0
	local dropBall = transition.to( cueball, { alpha=1.0, xScale=1.0, yScale=1.0, time=400 } )
end

-- Shoot the cue ball, using a visible force vector
local function cueShot( event )
	local t = event.target

	local phase = event.phase
	if "began" == phase then
		display.getCurrentStage():setFocus( t )
		t.isFocus = true
		
		-- Stop current cueball motion, if any
		t:setLinearVelocity( 0, 0 )
		t.angularVelocity = 0

		target.x = t.x
		target.y = t.y
		
		startRotation = function()
			target.rotation = target.rotation + 4
		end
		
		Runtime:addEventListener( "enterFrame", startRotation )
		
		local showTarget = transition.to( target, { alpha=0.4, xScale=0.4, yScale=0.4, time=200 } )
		myLine = nil

	elseif t.isFocus then
		if "moved" == phase then
			
			if ( myLine ) then
				myLine.parent:remove( myLine ) -- erase previous line, if any
			end
			myLine = display.newLine( t.x, t.y + game.y, event.x, event.y)
			myLine:setColor( 255, 255, 255, 50 )
			myLine.width = 8

		elseif "ended" == phase or "cancelled" == phase then
			display.getCurrentStage():setFocus( nil )
			t.isFocus = false
			
			local stopRotation = function()
				Runtime:removeEventListener( "enterFrame", startRotation )
			end
			
			local hideTarget = transition.to( target, { alpha=0, xScale=1.0, yScale=1.0, time=200, onComplete=stopRotation } )
			
			if ( myLine ) then
				myLine.parent:remove( myLine )
			end
			
			-- Strike the ball!
			t:applyForce( (t.x - event.x), (t.y + game.y - event.y), t.x, t.y )
		end
	end

	-- Stop further propagation of touch event
	return true
end

cueball:addEventListener( "touch", cueShot )

-- Camera follows cueball automatically
local function moveCamera()
	game.y = -cueball.y + display.contentHeight * 0.8
end

Runtime:addEventListener( "enterFrame", moveCamera )
