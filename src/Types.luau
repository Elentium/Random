export type Range = { min: number, max: number }

export type RandomObject = {
	RbxInstance: Random,

	Integer: (self: RandomObject, min: number, max: number, blacklist: { [number]: boolean }?) -> number,
	Float: (self: RandomObject, min: number, max: number, precision: number?) -> number,
	Choice: <K, V>(self: RandomObject, container: { [K]: V }, blacklist: { [K]: boolean }?) -> (V, K),
	BlazeChoice: <V>(self: RandomObject, container: { V }) -> (V, number),
	ChooseMultiple: <K, V>(
		self: RandomObject,
		container: { [K]: V },
		amount: number,
		blacklist: { [K]: boolean }?,
		allowDuplicates: boolean?
	) -> { [K]: V },
	WeightedChoice: (
		self: RandomObject,
		container: { { weight: number, item: any } },
		totalWeight: number
	) -> (any, number),

	Vector3: (self: RandomObject, x: Range, y: Range, z: Range, precision: number?) -> Vector3,
	Vector2: (self: RandomObject, x: Range, y: Range, precision: number?) -> Vector2,
	UnitVector: (self: RandomObject) -> Vector3,

	UDim2: (self: RandomObject, x: Range, y: Range) -> UDim2,
	UDim2Scaled: (self: RandomObject, x: Range, y: Range, precision: number?) -> UDim2,

	Color3: (self: RandomObject) -> Color3,

	CFrame: (
		self: RandomObject,
		position: { x: Range, y: Range, z: Range },
		allowedAxes: ("" | "X" | "Y" | "Z" | "XY" | "XZ" | "YZ" | "XYZ")?,
		precision: number?
	) -> CFrame,

	Clone: (self: RandomObject) -> RandomObject,
	Destroy: (self: RandomObject) -> (),
}

-- export type RandomNative = { <-- release when integer library gets added to roblox
-- 	Seed: integer,

-- 	Integer: (self: RandomNative, min: integer, max: integer) -> integer,
-- 	IntegerNum: (self: RandomNative, min: number, max: number) -> number,
-- 	Float: (self: RandomNative, min: number?, max: number?) -> number,
-- 	Vector: & ((self: RandomNative) -> vector)
-- 		& ((self: RandomNative, axisMin: number, axisMax: number) -> vector)
-- 		& ((
-- 			self: RandomNative,
-- 			xMin: number,
-- 			xMax: number,
-- 			yMin: number,
-- 			yMax: number,
-- 			zMin: number?,
-- 			zMax: number?
-- 		) -> vector),
-- 	Choice: <K, V>(self: RandomNative, container: { [K]: V }) -> (V, K),
-- 	ChooseMultiple: <K, V>(
-- 		self: RandomNative,
-- 		container: { [K]: V },
-- 		amount: number,
-- 		allowDuplicates: boolean?
-- 	) -> { [K]: V },

-- 	Destroy: (self: RandomNative) -> (),
-- 	Clone: (self: RandomNative) -> RandomNative,
-- }

export type RandomClass = {
	new: (seed: number?) -> RandomObject,
	-- native: (seed: number?) -> RandomNative, <-- release when integer library gets added to roblox
}

return nil
