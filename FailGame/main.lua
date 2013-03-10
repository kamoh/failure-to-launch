display.setStatusBar(display.HiddenStatusBar)
local displayGroup = display.newGroup()

local data = require "data"
local worldData = data.getWorldData()

local physics = require "physics"
physics.start()
physics.setDrawMode("hybrid")
physics.setGravity(0, worldData.gravity)
physics.setScale( worldData.physicsScale ) -- 60 seems good for small objects (based on playtesting)

local wallLength = display.contentHeight * worldData.wallLength
local wallWidth = display.contentWidth * worldData.wallWidth

local leftWall = display.newRect(0, -wallLength, wallWidth, wallLength)
local rightWall = display.newRect(display.contentWidth - wallWidth, -wallLength, wallWidth, wallLength)
local floor = display.newRect(0, 0, display.contentWidth, wallWidth)
local ceiling = display.newRect(0, -wallLength, display.contentWidth, wallWidth)

displayGroup:insert(leftWall)
displayGroup:insert(rightWall)
displayGroup:insert(floor)
displayGroup:insert(ceiling)

physics.addBody(leftWall, "static", {bounce = worldData.bounce, friction = worldData.friction})
physics.addBody(rightWall, "static", {bounce = worldData.bounce, friction = worldData.friction})
physics.addBody(floor, "static", {bounce = worldData.bounce, friction = worldData.friction})
physics.addBody(ceiling, "static", {bounce = worldData.bounce, friction = worldData.friction})

local levelData = data.getLevelData()

--Create platforms
for i = 1, #levelData do
	local w = display.contentWidth
	local h = display.contentHeight

	for key, object in pairs(levelData[i].platforms) do
		local platform = display.newRect(object.x * w, -levelData[i].y * h, object.w * w, -levelData[i].h * h)
		platform.collType = "passthru"
		displayGroup:insert(platform)
		physics.addBody(platform, "static", {bounce = worldData.bounce, friction = worldData.friction})
	end

	if levelData[i].pinkSlips then
		for key, object in pairs(levelData[i].pinkSlips) do
			local pinkSlip = display.newRect(object.x * w, -object.y * h, object.s * w, object.s * w)
			pinkSlip.collType = "pinkSlip"
			displayGroup:insert(pinkSlip)
			physics.addBody(pinkSlip, "static")
		end
	end
end

-- Create cueball
local cueball = display.newImage( "images/dude72.png" )
cueball.x = display.contentWidth * worldData.cueballX
cueball.y = -display.contentHeight * worldData.cueballY
displayGroup:insert(cueball)

physics.addBody(cueball, ballBody)
cueball.linearDamping = worldData.linearDamping
cueball.angularDamping = worldData.angularDamping
cueball.isBullet = true -- force continuous collision detection, to stop really fast shots from passing through other balls
cueball.color = "white"

target = display.newImage("images/target.png")
target.x = cueball.x
target.y = cueball.y
target.alpha = 0
displayGroup:insert(target)

--Hud Components
-- local hudBackground = display.newRect()

--Game restrictions
local isAirborne = false
local jumpCount = 5
local money = 0
local platformTime = 60000 --One Minute, varies depending on if we're adding minigames.
local jobTitle = "Janitor"

-- Shoot the cue ball, using a visible force vector
local function cueShot( event )
	local t = event.target
--	if isAirborne == false then
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
			
			local showTarget = transition.to( target, { alpha=0.5, xScale=0.8, yScale=0.8, time=200 } )
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
				
				local hideTarget = transition.to( target, { alpha=0, xScale=1.5, yScale=1.5, time=200, onComplete=stopRotation } )
				
				if ( myLine ) then
					myLine.parent:remove( myLine )
				end
				
				-- Strike the ball!
				t:applyForce( (t.x - event.x), (t.y + displayGroup.y - event.y), t.x, t.y )
				isAirborne = true
			end
		end
--	end

	-- Stop further propagation of touch event
	return true
end

cueball:addEventListener("touch", cueShot)

-- Local Player collision decision
local function onPreCollision(event)
	local collideObject = event.other
	if ( collideObject.collType == "passthru" ) and ( collideObject.y < cueball.y) then
		event.contact.isEnabled = false  --disable this specific collision!
	elseif (collideObject.collType == "pinkSlip" ) then
		event.contact.isEnabled = false  --disable this specific collision!
		local x, y = cueball:getLinearVelocity()
		y = y * worldData.pinkSlipY
		cueball:setLinearVelocity(x, y)
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
		isAirborne = false
	end

	displayGroup.y = -cueball.y + display.contentHeight * worldData.cameraOffset -- camera follows cueball
end

Runtime:addEventListener("enterFrame", update)

local function multiJump(event)
--	if jumpCount ~= 0 and isAirborne == true then
		if event.phase == "began" then
			local dx = cueball.x - event.x
			local dy = cueball.y - event.y + displayGroup.y

			local a = math.atan2(dy, dx)
			local x = math.cos(a) * worldData.jumpImpulse
			local y = math.sin(a) * worldData.jumpImpulse

			if y < 0 then
				x = x * -1
				y = y * -1
			end
			
			cueball:setLinearVelocity(0, 0)
			cueball:applyLinearImpulse(-x, -y, cueball.x, cueball.y)
			jumpCount = jumpCount - 1
		end
--	end
end

Runtime:addEventListener("touch", multiJump)
