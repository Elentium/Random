--[[
	Random V1.2.5
	by IAMNOTULTRA3
	
	A random library for easier randomization use, using Random.new() for improved control. Create an instance using RandomModule.new([seed: number?]) to initialize the random number generator with an optional seed for reproducible results.
	
	[MIT License]
	
	Methods:
	
	- `RandomModule.new(seed: number?) -> Random`
		Description: Creates a new Random instance with an optional seed for reproducible randomization.
		
		Arguments:
			seed - optional, a number to seed the random number generator for deterministic results
			
		Returns:
			Random - a new Random instance
			
		Example:
			local Random = require(game.ServerScriptService.Random)
			local rng = Random.new(123) -- Create with seed
			local randomValue = rng:RandomFloat(0, 1)
			print(`Random float: {randomValue}`)
	
	- `Random:Choice(tbl: table, blacklist: table?) -> (any, any?)`
		Description: Selects a random value from the given table. If the value's key is not a number, returns the key as a second value.
		
		Arguments:
			tbl - a table to randomly select values from
			blacklist - optional, a table of values to exclude from selection
			
		Returns:
			(selectedValue, selectedValueKey?)
			selectedValue - the value that was randomly chosen
			selectedValueKey - the key of the value (returned if the key is a non-number)
			
		Example:
			local Random = require(game.ServerScriptService.Random)
			local rng = Random.new()
			local some_table = {
				Ferrari = { Price = 125_000 },
				BMW = { Price = 95_000 }
			}
			local RandomCar, CarName = rng:Choice(some_table)
			print(`{CarName}'s price is: {RandomCar.Price}`)
	
	- `Random:RandomInteger(x: number, y: number, blacklist: table?) -> number`
		Description: Generates a random integer in the range of `x` to `y` (inclusive).
		
		Arguments:
			x - minimum number
			y - maximum number
			blacklist - optional, a table of numbers to skip
			
		Returns:
			number - a random integer
			
		Example:
			local Random = require(game.ServerScriptService.Random)
			local rng = Random.new()
			local oneThroughTen = rng:RandomInteger(1, 10)
			print(`Your rating is: {oneThroughTen}`)
	
	- `Random:WeightedChoice(tbl: {{any}}, weightKey: string?) -> any`
		Description: Selects a random item from a table based on weights assigned to each item.
		
		Arguments:
			tbl - a table where each item is a subtable containing a weight value (default key: "weight")
			weightKey - optional, the key used to access the weight value in each item (defaults to "weight")
			
		Returns:
			selectedItem - the randomly chosen item based on weights
			
		Example:
			local Random = require(game.ServerScriptService.Random)
			local rng = Random.new()
			local items = {
				{ name = "Sword", weight = 0.5 },
				{ name = "Shield", weight = 0.3 },
				{ name = "Potion", weight = 0.2 }
			}
			local randomItem = rng:WeightedChoice(items)
			print(`You received: {randomItem.name}`)
	
	- `Random:ChooseMultiple(tbl: {any} | {[any]: any}, n: number, allowDuplicates: boolean?) -> {any}`
		Description: Selects `n` items from a table, with or without duplicates.
		
		Arguments:
			tbl - a table to select items from
			n - the number of items to select
			allowDuplicates - optional, whether to allow duplicate selections (defaults to false)
			
		Returns:
			selectedItems - an array of randomly chosen items
			
		Example:
			local Random = require(game.ServerScriptService.Random)
			local rng = Random.new()
			local colors = {"Red", "Blue", "Green", "Yellow"}
			local twoColors = rng:ChooseMultiple(colors, 2)
			print(`Selected colors: {table.concat(twoColors, ", ")}`)
	
	- `Random:RandomFloat(min: number, max: number, precision: number?) -> number`
		Description: Generates a random floating-point number between `min` and `max` (inclusive).
		
		Arguments:
			min - minimum number (inclusive)
			max - maximum number (inclusive)
			precision - optional, number of decimal places to round to (defaults to 5)
			
		Returns:
			number - a random float between min and max
			
		Example:
			local Random = require(game.ServerScriptService.Random)
			local rng = Random.new()
			local randomValue = rng:RandomFloat(0, 1)
			print(`Random float: {randomValue}`)
	
	- `Random:WeightedRandomFloat(min: number, max: number, mode: number?) -> number`
		Description: Generates a random floating-point number between `min` and `max` (inclusive) with a bias towards `mode` using a triangular distribution (values are more likely to cluster around `mode`). Useful for biased random effects, like spawning objects closer to a specific value.
		
		Arguments:
			min - minimum number (inclusive)
			max - maximum number (inclusive)
			mode - optional, the number to bias towards (defaults to halfway between min and max)
			
		Returns:
			number - a random float biased towards mode
			
		Example:
			local Random = require(game.ServerScriptService.Random)
			local rng = Random.new()
			local biasedValue = rng:WeightedRandomFloat(0, 100, 75)
			print(`Biased random float (closer to 75): {biasedValue}`)
	
	- `Random:RandomColor3(minR: number, maxR: number, minG: number, maxG: number, minB: number, maxB: number, precision: number?) -> Color3`
		Description: Generates a random Color3 value with RGB components within specified ranges.
		
		Arguments:
			minR, maxR - minimum and maximum red component (0-255)
			minG, maxG - minimum and maximum green component (0-255)
			minB, maxB - minimum and maximum blue component (0-255)
			precision - optional, number of decimal places for component values (defaults to 0)
			
		Returns:
			Color3 - a random Color3 value
			
		Example:
			local Random = require(game.ServerScriptService.Random)
			local rng = Random.new()
			local randomColor = rng:RandomColor3(0, 255, 0, 255, 0, 255)
			print(`Random color: {randomColor}`)
	
	- `Random:RandomVector3(minX: number, maxX: number, minY: number, maxY: number, minZ: number, maxZ: number, precision: number?) -> vector`
		Description: Generates a random Vector3 with components within specified ranges.
		
		Arguments:
			minX, maxX - minimum and maximum X component
			minY, maxY - minimum and maximum Y component
			minZ, maxZ - minimum and maximum Z component
			precision - optional, number of decimal places for components (defaults to 0)
			
		Returns:
			vector - a random vector value(vector is a new roblox library that is better for performance than Vector3)
			
		Example:
			local Random = require(game.ServerScriptService.Random)
			local rng = Random.new()
			local randomPosition = rng:RandomVector3(-10, 10, 0, 5, -10, 10)
			print(`Random position: {randomPosition}`)
	
	- `Random:RandomVector2(minX: number, maxX: number, minY: number, maxY: number, precision: number?) -> Vector2`
		Description: Generates a random Vector2 with components within specified ranges.
		
		Arguments:
			minX, maxX - minimum and maximum X component
			minY, maxY - minimum and maximum Y component
			precision - optional, number of decimal places for components (defaults to 0)
			
		Returns:
			Vector2 - a random Vector2 value
			
		Example:
			local Random = require(game.ServerScriptService.Random)
			local rng = Random.new()
			local randomPoint = rng:RandomVector2(0, 100, 0, 100)
			print(`Random 2D point: {randomPoint}`)
	
	- `Random:RandomCFrame(position: {minX: number, maxX: number, minY: number, maxY: number, minZ: number, maxZ: number}, orientation: {minX: number, maxX: number, minY: number, maxY: number, minZ: number, maxZ: number}, precision: number?) -> CFrame`
		Description: Generates a random CFrame with position and orientation within specified ranges.
		
		Arguments:
			position - a table containing minX, maxX, minY, maxY, minZ, maxZ for position
			orientation - a table containing minX, maxX, minY, maxY, minZ, maxZ for orientation angles (in degrees)
			precision - optional, number of decimal places for components (defaults to 0)
			
		Returns:
			CFrame - a random CFrame value
			
		Example:
			local Random = require(game.ServerScriptService.Random)
			local rng = Random.new()
			local randomCFrame = rng:RandomCFrame(
				{ minX = -10, maxX = 10, minY = 0, maxY = 5, minZ = -10, maxZ = 10 },
				{ minX = 0, maxX = 360, minY = 0, maxY = 360, minZ = 0, maxZ = 360 }
			)
			print(`Random CFrame: {randomCFrame}`)
	
	- `Random:RandomUdim2(useScale: boolean, minX: number, maxX: number, minY: number, maxY: number, precision: number?) -> UDim2`
		Description: Generates a random UDim2 value, using either scale or offset based on `useScale`.
		
		Arguments:
			useScale - whether to use scale (true) or offset (false) for the UDim2
			minX, maxX - minimum and maximum X component
			minY, maxY - minimum and maximum Y component
			precision - optional, number of decimal places for components (defaults to 0)
			
		Returns:
			UDim2 - a random UDim2 value
			
		Example:
			local Random = require(game.ServerScriptService.Random)
			local rng = Random.new()
			local randomUdim2 = rng:RandomUdim2(true, 0, 1, 0, 1)
			print(`Random UDim2: {randomUdim2}`)
	
	- `Random:RandomUdim(useScale: boolean, min: number, max: number, precision: number?) -> UDim`
		Description: Generates a random UDim value, using either scale or offset based on `useScale`.
		
		Arguments:
			useScale - whether to use scale (true) or offset (false) for the UDim
			min, max - minimum and maximum value
			precision - optional, number of decimal places for the value (defaults to 0)
			
		Returns:
			UDim - a random UDim value
			
		Example:
			local Random = require(game.ServerScriptService.Random)
			local rng = Random.new()
			local randomUdim = rng:RandomUdim(true, 0, 1)
			print(`Random UDim: {randomUdim}`)
			
]]

