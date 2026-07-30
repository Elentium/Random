--!optimize 2
--[[
	Random V2.1.0 [by IAMNOTULTRA3]
	
	Reworked and heavily optimized version of my old Random module
	
	LINKS:
	github "https://github.com/Elentium/Random"
	wally "elentium/random@2.1.0"

	What's new
	2.0.0:
	- drastically improved performance
	- removed redundancy
	- cleaner API & documentation
	- descriptive comments in almost every function
    
    2.0.5:
    - new function `RandomObject:WeightedChoice`
    - updated github repo
    - created wally package
	
	2.0.6:
	- fixed typos & small inconsistencies

	2.1.0:
	- code organization improvement
	- improved Luau types (generics, `{ [K]: V }` table syntax)
	- performance improvements
	- `Vector3` and `UnitVector` now return `Vector3` (uses `Vector3.new`)
	
	Members:
	- `RandomClass`: original class/module
	- `RandomObject`: RandomClass object with all the API
	- `Range`: table that contains `min` and `max` numbers (`{ min: number, max: number }`)
	- `blacklist`: map with blacklisted values (the random generator will not return any of the blacklisted values)
		- for `Integer`: `{ [number]: boolean }`
		- for `Choice` / `ChooseMultiple`: `{ [K]: boolean }` (keys from the container)
		structure:
		{
			[blacklistedValue] = true,
			...
		}
	- `precision`: the number of digits after the decimal point in the float
		
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
	- `RandomObject:Integer(min: number, max: number, blacklist: { [number]: boolean }?) -> number`
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
	- `RandomObject:Choice<K, V>(container: { [K]: V }, blacklist: { [K]: boolean }?) -> (V, K)`
		Description:
		pseudo-randomly chooses a random key from the `container`, returns the value (`container[key]`) and the key itself
		
		Arguments:
		- `container`: the table to choose from (array or map)
		- [optional] `blacklist`: blacklisted keys from the container
		
		Returns:
		- `V`: the value from `container[key]`
		- `K`: the chosen key
    - `RandomObject:BlazeChoice<V>(container: { V }) -> (V, number)`
		Description:
		pseudo-randomly chooses a random integer between 1 and `#container`, returns the value (`container[index]`) and the index itself
        way faster compared to `RandomObject:Choice` as it has no validation or blacklists and instantly does the pseudo-random choice
        the container must be an array for this to work
		
		Arguments:
		- `container`: the array to choose from
		
		Returns:
		- `V`: the value from `container[index]`
		- `number`: the chosen index
    - `RandomObject:ChooseMultiple<K, V>(container: { [K]: V }, amount: number, blacklist: { [K]: boolean }?, allowDuplicates: boolean?) -> { [K]: V }`
        Description:
        pseudo-randomly chooses a random key from the `container` `amount` times, stores all the choices in a map and returns it
        uses `RandomObject:Choice`, which means any type of table is supported

        Arguments:
        - `container`: the table to choose from (array or map)
        - `amount`: how many choices need to be made
        - [optional] `blacklist`: blacklisted keys from the container
        - [optional] `allowDuplicates`: whether duplicated choices are allowed (defaults to `false`)

        Returns:
        - `{ [K]: V }`: map of chosen key-value pairs
    - `RandomObject:Vector3(x: Range, y: Range, z: Range, precision: number?) -> Vector3`
        Description:
        generates a pseudo-random Vector3 based on given ranges
        uses `Vector3.new` with pseudo-random floats for each axis

        Arguments:
        - `x`: `Range` table for the X axis
        - `y`: `Range` table for the Y axis
        - `z`: `Range` table for the Z axis
        - [optional] `precision`

        Returns:
        - `Vector3`
    - `RandomObject:Vector2(x: Range, y: Range, precision: number?) -> Vector2`
        Description:
        generates a pseudo-random Vector2 based on given ranges
        uses `Vector2.new` with pseudo-random floats for each axis

        Arguments:
        - `x`: `Range` table for the X axis
        - `y`: `Range` table for the Y axis
        - [optional] `precision`

        Returns:
        - `Vector2`
    - `RandomObject:UnitVector() -> Vector3`
        Description:
        generates a pseudo-random unit (directional) vector

        Arguments: ()

        Returns:
        - `Vector3`
    - `RandomObject:UDim2(x: Range, y: Range) -> UDim2`
        Description:
        generates a pseudo-random UDim2 based on the given ranges
        the x and y will be assigned to offset; if you need a scaled UDim2, consider using `RandomObject:UDim2Scaled`

        Arguments:
        - `x`: `Range` table for the X offset (integers)
        - `y`: `Range` table for the Y offset (integers)

        Returns:
        - `UDim2`

    - `RandomObject:UDim2Scaled(x: Range, y: Range, precision: number?) -> UDim2`
        Description:
        generates a pseudo-random UDim2 based on the given ranges
        the x and y will be assigned to scale; if you need a normal UDim2, consider using `RandomObject:UDim2`

        Arguments:
        - `x`: `Range` table for the X scale
        - `y`: `Range` table for the Y scale
        - [optional] `precision`

        Returns:
        - `UDim2`
    - `RandomObject:Color3() -> Color3`
        Description:
        generates a pseudo-random Color3
        r/g/b ranges are [0-1]

        Arguments: ()

        Returns:
        - `Color3`

    - `RandomObject:CFrame(position: { x: Range, y: Range, z: Range }, allowedAxes: ("" | "X" | "Y" | "Z" | "XY" | "XZ" | "YZ" | "XYZ")?, precision: number?) -> CFrame`
        Description:
        generates a pseudo-random CFrame within a specified 3D range and applies optional rotation
        useful for spawning objects within a volume with randomized orientations

        Arguments:
        - `position`: a table containing `x`, `y`, and `z` `Range` tables for the translation
        - [optional] `allowedAxes`: which axes receive a random rotation (0 to 2π)
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
    
    - `RandomObject:WeightedChoice(container: { { weight: number, item: any } }, totalWeight: number) -> (any, number)`
        Description:
        pseudo-randomly chooses an item based on its weight relative to `totalWeight`
        uses a linear scan algorithm which is order-independent and statistically accurate
        the container must be an array of tables containing `weight` and `item` fields

        Arguments:
        - `container`: an array of tables (e.g. `{ { weight = 10, item = "Gold" }, { weight = 90, item = "Dirt" } }`)
        - `totalWeight`: the pre-calculated sum of all weights in the container

        Returns:
        - `any`: the chosen item
        - `number`: the weight of the chosen item
]]

