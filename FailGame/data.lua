module(...)

function getWorldData()
	local worldData = {
		gravity = 20,
		physicsScale = 30,
		backgroundColor = 64,
		wallLength = 30,
		wallWidth = 0.01,
		bounce = -10.0,
		friction = 0.045,
		cueballX = 0.5,
		cueballY = 0.1,
		linearDamping = 0.3,
		angularDamping = 1.0,
		pinkSlipY = 0.9,
		cameraOffset = 0.8,
		jumpImpulse = 0.85,
		musicVolume = 0.1,
		bounceVolume = 0.2,
		releaseVolume = 0.2,
	}

	return worldData
end

function getLevelData()
	local levelData = {
	-- Level 1
		{
			job = "Burger Monkey",
			y = 2.0,
			h = 0.03,
			platforms = {
				{x = 0, w = 0.4},
				{x = 0.6, w = 0.4},
			}
		},
	-- Level 2
		{
			job = "Master Shirt Folder",
			y = 4.0,
			h = 0.03,
			platforms = {
				{x = 0, w = 0.23},
				{x = 0.4, w = 0.23},
				{x = 0.8, w = 0.23},
			}
		},
	-- Level 3
		{
			job = "Indentured Servent",
			y = 6.0,
			h = 0.03,
			platforms = {
				{x = 0.15, w = 0.24},
				{x = 0.62, w = 0.24},
			},
			pinkSlips = {
			-- real y coordinates are 7.9, 7.5, 7.1
				{x = 0.10, y = 7.9, s = 0.2},
				{x = 0.35, y = 7.5, s = 0.2},
				{x = 0.53, y = 7.1, s = 0.2},
			},
		},
	-- Level 4
		{
			job = "Senior Indentured Servent",
			y = 8.0,
			h = 0.02,
			platforms = {
				{x = 0, w = 0.3},
				{x = 0.5, w = 0.3},
			},
			pinkSlips = {
			-- real y coordinates are 9.21, 9.5, 9.3
				{x = 0.05, y = 9.17, s = 0.2},
				{x = 0.27, y = 9.78, s = 0.2},
				{x = 0.55, y = 9.43, s = 0.2},
			},
		},
	-- Level 5
		{
			job = "Chair Warmer",
			y = 10.0,
			h = 0.02,
			platforms = {
				{x = 0, w = 0.15},
				{x = 0.3, w = 0.3},
				{x = 0.85, w = 0.3},
			},
			pinkSlips = {
			-- real y coordinates are 11.21, 11.21
				{x = 0.03, y = 11.21, s = 0.2},
				{x = 0.47, y = 11.21, s = 0.2},
			},
		},
	-- Level 6
		{
			job = "Chief Chair Warmer",
			y = 12.0,
			h = 0.02,
			platforms = {
				{x = 0.23, w = 0.15},
				{x = 0.53, w = 0.18},
				{x = 0.85, w = 0.3},
			},
			pinkSlips = {
			-- real y coordinates are 13.33, 13.13, 13.33
				{x = 0, y = 13.64, s = 0.2},
				{x = 0.22, y = 13.03, s = 0.4},
				{x = 0.55, y = 13.37, s = 0.2},
			},
		},
	-- Level 7
		{
			job = "Senior Chief Chair Warmer",
			y = 14.0,
			h = 0.01,
			platforms = {
				{x = 0, w = 0.15},
				{x = 0.39, w = 0.20},
				{x = 0.8, w = 0.23},
			},
			pinkSlips = {
			-- real y coordinates are 15.53, 15.13
				{x = 0.08, y = 15.53, s = 0.4},
				{x = 0.42, y = 15.13, s = 0.2},
			},
		},
	-- Level 8
		{
			job = "Executive Butler",
			y = 16.0,
			h = 0.01,
			platforms = {
				{x = 0.23, w = 0.15},
				{x = 0.56, w = 0.12},
				{x = 0.85, w = 0.3},
			},
			pinkSlips = {
			-- real y coordinates are 17.83, 17.43, 17.03
				{x = 0.01, y = 17.83, s = 0.2},
				{x = 0.25, y = 17.43, s = 0.2},
				{x = 0.53, y = 17.03, s = 0.4},
			},
		},
	-- Level 9
		{
			job = "Vice Slavedriver",
			y = 18.0,
			h = 0.01,
			platforms = {
				{x = 0.3, w = 0.15},
				{x = 0.6, w = 0.15},
			},
			pinkSlips = {
			-- real y coordinates are 21.93, 21.23, 20.43, 19.73, 19.03
				--{x = 0.50, y = 21.93, s = 0.2},
				--{x = 0.13, y = 21.23, s = 0.5},
				{x = 0.24, y = 20.43, s = 0.2},
				{x = 0.03, y = 19.73, s = 0.4},
				{x = 0.48, y = 19.03, s = 0.2},
			},
		},
	-- Level 10
		{
			job = "Chief Executive Overlord",
			y = 20.3,
			h = 0.008,
			platforms = {
				{x = 0.45, w = 0.12},
			},
		},
	}

	return levelData
end
