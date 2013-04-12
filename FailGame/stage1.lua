local levelData = {
-- Level 0
	{
		job = "LV1: Retired Janitor",
		y = 0
	},
-- Level 1
	{
		job = "LV2: Burger Monkey",
		y = 2.0,
		h = 0.03,
		platforms = {
			{x = 0, w = 0.4},
			{x = 0.6, w = 0.4},
		}
	},
-- Level 2
	{
		job = "LV3: Master Shirt Folder",
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
		job = "LV4: Indentured Servant",
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
		job = "LV5: Senior Indentured Servant",
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
		job = "LV6: Chair Warmer",
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
		job = "LV7: Chief Chair Warmer",
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
		job = "LV8: Senior Chief Chair Warmer",
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
		job = "LV9: Executive Butler",
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
		job = "Lv10: Vice Slavedriver",
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
		job = "BOSS: Chief Executive Overlord",
		y = 20.3,
		h = 0.008,
		platforms = {
			{x = 0.45, w = 0.12},
		},
	},
}

return levelData