const RBX_Random = Random

-- Types
const Types = require("@self/Types")

type Range = Types.Range
export type RandomObject = Types.RandomObject
export type RandomClass = Types.RandomClass

-- Core
const Random = {}
Random.__index = Random

const function RandomWithBlacklist<R, A...>(fn: (A...) -> R, blacklist: { [any]: boolean }?, ...: A...): R
	-- call the random function
	-- check whether the result is blacklisted
	-- if it is, jump at the beginning of the function and repeat the process
	-- if it is not, smiply return the result
	const r = fn(...)
	if blacklist and blacklist[r] then
		return (RandomWithBlacklist :: any)(fn, blacklist, ...)
	end
	return r
end

const function RoundToPrecision(value: number, precision: number): number
	-- define the scale factor based on 10 to the power of precision
	-- multiply the value by the factor to shift decimals into the integer position
	-- apply rounding to the scaled number
	-- divide by the factor to shift decimals back to their original position

	const factor = 10 ^ precision
	return math.round(value * factor) / factor
end

-- API
function Random.new(seed: number?): RandomObject
	return setmetatable({
		RbxInstance = RBX_Random.new(seed),
	}, Random) :: RandomObject
end

function Random.Integer(self: RandomObject, min: number, max: number, blacklist: { [number]: boolean }?): number
	return RandomWithBlacklist(self.RbxInstance.NextInteger, blacklist, self.RbxInstance, min, max)
end

function Random.Float(self: RandomObject, min: number, max: number, precision: number?): number
	-- generate a random float between min and max
	-- if precision argument provided, round the number to the given precision
	const result = self.RbxInstance:NextNumber(min, max)
	if precision then
		return RoundToPrecision(result, precision)
	else
		return result
	end
end

function Random.Choice<K, V>(self: RandomObject, container: { [K]: V }, blacklist: { [K]: boolean }?): (V, K)
	blacklist = blacklist or {}

	-- make an array that contains all the `container` keys (except for the keys that are blacklisted)
	-- make sure that there are available keys, if there is not = return nothing(nil)
	-- otherwise pseudo-randomly choose the key and return the value, key that is chosen
	local key = nil
	local i = 0

	const rbxInstance = self.RbxInstance
	for k in container do
		if blacklist[k] then
			continue
		end
		i += 1

		if rbxInstance:NextInteger(1, i) == 1 then
			key = k
		end
	end

	if i == 0 then
		return nil, nil
	end
	return container[key], key
end

function Random.BlazeChoice<V>(self: RandomObject, container: { V }): (V, number)
	-- get the length of container(array)
	-- pseudo-randomly choose an index
	-- return the value, index
	const n = #container
	const choice = self.RbxInstance:NextInteger(1, n)
	return container[choice], choice
end

function Random.ChooseMultiple<K, V>(
	self: RandomObject,
	container: { [K]: V },
	amount: number,
	blacklist: { [K]: boolean }?,
	allowDuplicates: boolean?
): { [K]: V }
	-- make a table that will contain all the chosen key-value pairs
	-- pseudo-randomly choose a value, key using RandomObject:Choice
	-- store it in the choices table
	-- if no duplicates allowed, simply store the key in a blacklist
	-- return the choices
	const choices = {}
	for _ = 1, amount do
		const value, key = self:Choice(container, blacklist)
		if value == nil then
			break
		end
		choices[key] = value
		if not allowDuplicates then
			blacklist = blacklist or {}
			blacklist[key] = true
		end
	end

	return choices
