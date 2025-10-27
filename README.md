# Random
A comprehensive randomization library for Roblox, built on top of Random.new() for enhanced precision, flexibility, and deterministic randomness when seeded.
Developed by IAMNOTULTRA3 under the MIT License.

# Overview
RandomModule provides an easy-to-use interface for generating random numbers, objects, vectors, colors, and more—while maintaining reproducibility via seeding.
It extends Roblox's Random class with additional utilities for weighted selection, random geometry generation, and multi-item choices.

# Features
- Seed-based reproducible randomness
- Weighted and unbiased random selection
- Randomized generation for Color3, Vector2, Vector3, CFrame, UDim, and UDim2
- Multi-choice selection with or without duplicates
- Precision control for float-based randoms
- Triangular (biased) random distributions

# Installation
Insert the `Random.rbxm` in ReplicatedStorage or ServerScriptService, then:
```luau
local Random = require(game.ServerScriptService.RandomModule)
local rng = Random.new() -- or Random.new(seed)
```
# Usage Examples
Create a Random Instance
```luau
local Random = require(game.ServerScriptService.RandomModule)
local rng = Random.new(123) -- seeded for deterministic results
```
Generate a Random Float
```luau
local value = rng:RandomFloat(0, 1)
print("Random float:", value)
```
Pick a Random Item from a Table
```luau
local cars = {
	Ferrari = { Price = 125000 },
	BMW = { Price = 95000 }
}
local car, name = rng:Choice(cars)
print(name .. "'s price is:", car.Price)
```
Weighted Random Selection
```luau
local items = {
	{ name = "Sword", weight = 0.5 },
	{ name = "Shield", weight = 0.3 },
	{ name = "Potion", weight = 0.2 }
}
local item = rng:WeightedChoice(items)
print("You received:", item.name)
```
Multiple Random Choices
```luau
local colors = {"Red", "Blue", "Green", "Yellow"}
local picks = rng:ChooseMultiple(colors, 2)
print("Selected colors:", table.concat(picks, ", "))
```
Random Color
```luau
local color = rng:RandomColor3(0, 255, 0, 255, 0, 255)
print("Random Color:", color)
```
Random Vector3
```luau
local position = rng:RandomVector3(-10, 10, 0, 5, -10, 10)
print("Random Position:", position)
```
Random CFrame
```luau
local cframe = rng:RandomCFrame(
	{ minX = -10, maxX = 10, minY = 0, maxY = 5, minZ = -10, maxZ = 10 },
	{ minX = 0, maxX = 360, minY = 0, maxY = 360, minZ = 0, maxZ = 360 }
)
print("Random CFrame:", cframe)
```

# Method	                                                        Description
`RandomModule.new(seed: number?) -> Random `                      Creates a new RNG instance, optionally seeded
`Random:Choice(tbl, blacklist?) -> (any, any?)	`                 Selects a random item, optionally excluding blacklisted values
`Random:RandomInteger(x, y, blacklist?) -> number`                Random integer between x and y
`Random:WeightedChoice(tbl, weightKey?) -> any`                   Chooses an item based on weight probabilities
`Random:ChooseMultiple(tbl, n, allowDuplicates?) -> {any}`        Selects multiple items
`Random:RandomFloat(min, max, precision?) -> number	 `            Random float with optional rounding
`Random:WeightedRandomFloat(min, max, mode?) -> number`           Triangular (biased) random float
`Random:RandomColor3(...) -> Color3`                              Randomized RGB color
`Random:RandomVector3(...) -> vector`                             Random 3D position using vector library
`Random:RandomVector2(...) -> Vector2`                            Random 2D vector
`Random:RandomCFrame(position, orientation, precision?) -> CFrame`Random 3D transformation
`Random:RandomUdim2(useScale, ...) -> UDim2	`                     Random UI UDim2 value
`Random:RandomUdim(useScale, ...) -> UDim	   `                    Random UI UDim value
