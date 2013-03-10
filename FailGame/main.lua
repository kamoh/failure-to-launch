local physics = require "physics"
physics.setDrawMode("hybrid")
--physics.setScale( 60 ) -- a value that seems good for small objects (based on playtesting)
--physics.setGravity( 0, 0 )
physics.start()

local data = require "data"
local props = data.getProps()
local levelData = data.getLevelData()

display.setStatusBar(display.HiddenStatusBar)

local displayGroup = display.newGroup()

local leftWall = display.newRect(0, -display.contentHeight * (props.wallLength - 1), props.wallWidth, display.contentHeight * props.wallLength)
local rightWall = display.newRect(display.contentWidth - props.wallWidth, -display.contentHeight * (props.wallLength - 1), props.wallWidth, display.contentHeight * props.wallLength)
local floor = display.newRect(0, display.contentHeight - props.wallWidth, display.contentWidth, props.wallWidth)
local ceiling = display.newRect(0, -display.contentHeight * (props.wallLength - 1), display.contentWidth, props.wallWidth)

displayGroup:insert(leftWall)
displayGroup:insert(rightWall)
displayGroup:insert(floor)
displayGroup:insert(ceiling)

physics.addBody(leftWall, "static", {bounce = 0.1})
physics.addBody(rightWall, "static", {bounce = 0.1})
physics.addBody(floor, "static", {bounce = 0.1})
physics.addBody(ceiling, "static", {bounce = 0.1})

--Create platforms
for i = 1, #levelData do
	local platform = display.newRect(levelData[i][1], levelData[i][2], levelData[i][3], levelData[i][4])
	platform.collType = "passthru"
	displayGroup:insert(platform)
	physics.addBody(platform, "static", {bounce = 0.1})
end

-- Create cueball
local cueball = display.newImage( "images/ball_white.png" )
cueball.x = display.contentWidth/2
cueball.y = display.contentHeight/2
displayGroup:insert(cueball)

physics.addBody(cueball, ballBody)
cueball.linearDamping = 0.3
cueball.angularDamping = 0.8
cueball.isBullet = true -- force continuous collision detection, to stop really fast shots from passing through other balls
cueball.color = "white"

target = display.newImage("images/target.png")
target.x = cueball.x
target.y = cueball.y
target.alpha = 0
displayGroup:insert(target)

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
			myLine = display.newLine( t.x, t.y + displayGroup.y, event.x, event.y)
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
			t:applyForce( (t.x - event.x), (t.y + displayGroup.y - event.y), t.x, t.y )
		end
	end

	-- Stop further propagation of touch event
	return true
end

cueball:addEventListener("touch", cueShot)

-- Local Player collision decision
local function onPreCollision(event)
	print("PRE")
	local collideObject = event.other
	if ( collideObject.collType == "passthru" ) and ( collideObject.y < cueball.y) then
		event.contact.isEnabled = false  --disable this specific collision!
	end
end

cueball:addEventListener("preCollision", onPreCollision)

--timer variables
local touchTimer = 0
local runTouchTime = false

--updates every frame
local function update(event)
	local xVel = 0;
	local yvel = 0;
	print(cueball:getLinearVelocity())
	xVel,yVel = cueball:getLinearVelocity()
	if (yVel < 5 and runTouchTime == false) then
		runTouchTime = true
	end
	if (yVel > 5 and runTouchTime == true) then
		runTouchTime = false
		touchTimer = 0
	end
	if runTouchTime then
		touchTimer = touchTimer + 1
	end
	if touchTimer > 100 then
		display.newText("Ya done goofed!",5,5,native.systemFont, 16*2)
		runTouchTime = false
		touchTimer = 0
	end

	displayGroup.y = -cueball.y + display.contentHeight * 0.8
end

Runtime:addEventListener("enterFrame", update)
