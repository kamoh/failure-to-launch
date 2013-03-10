local data = require "data"
local worldData = data.getWorldData()

local physics = require "physics"
physics.start()
--physics.setDrawMode("hybrid")
physics.setGravity(0, worldData.gravity)
physics.setScale( worldData.physicsScale ) -- 60 seems good for small objects (based on playtesting)

display.setStatusBar(display.HiddenStatusBar)
local displayGroup = display.newGroup()

local backgrounds = {}
local backgroundColor = 64
local backgroundHeight = 167
local numBackgrounds = display.contentHeight / backgroundHeight + 2

for i = 0, numBackgrounds do
	backgrounds[i] = display.newImage("images/layer1back2.png")
	backgrounds[i].x = display.contentCenterX
	backgrounds[i].y = i * -backgroundHeight - backgroundHeight/2
	backgrounds[i]:setFillColor(backgroundColor, backgroundColor, backgroundColor)
	displayGroup:insert(backgrounds[i])
end

local function moveBackground()
	for i = 0, numBackgrounds do
		if backgrounds[i].y - backgroundHeight * (numBackgrounds - 1) > -displayGroup.y then
			backgrounds[i].y = backgrounds[i].y - backgroundHeight * numBackgrounds
		end

		if backgrounds[i].y + backgroundHeight * (numBackgrounds - 6) < -displayGroup.y then
			backgrounds[i].y = backgrounds[i].y + backgroundHeight * numBackgrounds
		end
	end
end

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
--			local pinkSlip = display.newRect(object.x * w, -object.y * h, object.s * w, object.s * w)
			local pinkSlip = display.newImage("images/pinkSlip.png")
			pinkSlip:scale(object.s, object.s)
			pinkSlip:translate(object.x * w, -object.y * h)
			pinkSlip.collType = "pinkSlip"
			displayGroup:insert(pinkSlip)
			local r = pinkSlip.width / 2
			physics.addBody(pinkSlip, "static", {radius = r * object.s})
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

target = display.newImage("images/target.png")
target.x = cueball.x
target.y = cueball.y
target.alpha = 0
displayGroup:insert(target)

--Hud Components
--Game restrictions
local isAirborne = false
local jumpCount = 5
local money = 0
local platformTime = 60000 --One Minute, varies depending on if we're adding minigames.
local zeroTitle = "Janitor"
local hudBackground = display.newRect(0,display.contentHeight * 0.86,display.contentWidth, display.contentHeight * 0.20)
hudBackground:setFillColor( 50,50,50,200 )
local levelText = display.newText("Janitor",display.contentWidth * .5 ,display.contentHeight * .99,native.systemFont, 16*2)
levelText:setReferencePoint(display.BottomReferencePoint)
levelText.x = display.contentWidth * .5
levelText.y = display.contentHeight * .99
local jumpText = display.newText("x " .. jumpCount, display.contentWidth * .15, display.contentHeight * .90, native.systemFont, 16*2)
local jumpIcon = display.newImage( "images/jumping_icon_white.png" )
levelText:setReferencePoint(display.CenterReferencePoint)
jumpIcon.x = display.contentWidth * .1
jumpIcon.y = display.contentHeight * .90
jumpIcon.xScale = .33
jumpIcon.yScale = .33
local moneyText = display.newText(("$" .. money),display.contentWidth * .4, display.contentHeight * .90, native.systemFont, 16*2)
local timerText = display.newText(platformTime/1000, 0,0, native.systemFont, 16*2)
timerText:setReferencePoint(display.BottomReferencePoint)
timerText.x = display.contentWidth * .5
timerText.y = display.contentHeight * .01

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
	moveBackground()
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