--helper function
local function find_value_in_dictionary(tbl, value_to_find)

	local result = nil

	for k, v in tbl do

		if v == value_to_find then

			result = k
			break

		end

	end

	return result

end

-- Helper function for precision
local function apply_precision(value: number, precision: number): number
	if precision == 0 then
		return math.floor(value + 0.5) -- Round to nearest integer
	end
	local factor = 10 ^ precision
	return math.floor(value * factor + 0.5) / factor
end

local RandomModule = {} :: Random_Lib
RandomModule.__index = RandomModule

export type Random = {
	-- Choose a random value from the table
	Choice: (self: Random, tbl: {any} | {[any]: any}, Blacklist: { any } | { [any]: any }) -> (any, any?),

	-- Generate a random number from x(minimum number) to y(maximum number)
	RandomInteger: (
		self: Random,
		x: number, -- Minimum number
		y: number, -- Maximum number
		blacklist: {number}? -- Array of numbers to skip
	) -> number,

	-- Select a random item from a table based on weights
	WeightedChoice: (self: Random, tbl: {{any}}, weightKey: string?) -> any,

	-- Select n unique items from a table
	ChooseMultiple: (self: Random, tbl: {any} | {[any]: any}, n: number, allowDuplicates: boolean?) -> {any},

	-- Generate a random float between min and max with optional precision
	RandomFloat: (self: Random, min: number, max: number, precision: number?) -> number,

	-- Generate a random float with a bias (triangular distribution)
	WeightedRandomFloat: (self: Random, min: number, max: number, mode: number?) -> number,

	--Generate a random Color3 from RGB
	RandomColor3: (self: Random, minR: number, maxR: number, minG: number, maxG: number,  minB: number, maxB: number, precision: number?) -> Color3,

	--Generate a random Vector3 with optional precision
	RandomVector3: (self: Random, minX: number, maxX: number, minY: number, maxY: number, minZ: number, maxZ: number) -> vector,

	--Generate a random Vector2 with optional precision
	RandomVector2: (self: Random, minX: number, maxX: number, minY: number, maxY: number, precision: number?) -> Vector2,

	--Generate a random CFrame with optional precision
	RandomCFrame: (self: Random, position: {minX: number, maxX: number, minY: number, maxY: number, minZ: number, maxZ: number}, orientation: {minX: number, maxX: number, minY: number, maxY: number, minZ: number, maxZ: number}, precision: number?) -> CFrame,

	--Generate a random Udim2 with optional precision
	RandomUdim2: (self: Random, useScale: boolean, minX: number, maxX: number, minY: number, maxY: number, precision: number?) -> UDim2,

	--Generate a random Udim with optional precision
	RandomUdim: (self: Random, useScale: boolean, min: number, max: number, precision: number?) -> UDim

}

