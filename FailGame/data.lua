module(...)

function getWorldData()
	local worldData = {
		wallWidth = 0.01,
		wallLength = 30
	}

	return worldData
end

function getLevelData()
	local levelData = {
	-- Example
		-- {
			-- y = 0.5,
			-- platforms = {
				-- {x = 0.1, w = 0.2, h = 0.01},
				-- {x = 0.5, w = 0.2, h = 0.01}
			-- }
		-- },
	-- Level 1
		{
			y = 2.0,
			platforms = {
				{x = 0, w = 0.4, h = 0.03},
				{x = 0.6, w = 0.4, h = 0.03}
			}
		},
	-- Level 2
		{
			y = 4.0,
			platforms = {
				{x = 0, w = 0.23, h = 0.03},
				{x = 0.4, w = 0.23, h = 0.03},
				{x = 0.8, w = 0.23, h = 0.03}
			}
		},
	-- Level 3
		{
			y = 6.0,
			platforms = {
				{x = 0.15, w = 0.24, h = 0.03},
				{x = 0.62, w = 0.24, h = 0.03},
			}
		},
	-- Level 4
		{
			y = 8.0,
			platforms = {
				{x = 0, w = 0.3, h = 0.02},
				{x = 0.5, w = 0.3, h = 0.02},
			}
		},
	-- Level 5
		{
			y = 10.0,
			platforms = {
				{x = 0, w = 0.15, h = 0.02},
				{x = 0.3, w = 0.3, h = 0.02},
				{x = 0.85, w = 0.3, h = 0.02},
			}
		},
	-- Level 6
		{
			y = 12.0,
			platforms = {
				{x = 0.23, w = 0.15, h = 0.02},
				{x = 0.53, w = 0.18, h = 0.02},
				{x = 0.85, w = 0.3, h = 0.02},
			}
		},
	-- Level 7
		{
			y = 14.0,
			platforms = {
				{x = 0, w = 0.15, h = 0.01},
				{x = 0.39, w = 0.20, h = 0.01},
				{x = 0.8, w = 0.23, h = 0.01}
			}
		},
	-- Level 8
		{
			y = 16.0,
			platforms = {
				{x = 0.23, w = 0.15, h = 0.01},
				{x = 0.56, w = 0.12, h = 0.01},
				{x = 0.85, w = 0.3, h = 0.01},
			}
		},
	-- Level 9
		{
			y = 18.0,
			platforms = {
				{x = 0.3, w = 0.15, h = 0.01},
				{x = 0.6, w = 0.15, h = 0.01},
			}
		},
	-- Level 10
		{
			y = 20.0,
			platforms = {
				{x = 0.45, w = 0.12, h = 0.008},
			}
		}
	}

	return levelData
end
