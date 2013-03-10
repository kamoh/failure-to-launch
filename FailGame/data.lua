module(...)

function getProps()
	local props = {
		wallWidth = 5,
		wallLength = 2
	}

	return props
end

function getLevelData()
	local levelData = {
		{100, 400, 100, 30},
		{300, 400, 100, 30}
	}

	return levelData
end