end

function Random.Vector3(self: RandomObject, x: Range, y: Range, z: Range, precision: number?): Vector3
	-- generate pseudo-random X, Y, Z floats
	-- make a Vector3 with the pseudo-random floats
	-- return the vector
	const rX = self:Float(x.min, x.max, precision)
	const rY = self:Float(y.min, y.max, precision)
	const rZ = self:Float(z.min, z.max, precision)

	return Vector3.new(rX, rY, rZ)
end

function Random.Vector2(self: RandomObject, x: Range, y: Range, precision: number?): Vector2
	-- generate pseudo-random X, Y floats
	-- make a Vector2 with the pseudo-random floats and return it
	const rX = self:Float(x.min, x.max, precision)
	const rY = self:Float(y.min, y.max, precision)

	return Vector2.new(rX, rY)
end

function Random.Color3(self: RandomObject): Color3
	const rbxInstance = self.RbxInstance
	const R = rbxInstance:NextNumber()
	const G = rbxInstance:NextNumber()
	const B = rbxInstance:NextNumber()
	return Color3.new(R, G, B)
end

function Random.UDim2(self: RandomObject, x: Range, y: Range): UDim2
	-- generate pseudo-random x, y integers (between min and max ranges)
	-- create a UDim2 with the generated integers and return it
	const rbxInstance = self.RbxInstance
	const rx = rbxInstance:NextInteger(x.min, x.max)
	const ry = rbxInstance:NextInteger(y.min, y.max)

	return UDim2.fromOffset(rx, ry)
end

function Random.UDim2Scaled(self: RandomObject, x: Range, y: Range, precision: number?): UDim2
	-- same as RandomObject:UDim2, except this time the UDim2 X and Y will be scaled
	-- generate pseudo-random x and y floats between the given ranges
	-- create a scaled UDim2 and return it
	const rx = self:Float(x.min, x.max, precision)
	const ry = self:Float(y.min, y.max, precision)

	return UDim2.fromScale(rx, ry)
end

function Random.CFrame(
	self: RandomObject,
	position: { x: Range, y: Range, z: Range },
	allowedAxes: ("" | "X" | "Y" | "Z" | "XY" | "XZ" | "YZ" | "XYZ")?,
	precision: number?
): CFrame
	-- define the active rotation axes or default to an empty string
	-- generate a pseudo-random position vector using the provided ranges and precision
	-- check for allowed rotation axes and generate random angles (0 to 2π) for matched axes
	-- create a translation CFrame from the position
	-- combine the translation with the calculated Euler rotation and return the result
	const axes = allowedAxes or ""

	const finalPos = self:Vector3(position.x, position.y, position.z, precision)

	const rbxInstance = self.RbxInstance

	const rotX = string.find(axes, "X") and (rbxInstance:NextNumber(0, math.pi * 2)) or 0
	const rotY = string.find(axes, "Y") and (rbxInstance:NextNumber(0, math.pi * 2)) or 0
	const rotZ = string.find(axes, "Z") and (rbxInstance:NextNumber(0, math.pi * 2)) or 0

	return CFrame.new(finalPos) * CFrame.fromEulerAnglesXYZ(rotX, rotY, rotZ)
end

function Random.UnitVector(self: RandomObject): Vector3
	-- simply return already existing NextUnitVector
	return self.RbxInstance:NextUnitVector()
end

function Random.WeightedChoice(
	self: RandomObject,
	container: { { weight: number, item: any } },
	totalWeight: number
): (any, number)
	-- function
	-- generate a random float between 0 and total weight
	-- iterate through the container, add the weight to the current weight,
	-- if the random float is less than or equal to the current weight then return the choice and the choice weight

	const rand = self.RbxInstance:NextNumber(0, totalWeight)
	local current = 0
	for _, value in container do
		current += value.weight
		if rand <= current then
			return value.item, value.weight
		end
	end

	-- This is only possible if the structure is incorrect
	warn(`Logic error occurred, returning the last item`)
	const last = container[#container]
	return last.item, last.weight
end

-- here we annotate self as table & RandomObject because strict type checker gives an errror "Cannot iterate over a table without an indexer" if we annotate it just RandomObject
function Random.Destroy(self: { [nil]: nil } & RandomObject): ()
	-- clear all its attributes
	-- disable the metatable from the object, making it just a blank table
	for k in self do
		self[k] = nil
	end
	setmetatable(self, nil)
end

function Random.Clone(self: RandomObject): RandomObject
	-- clone the object and the RbxInstance inside of it
	-- enable metatable for the cloned object
	const clone = table.clone(self)
	clone.RbxInstance = clone.RbxInstance:Clone()
	setmetatable(clone, Random)
	return clone
end

return table.freeze(Random :: RandomClass)
