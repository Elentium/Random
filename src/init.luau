--!strict
--!native
--!optimize 2
--[[
	Random V2.0.6 [by IAMNOTULTRA3]
	
	Reworked and heavily optimized version of my old Random module
	
	LINKS:
	github "https://github.com/Elentium/Random"
	wally "elentium/random@2.0.62"

	What's new
	2.0.0:
	- drastically improved performance
	- the code is now AOT compiled into machine code when possible (via native code gen)
	- removed redundancy
	- cleaner API & documentation
	- descriptive comments in almost every function
    
    2.0.5:
    - new function `RandomObject:WeightedChoice`
    - updated github repo
    - created wally package
    - full support to vscode + rojo + rokit + wally combo
	
	2.0.6:
	- fixed typos & small inconsistencies
	
	Members:
	- `RandomClass`: original class/module
	- `RandomObject` RandomClass object with all the api
	- `range`: table that contains "min" and "max" numbers
	- `blacklist`: map with blacklisted values (the random generator will not return any of the blacklisted values)
		structure:
		{
		[blacklistedValue] = true,
		...
		}
	- `precision`: The number of digits after the decimal point in the float
		
	Warnings:
	- Do not overuse blacklists, if blacklists contain >90% of possible numbers, it will affect performance a lot (does not affect RandomObject:Choice or RandomObject:ChooseMultiple)
	- Do not use RandomObject.Method(...) as it will result in an error, always make sure to do RandomObject:Method(...)
	- Native code generation is only available on the server (in live games), You can still use the module on client, its just that the code will be executed in a standard way
	- When passing min and max, min must not be greater than max

	API:
	- `RandomClass.new(seed: number?) -> RandomObject`
		Description:
		creates a RandomObject with the given seed
		
		Arguments:
		- [optional] `seed`: a seed based on which the pseudo-random generator makes the random numbers, if not provided, the seed will be automatically randomly generated internally
		
		Returns:
		- `RandomObject`
	- `RandomObject:Integer(min: number, max: number, blacklist: blacklist?) -> number`
		Description:
		returns a pseudo-randomly generated integer between min and max
		
		Arguments:
		- `min`: minimum value
		- `max`: maximum value
		- [optional] `blacklist`
		
		Returns:
		- `number(int)`
	- `RandomObject:Float(min: number, max: number, precision: number?) -> number`
		Description:
		returns a pseudo-randomly generated float between min and max
		
		Arguments:
		- `min`: minimum value
		- `max`: maximum value
		- [optional] `precision`
		
		Returns:
		- `number(float)`
	- `RandomObject:Choice(container: table<any, any>, blacklist: blacklist?) -> (any(value), any(key))`
		Description:
		pseudo-randomly chooses a random key from the `container`, returns the value(table[key]) and the key itself
		
		Arguments:
		- `container`: the table to choose from (can be both array or map)
		- [optional] `blacklist`
		
		Returns:
		- `any(value)`: the value from container[key]
		- `any(key)`: the key itself
    - `RandomObject:BlazeChoice(container: { any }) -> (any(value), number(index))`
		Description:
		pseudo-randomly chooses a random intger between 1, #container, returns the value(array[index]) and the index itself
        way faster compared to RandomObject:Choice as it does not have any asserts/blacklists, and instantly does the pseudo-random choice
        the container must be array in order for this to work
		
		Arguments:
		- `container`: the array to choose from
		
		Returns:
		- `any(value)`: the value from container[index]
		- `number(index)`: the index itself
    - `RandomObject:ChooseMultiple(container: table<any, any>, amount: number(int), blacklist: blacklist?, allowDuplicates: boolean?) -> table<any, any?>`
        Description:
        pseudo-randomly chooses a random key from the `container` `amount` times, stores all the choices in a map and returns it
        uses RandomObject:Choice, which means any type of table is supported

        Arguments:
        - `container`: the table to choose from (can be both array or map)
        - `amount`: how many choices are needed to be made
        - [optional] `blacklist`
        - [optional] `allowDuplicates`: determines whether to allow or not duplicated choices

        Returns:
        - `map({[key]: value})`
    - `RandomObject:Vector3(x: range, y: range, z: range, precision: precision?) -> vector`
        Description:
        generates a pseudo-random Vector3 based on given ranges
        it returns `vector` type and uses `vector.create` because it is a more lightweight version of Vector3,
        roblox engine recognizes `vector` as `Vector3` so no worries, everything will work the same as with `Vector3`

        Arguments:
        - `x`: table that contains min and max floats
        - `y`: table that contains min and max floats
        - `z`: table that contains min and max floats
        - [optional] `precision`

        Returns:
        - `vector(Vector3)`
    - `RandomObject:Vector2(x: range, y: range, precision: precision?) -> Vector2`
        Description:
        generates a pseudo-random Vector2 based on given ranges
        it returns `Vector2` type and uses `Vector2.new`

        Arguments:
        - `x`: table that contains min and max floats
        - `y`: table that contains min and max floats
        - [optional] `precision`

        Returns:
        - `Vector2`
    - `RandomObject:UnitVector() -> vector`
        Description:
        generates a pseudo-random unit(directional) vector (Vector3)

        Arguments: ()

        Returns: vector(Vector3)
    - `RandomObject:UDim2(x: range, y: range) -> UDim2`
        Description:
        generates a pseudo-random UDim2 based on the given ranges
        the x and y will be assigned to offset, if you need a scaled UDim2, consider using RandomObject:UDim2Scaled

        Arguments:
        - `x`: table that contains min and max integers
        - `y`: table that contains min and max integers

        Returns:
        - `UDim2`

    - `RandomObject:UDim2Scaled(x: range, y: range, precision: precision?) -> UDim2`
        Description:
        generates a pseudo-random UDim2 based on the given ranges
        the x and y will be assigned to scale, if you need a normal UDim2, consider using RandomObject:UDim2

        Arguments:
        - `x`: table that contains min and max integers
        - `y`: table that contains min and max integers
        - [optional] `precision`

        Returns:
        - `UDim2
    - `RandomObject:Color3() -> Color3`
        Description:
        generates a pseudo-random Color3
        r/g/b ranges are [0-1]

        Arguments: ()

        Returns:
        - `Color3`

    - `RandomObject:CFrame(position: { x: range, y: range, z: range }, allowedAxes: ("" | "X" | "Y" | "Z" | "XY" | "XZ" | "YZ" | "XYZ")?, precision: precision?) -> CFrame`
        Description:
        generates a pseudo-random CFrame within a specified 3D range and applies optional rotation
        this is useful for spawning objects within a volume with randomized orientations

        Arguments:
        - `position`: a table containing x, y, and z `range` tables for the translation
        - [optional] `allowedAxes`: a string determining which axes should receive a random rotation (0 to 2π)
        - [optional] `precision`: numerical precision for the position coordinates

        Returns:
        - `CFrame`
    - `RandomObject:Clone() -> RandomObject`
        Description:
        clones the current RandomObject and returns the cloned one
        also clones the RbxInstance

        Arguments: ()

        Returns:
        - `RandomObject`
    - `RandomObject:Destroy() -> ()`
        Description:
        destroys the current object (cleans the table and disables the metatable which results in a blank table)

        Arguments: ()

        Returns: ()
    
    - `RandomObject:WeightedChoice(container: { { weight: number, item: any } }, totalWeight: number) -> (any(item), number(weight))`
        Description:
        pseudo-randomly chooses an item based on its weight relative to the `totalWeight`. 
        Uses a linear scan algorithm which is order-independent and statistically accurate.
        The container must be an array of tables containing "weight" and "item" fields.

        Arguments:
        - `container`: an array of tables(e.g, { {weight = 10, item = "Gold"}, {weight = 90, item = "Dirt"} })
        - `totalWeight`: the pre-calculated sum of all weights in the container

        Returns:
        - `any(item)`: the item associated with the chosen weight
        - `number(weight)`: the weight of the chosen item
]]

local RBX_Random = Random
local math_round = math.round

-- Types

type table<K = any, V = any> = {
	[K]: V,
}

type Function<A... = (), R... = ()> = (A...) -> R...

type range = { min: number, max: number }

export type RandomObject = {
	RbxInstance: Random,

	Integer: (self: any, min: number, max: number, blacklist: table<number, boolean>?) -> number,
	Float: (self: any, min: number, max: number, precision: number?) -> number,
	Choice: (self: any, container: table<any, any>, blacklist: table<any, boolean>?) -> (any, any),
	BlazeChoice: (self: any, container: { any }) -> (any, number),
	ChooseMultiple: <K, V>(
		self: any,
		container: { [K]: V },
		amount: number,
		blacklist: table<K, boolean>?,
		allowDuplicates: boolean?
	) -> table<K, any?>,

	Vector3: (self: any, x: range, y: range, z: range, precision: number?) -> vector,
	Vector2: (self: any, x: range, y: range, precision: number?) -> Vector2,
	UnitVector: (self: any) -> vector,

	UDim2: (self: any, x: range, y: range) -> UDim2,
	UDim2Scaled: (self: any, x: range, y: range, precision: number?) -> UDim2,

	Color3: (self: any) -> Color3,

	CFrame: (
		self: any,
		position: { x: range, y: range, z: range },
		allowedAxes: ("" | "X" | "Y" | "Z" | "XY" | "XZ" | "YZ" | "XYZ")?,
		precision: number?
	) -> CFrame,

	Clone: (self: any) -> RandomObject,
	Destroy: (self: any) -> (),
}
export type RandomClass = {
	new: (seed: number?) -> RandomObject,
}

-- Core
local Random = {}
Random.__index = Random

local function validateRange(unit: range)
	-- function
	-- validate process:
	-- ensure the `unit` is a table
	-- ensure `min` and `max` are numbers
	-- ensure min is not greater than max
	return typeof(unit) == "table"
		and typeof(unit.min) == "number"
		and typeof(unit.max) == "number"
		and unit.min <= unit.max
end

local function RandomWithBlacklist<A...>(fn: Function<A..., (any)>, blacklist: table<any, boolean>?, ...: A...): any
	-- function
	-- call the random function
	-- check whether the result is blacklisted
	-- if it is, jump at the beginning of the function and repeat the process
	-- if it is not, smiply return the result
	local r = fn(...)
	return ((blacklist ~= nil and blacklist[r] and RandomWithBlacklist(fn, blacklist, ...)) or r)
end

local function RoundToPrecision(value: number, precision: number): number
	-- function
	-- define the scale factor based on 10 to the power of precision
	-- multiply the value by the factor to shift decimals into the integer position
	-- apply rounding to the scaled number
	-- divide by the factor to shift decimals back to their original position

	local factor = 10 ^ precision
	return math_round(value * factor) / factor
end

-- API
function Random.new(seed: number?): RandomObject
	return setmetatable({
		RbxInstance = RBX_Random.new(seed),
	}, Random) :: any
end

function Random.Integer(self: RandomObject, min: number, max: number, blacklist: table<any, boolean>?): number
	-- assert
	if getmetatable(self :: any) ~= Random then
		error(`Invalid random object`)
	elseif typeof(min) ~= "number" then
		error(`Invalid argument #1, number expected, got {typeof(min)}`)
	elseif typeof(max) ~= "number" then
		error(`Invalid argument #2, number expected, got {typeof(max)}`)
	elseif blacklist ~= nil and typeof(blacklist) ~= "table" then
		error(`Invalid argument #3, table expected, got {typeof(blacklist)}`)
	elseif min > max then
		error(`min cannot be greater than max`)
	end

	-- function
	return RandomWithBlacklist(self.RbxInstance.NextInteger, blacklist, self.RbxInstance, min, max)
end

function Random.Float(self: RandomObject, min: number, max: number, precision: number?): number
	-- assert
	if getmetatable(self :: any) ~= Random then
		error(`Invalid random object`)
	elseif typeof(min) ~= "number" then
		error(`Invalid argument #1, number expected, got {typeof(min)}`)
	elseif typeof(max) ~= "number" then
		error(`Invalid argument #2, number expected, got {typeof(max)}`)
	elseif precision ~= nil and typeof(precision) ~= "number" then
		error(`Invalid argument #3, number expected, got {typeof(precision)}`)
	elseif min > max then
		error(`min cannot be greater than max`)
	end

	-- function
	-- generate a random float between min and max
	-- if precision argument provided, round the number to the given precision
	local result = self.RbxInstance:NextNumber(min, max)
	if precision then
		return RoundToPrecision(result, precision)
	else
		return result
	end
end

function Random.Choice(self: RandomObject, container: table<any, any>, blacklist: table<any, boolean>?): (any, any)
	-- assert
	if getmetatable(self :: any) ~= Random then
		error(`Invalid random object`)
	elseif typeof(container) ~= "table" then
		error(`Invalid argument #1, table expected, got {typeof(container)}`)
	elseif blacklist ~= nil and typeof(blacklist) ~= "table" then
		error(`Invalid argument #2, table expected, got {typeof(blacklist)}`)
	elseif not next(container) then
		return nil, nil
	end

	-- function
	-- make an array that contains all the `container` keys (except for the keys that are blacklisted)
	-- make sure that there are available keys, if there is not = return nothing(nil)
	-- otherwise pseudo-randomly choose the key and return the value, key that is chosen
	local keys: { any } = {}
	for k in container do
		if blacklist and blacklist[k] then
			continue
		end

		table.insert(keys, k)
	end

	local n = #keys
	if n < 1 then
		return nil, nil
	end
	local choice = self.RbxInstance:NextInteger(1, n)
	local key = keys[choice]
	return container[key], key
end

function Random.BlazeChoice(self: RandomObject, container: { any }): (any, number)
	-- function
	-- get the length of container(array)
	-- pseudo-randomly choose an index
	-- return the value, index
	local n = #container
	local choice = self.RbxInstance:NextInteger(1, n)
	return container[choice], choice
end

function Random.ChooseMultiple(
	self: RandomObject,
	container: table<any, any>,
	amount: number,
	blacklist: table<any, boolean>?,
	allowDuplicates: boolean?
): table<any, any?>
	-- assert
	if getmetatable(self :: any) ~= Random then
		error(`Invalid random object`)
	elseif typeof(container) ~= "table" then
		error(`Invalid argument #1, table expected, got {typeof(container)}`)
	elseif blacklist ~= nil and typeof(blacklist) ~= "table" then
		error(`Invalid argument #2, table expected, got {typeof(blacklist)}`)
	elseif not next(container) then
		return {}
	end

	-- function
	-- make a table that will contain all the chosen key-value pairs
	-- pseudo-randomly choose a value, key using RandomObject:Choice
	-- store it in the choices table
	-- if no duplicates allowed, simply store the key in a blacklist
	-- return the choices
	local choices = {}
	for _ = 1, amount do
		local value, key = self:Choice(container, blacklist)
		if value == nil then
			break
		end
		choices[key] = value
		if allowDuplicates == false then
			blacklist = blacklist or {}
			(blacklist :: table<any, boolean>)[key] = true
		end
	end

	return choices
end

function Random.Vector3(self: RandomObject, x: range, y: range, z: range, precision: number?): vector
	-- assert
	if getmetatable(self :: any) ~= Random then
		error(`Invalid random object`)
	elseif not validateRange(x) or not validateRange(y) or not validateRange(z) then
		error(`Invalid define unit (X/Y/Z)`)
	elseif precision ~= nil and typeof(precision) ~= "number" then
		error(`Invalid argument #4, number expected, got {typeof(precision)}`)
	end

	-- function
	-- generate pseudo-random X, Y, Z floats
	-- make a vector with the pseudo-random floats (vector = Vector3, its just that vector is a bit more lightweight, vector is recognized by Roblox Engine as Vector3)
	-- return the vector
	local rX = self:Float(x.min, x.max, precision)
	local rY = self:Float(y.min, y.max, precision)
	local rZ = self:Float(z.min, z.max, precision)

	return vector.create(rX, rY, rZ)
end

function Random.Vector2(self: RandomObject, x: range, y: range, precision: number?): Vector2
	-- assert
	if getmetatable(self :: any) ~= Random then
		error(`Invalid random object`)
	elseif not validateRange(x) or not validateRange(y) then
		error(`Invalid define unit (X/Y)`)
	elseif precision ~= nil and typeof(precision) ~= "number" then
		error(`Invalid argument #3, number expected, got {typeof(precision)}`)
	end

	-- function
	-- generate pseudo-random X, Y floats
	-- make a Vector2 with the pseudo-random floats and return it
	local rX = self:Float(x.min, x.max, precision)
	local rY = self:Float(y.min, y.max, precision)

	return Vector2.new(rX, rY)
end

function Random.Color3(self: RandomObject): Color3
	-- assert
	if getmetatable(self :: any) ~= Random then
		error(`Invalid random object`)
	end

	-- function
	-- generate pseudo-random R, G, B floats [between the 0-1 range]
	-- return the created Color3
	local R = self.RbxInstance:NextNumber()
	local G = self.RbxInstance:NextNumber()
	local B = self.RbxInstance:NextNumber()
	return Color3.new(R, G, B)
end

function Random.UDim2(self: RandomObject, x: range, y: range): UDim2
	-- assert
	if getmetatable(self :: any) ~= Random then
		error(`Invalid random object`)
	elseif not validateRange(x) or not validateRange(y) then
		error(`Invalid define unit (X/Y)`)
	end

	-- function
	-- generate pseudo-random x, y integers (between min and max ranges)
	-- create a UDim2 with the generated integers and return it
	local rx = self.RbxInstance:NextInteger(x.min, x.max)
	local ry = self.RbxInstance:NextInteger(y.min, y.max)

	return UDim2.fromOffset(rx, ry)
end

function Random.UDim2Scaled(self: RandomObject, x: range, y: range, precision: number?): UDim2
	-- assert
	if getmetatable(self :: any) ~= Random then
		error(`Invalid random object`)
	elseif not validateRange(x) or not validateRange(y) then
		error(`Invalid define unit (X/Y)`)
	end

	-- function
	-- same as RandomObject:UDim2, except this time the UDim2 X and Y will be scaled
	-- generate pseudo-random x and y floats between the given ranges
	-- create a scaled UDim2 and return it
	local rx = self:Float(x.min, x.max, precision)
	local ry = self:Float(y.min, y.max, precision)

	return UDim2.fromScale(rx, ry)
end

function Random.CFrame(
	self: RandomObject,
	position: { x: range, y: range, z: range },
	allowedAxes: ("" | "X" | "Y" | "Z" | "XY" | "XZ" | "YZ" | "XYZ")?,
	precision: number?
): CFrame
	-- assert
	if getmetatable(self :: any) ~= Random then
		error("Invalid random object")
	end

	-- function
	-- define the active rotation axes or default to an empty string
	-- generate a pseudo-random position vector using the provided ranges and precision
	-- check for allowed rotation axes and generate random angles (0 to 2π) for matched axes
	-- create a translation CFrame from the position
	-- combine the translation with the calculated Euler rotation and return the result

	local axes = allowedAxes or ""

	local finalPos = self:Vector3(position.x, position.y, position.z, precision)

	local rotX = string.find(axes, "X") and (self.RbxInstance:NextNumber(0, math.pi * 2)) or 0
	local rotY = string.find(axes, "Y") and (self.RbxInstance:NextNumber(0, math.pi * 2)) or 0
	local rotZ = string.find(axes, "Z") and (self.RbxInstance:NextNumber(0, math.pi * 2)) or 0

	return CFrame.new(finalPos :: any) * CFrame.fromEulerAnglesXYZ(rotX, rotY, rotZ)
end

function Random.UnitVector(self: RandomObject): vector
	-- assert
	if getmetatable(self :: any) ~= Random then
		error("Invalid random object")
	end

	-- function
	-- simply return already existing NextUnitVector
	return self.RbxInstance:NextUnitVector() :: any
end

function Random.WeightedChoice(
	self: RandomObject,
	container: table<number, { weight: number, item: any }>,
	totalWeight: number
): (any, number)
	-- assert
	if getmetatable(self :: any) ~= Random then
		error("Invalid random object")
	elseif #container == 0 or typeof(container[1].weight) ~= "number" then
		error(`Invalid container structure, please check documentation to ensure the structure is correct`)
	elseif typeof(totalWeight) ~= "number" then
		error(`Invalid argument #2, number expected, got {typeof(totalWeight)}`)
	end

	-- function
	-- generate a random float between 0 and total weight
	-- iterate through the container, add the weight to the current weight,
	-- if the random float is less than or equal to the current weight then return the choice and the choice weight

	local rand = self.RbxInstance:NextNumber(0, totalWeight)
	local current = 0
	for _, value in container do
		current += value.weight
		if rand <= current then
			return value.item, value.weight
		end
	end

	-- This is only possible if the structure is incorrect
	warn(`Logic error occurred, returning the last item`)
	local last = container[#container]
	return last.item, last.weight
end

-- here we annotate self as table & RandomObject because strict type checker gives an errror "Cannot iterate over a table without an indexer" if we annotate it just RandomObject
function Random.Destroy(self: table & RandomObject): ()
	-- assert
	if getmetatable(self :: any) ~= Random then
		error(`Invalid random object`)
	end

	-- function
	-- clear all its attributes
	-- disable the metatable from the object, making it just a blank table
	for k in self :: any do
		self[k] = nil
	end
	setmetatable(self, nil)
end

function Random.Clone(self: RandomObject): RandomObject
	-- assert
	if getmetatable(self :: any) ~= Random then
		error(`Invalid random object`)
	end

	-- function
	-- clone the object and the RbxInstance inside of it
	-- enable metatable for the cloned object
	local clone = table.clone(self)
	clone.RbxInstance = clone.RbxInstance:Clone()
	setmetatable(clone, Random)
	return clone :: any
end

return table.freeze(Random :: RandomClass)
