module(...)

function getWorldData()
	local worldData = {
		wallWidth = 0.01,
		wallLength = 2
	}

	return worldData
end

function getLevelData()
	local levelData = {
		{
			y = 0.5,
			platforms = {
				{x = 0.1, w = 0.2, h = 0.01},
				{x = 0.5, w = 0.2, h = 0.01}
			}
		}
	}

	return levelData
end