export type Random_Lib = {

	new: (seed: number?) -> Random

}


function RandomModule.new(seed)


	local rng = Random.new(seed)

	local self = setmetatable({}, RandomModule)

	self.rng = rng

	return self

end


function RandomModule:Choice(tbl, blacklist): any
	if type(tbl) ~= "table" then
		error("[Random] incorrect argument #1, table expected, got " .. typeof(tbl))
	end
	if next(tbl) == nil then
		warn("[Random] empty table provided, not processing request")
		return nil
	end

	local ch = {}
	for k, v in pairs(tbl) do
		if type(blacklist) == "table" then
			if find_value_in_dictionary(blacklist, v) ~= nil then

				continue

			end
		end

		table.insert(ch, {k, v})
	end
	local result = ch[self.rng:NextInteger(1, #ch)]
	if result then
		if type(result[1]) == "string" or typeof(result[1]) == "Instance" then
			return result[2], result[1]
		end
		return result[2]
	end
end

function RandomModule:RandomInteger(x: number, y: number, blacklist: {number}?, attempt: number?): number
	if type(x) ~= "number" or type(y) ~= "number" then
		error("[Random] incorrect x or y arguments")
	end
	if x > y then
		error("[Random] x must be lower than y")
	end
	attempt = attempt or 1
	local result = self.rng:NextInteger(x, y)
	if type(blacklist) == "table" then
		if table.find(blacklist, result) then
			if attempt > 30 then
				error("[Random] exceeded Random number generation attempts, please try to minimize the blacklist")
			end
			result = self:RandomInteger(x, y, blacklist, attempt + 1)
		end
	end
	return result
end

function RandomModule:WeightedChoice(tbl: {any}, weightKey: string?): any
	if type(tbl) ~= "table" then
		error("[Random] Expected a table, got " .. typeof(tbl))
	end
	if next(tbl) == nil then
		error("[Random] Table is empty")
	end
	weightKey = weightKey or "weight"

	local totalWeight = 0
	for _, item in pairs(tbl) do
		if type(item[weightKey]) ~= "number" then
			error("[Random] Invalid weight for item: " .. tostring(item))
		end
		totalWeight = totalWeight + item[weightKey]
	end

	local randomValue = self.rng:NextNumber() * totalWeight
	local currentWeight = 0
	for _, item in pairs(tbl) do
		currentWeight = currentWeight + item[weightKey]
		if randomValue <= currentWeight then
			return item
		end
	end
	return tbl[#tbl] 
end

function RandomModule:ChooseMultiple(tbl: {any} | {[any]: any}, n: number, allowDuplicates: boolean?): {any}
	if type(tbl) ~= "table" then
		error("[Random] Expected a table, got " .. typeof(tbl))
	end
	if next(tbl) == nil then
		error("[Random] Table is empty")
	end
	if type(n) ~= "number" or n < 1 or math.floor(n) ~= n then
		error("[Random] n must be a positive integer")
	end
	local isArray = #tbl > 0
	local count = isArray and #tbl or table.maxn(tbl)
	if not allowDuplicates and n > count then
		error("[Random] Cannot select " .. n .. " unique items from a table with " .. count .. " items")
	end
	allowDuplicates = allowDuplicates or false

	local result = {}
	local available = allowDuplicates and tbl or table.clone(tbl)
	for i = 1, n do
		local item, key = self:Choice(available)
		if not item then
			error("[Random] No valid items available for selection")
		end
		table.insert(result, item)
		if not allowDuplicates then
			if isArray then
				table.remove(available, key)
			else
				available[key] = nil
			end
			if next(available) == nil and i < n then
				error("[Random] Ran out of unique items")
			end
		end
	end
	return result
end

function RandomModule:RandomFloat(min: number, max: number, precision: number?): number
	if type(min) ~= "number" or type(max) ~= "number" then
		error("[Random] min and max must be numbers")
	end
	if min > max then
		error("[Random] min cannot be greater than max")
	end
	if precision and (precision < 0 or math.floor(precision) ~= precision) then
		error("[Random] precision must be a non-negative integer")
	end
	precision = precision or 5
	local value = min + (max - min) * self.rng:NextNumber()
	return apply_precision(value, precision)
end

function RandomModule:WeightedRandomFloat(min: number, max: number, mode: number?): number
	if type(min) ~= "number" or type(max) ~= "number" then
		error("[Random] min and max must be numbers")
	end
	mode = mode or (min + max) / 2
	if mode < min or mode > max then
		error("[Random] mode must be between min and max")
	end
	local u = self.rng:NextNumber()
	local c = (mode - min) / (max - min)
	if u <= c then
		return min + math.sqrt(u * (max - min) * (mode - min))
	else
		return max - math.sqrt((1 - u) * (max - min) * (max - mode))
	end
end


function RandomModule:RandomVector3(minX: number, maxX: number, minY: number, maxY: number, minZ: number, maxZ: number, precision: number?): vector
	-- Validate input ranges
	if minX > maxX then
		error(string.format("Invalid range for X: minX (%f) must be <= maxX (%f)", minX, maxX))
	end
	if minY > maxY then
		error(string.format("Invalid range for Y: minY (%f) must be <= maxY (%f)", minY, maxY))
	end
	if minZ > maxZ then
		error(string.format("Invalid range for Z: minZ (%f) must be <= maxZ (%f)", minZ, maxZ))
	end

	-- Validate precision
	if precision and (precision < 0 or math.floor(precision) ~= precision) then
		error(string.format("Precision must be a non-negative integer, got %s", tostring(precision)))
	end

	precision = precision or 0

	local rx, ry, rz = self:RandomFloat(minX, maxX, precision), self:RandomFloat(minY, maxY, precision), self:RandomFloat(minZ, maxZ, precision)

	return vector.create(rx, ry, rz)
end

function RandomModule:RandomVector2(minX: number, maxX: number, minY: number, maxY: number,  precision: number?): Vector2
	-- Validate input ranges
	if minX > maxX then
		error(string.format("Invalid range for X: minX (%f) must be <= maxX (%f)", minX, maxX))
	end
	if minY > maxY then
		error(string.format("Invalid range for Y: minY (%f) must be <= maxY (%f)", minY, maxY))
	end

	-- Validate precision
	if precision and (precision < 0 or math.floor(precision) ~= precision) then
		error(string.format("Precision must be a non-negative integer, got %s", tostring(precision)))
	end

	precision = precision or 0

	local rx, ry = self:RandomFloat(minX, maxX, precision), self:RandomFloat(minY, maxY,precision)

	return Vector2.new(rx, ry)
end

function RandomModule:RandomCFrame(position: {minX: number, maxX: number, minY: number, maxY: number, minZ: number, maxZ: number}, orientation: {minX: number, maxX: number, minY: number, maxY: number, minZ: number, maxZ: number}, precision: number?): CFrame

	local RandomPosition = self:RandomVector3(position.minX, position.maxX, position.minY, position.maxY, position.minZ, position.maxZ, precision)

	local ro = self:RandomVector3(orientation.minX, orientation.maxX, orientation.minY, orientation.maxY, orientation.minZ, orientation.maxZ, precision)

	local RandomOrientation = CFrame.Angles(math.rad(ro.x), math.rad(ro.y), math.rad(ro.z))

	return CFrame.new(RandomPosition) * RandomOrientation

end

function RandomModule:RandomColor3(minR, maxR, minG, maxG, minB, maxB, precision): Color3

	local rR, rG, rB = self:RandomFloat(minR, maxR, precision), self:RandomFloat(minG, maxG, precision), self:RandomFloat(minB, maxB, precision)

	return Color3.fromRGB(rR,rG, rB)

end

function RandomModule:RandomUdim2(useScale: boolean, minX: number, maxX: number, minY: number, maxY: number, precision: number?): UDim2

	if useScale == nil then
		useScale = true
	end

	local func = useScale == true and UDim2.fromScale or UDim2.fromOffset

	local rX, rY = self:RandomFloat(minX, maxX, precision), self:RandomFloat(minY, maxY, precision)

	return func(rX, rY)

end

function RandomModule:RandomUdim(useScale: boolean, min: number, max: number, precision: number?): UDim
	if min > max then
		error("[Random] Invalid range: min must be <= max")
	end
	if precision and (precision < 0 or math.floor(precision) ~= precision) then
		error("[Random] Precision must be a non-negative integer")
	end
	precision = precision or 0
	local value = self:RandomFloat(min, max, precision)
	return UDim.new(useScale and value or 0, useScale and 0 or value)
end


return RandomModule