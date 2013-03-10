module(...)

function getWorldData()
	local worldData = {
		gravity = 20,
		physicsScale = 30,
		wallLength = 30,
		wallWidth = 0.01,
		bounce = -10.0,
		friction = 0.07,
		cueballX = 0.5,
		cueballY = 0.1,
		linearDamping = 0.3,
		angularDamping = 1.0,
		pinkSlipY = 0.9,
		cameraOffset = 0.8,
		jumpImpulse = 0.85,
	}

	return worldData
end

function getLevelData()
	local levelData = {
	-- Level 1
		{
			y = 2.0,
			h = 0.03,
			platforms = {
				{x = 0, w = 0.4},
				{x = 0.6, w = 0.4},
			}
		},
	-- Level 2
		{
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
			y = 6.0,
			h = 0.03,
			platforms = {
				{x = 0.15, w = 0.24},
				{x = 0.62, w = 0.24},
			},
			pinkSlips = {
				{x = 0.2, y = 7.9, s = 0.1},
				{x = 0.45, y = 7.5, s = 0.1},
				{x = 0.7, y = 7.1, s = 0.1},
			},
		},
	-- Level 4
		{
			y = 8.0,
			h = 0.02,
			platforms = {
				{x = 0, w = 0.3},
				{x = 0.5, w = 0.3},
			},
			pinkSlips = {
				{x = 0.2, y = 9.21, s = 0.1},
				{x = 0.53, y = 9.5, s = 0.1},
				{x = 0.75, y = 9.3, s = 0.1},
			},
		},
	-- Level 5
		{
			y = 10.0,
			h = 0.02,
			platforms = {
				{x = 0, w = 0.15},
				{x = 0.3, w = 0.3},
				{x = 0.85, w = 0.3},
			},
			pinkSlips = {
				{x = 0.20, y = 11.21, s = 0.1},
				{x = 0.70, y = 11.21, s = 0.1},
			},
		},
	-- Level 6
		{
			y = 12.0,
			h = 0.02,
			platforms = {
				{x = 0.23, w = 0.15},
				{x = 0.53, w = 0.18},
				{x = 0.85, w = 0.3},
			},
			pinkSlips = {
				{x = 0.15, y = 13.33, s = 0.1},
				{x = 0.40, y = 13.13, s = 0.2},
				{x = 0.75, y = 13.33, s = 0.1},
			},
		},
	-- Level 7
		{
			y = 14.0,
			h = 0.01,
			platforms = {
				{x = 0, w = 0.15},
				{x = 0.39, w = 0.20},
				{x = 0.8, w = 0.23},
			},
			pinkSlips = {
				{x = 0.21, y = 15.53, s = 0.2},
				{x = 0.70, y = 15.13, s = 0.1},
			},
		},
	-- Level 8
		{
			y = 16.0,
			h = 0.01,
			platforms = {
				{x = 0.23, w = 0.15},
				{x = 0.56, w = 0.12},
				{x = 0.85, w = 0.3},
			},
			pinkSlips = {
				{x = 0.10, y = 17.83, s = 0.1},
				{x = 0.32, y = 17.43, s = 0.1},
				{x = 0.57, y = 17.03, s = 0.2},
			},
		},
	-- Level 9
		{
			y = 18.0,
			h = 0.01,
			platforms = {
				{x = 0.3, w = 0.15},
				{x = 0.6, w = 0.15},
			},
			pinkSlips = {
				{x = 0.70, y = 21.93, s = 0.1},
				{x = 0.10, y = 21.23, s = 0.25},
				{x = 0.62, y = 20.43, s = 0.1},
				{x = 0.47, y = 19.73, s = 0.2},
				{x = 0.69, y = 19.03, s = 0.1},
			},
		},
	-- Level 10
		{
			y = 22.3,
			h = 0.008,
			platforms = {
				{x = 0.45, w = 0.12},
			},
		},
	}

	return levelData
end
