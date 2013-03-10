module(...)

function getWorldData()
	local worldData = {
		gravity = 20,
		physicsScale = 30,
		wallLength = 30,
		wallWidth = 0.01,
		bounce = 0.1,
		friction = 0.006,
		cueballX = 0.5,
		cueballY = 0.1,
		linearDamping = 0.3,
		angularDamping = 1.0,
		cameraOffset = 0.8,
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
			},
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
			}
		},
	-- Level 4
		{
			y = 8.0,
			h = 0.02,
			platforms = {
				{x = 0, w = 0.3},
				{x = 0.5, w = 0.3},
			}
		},
	-- Level 5
		{
			y = 10.0,
			h = 0.02,
			platforms = {
				{x = 0, w = 0.15},
				{x = 0.3, w = 0.3},
				{x = 0.85, w = 0.3},
			}
		},
	-- Level 6
		{
			y = 12.0,
			h = 0.02,
			platforms = {
				{x = 0.23, w = 0.15},
				{x = 0.53, w = 0.18},
				{x = 0.85, w = 0.3},
			}
		},
	-- Level 7
		{
			y = 14.0,
			h = 0.01,
			platforms = {
				{x = 0, w = 0.15},
				{x = 0.39, w = 0.20},
				{x = 0.8, w = 0.23},
			}
		},
	-- Level 8
		{
			y = 16.0,
			h = 0.01,
			platforms = {
				{x = 0.23, w = 0.15},
				{x = 0.56, w = 0.12},
				{x = 0.85, w = 0.3},
			}
		},
	-- Level 9
		{
			y = 18.0,
			h = 0.01,
			platforms = {
				{x = 0.3, w = 0.15},
				{x = 0.6, w = 0.15},
			}
		},
	-- Level 10
		{
			y = 20.0,
			h = 0.008,
			platforms = {
				{x = 0.45, w = 0.12},
			}
		},
	}

	return levelData
end
