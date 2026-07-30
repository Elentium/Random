# Random V2.1.0

A high-performance, feature-complete randomization utility for **Roblox Luau**. This module is a heavily optimized rework of the original Random library, designed for Roblox developers who need speed, precision, and advanced filtering such as blacklisting and weighted distribution.

---

## Key Features

* **Smart blacklisting:** Exclude specific values from random results without manual retry loops.
* **Weighted choice:** Order-independent linear-scan algorithm for drop tables, rarities, and loot systems.
* **Spatial randomization:** Dedicated methods for `Vector3`, `Vector2`, `CFrame`, and `UnitVector`.
* **UI & visuals:** Easy generation for `Color3`, `UDim2` (offset), and `UDim2Scaled`.
* **Fully typed:** Strict Luau types with generics, exported from a dedicated `Types` module.

---

## Installation

### Wally

Add the following to your `wally.toml`:

```toml
Random = "elentium/random@2.1.0"
```

### GitHub

Clone or download from [github.com/Elentium/Random](https://github.com/Elentium/Random).

### Roblox Studio

A pre-built insert model is available at `roblox-studio-insert/Random.rbxm`.

---

## Quick Start

```luau
local Random = require(path.to.Random)

local rng = Random.new(12345)

local roll = rng:Integer(1, 6)
local chance = rng:Float(0, 1, 2)
local item, key = rng:Choice({ sword = 10, shield = 5, potion = 1 })
local position = rng:Vector3({ min = -10, max = 10 }, { min = 0, max = 5 }, { min = -10, max = 10 })
```

Always call methods with `:` syntax (`rng:Integer(...)`, not `rng.Integer(...)`).

---

## API

### `Random.new(seed: number?) -> RandomObject`

Creates a random object. If `seed` is omitted, Roblox generates one internally.

### Primitives

| Method | Description |
|--------|-------------|
| `:Integer(min, max, blacklist?)` | Random integer in `[min, max]`, optionally excluding blacklisted values |
| `:Float(min, max, precision?)` | Random float in `[min, max]`, optionally rounded to `precision` decimal places |

### Choice

| Method | Description |
|--------|-------------|
| `:Choice(container, blacklist?)` | Picks a random key from a map or array; returns `(value, key)` |
| `:BlazeChoice(container)` | Fast array-only choice; returns `(value, index)` |
| `:ChooseMultiple(container, amount, blacklist?, allowDuplicates?)` | Picks multiple entries; returns a map of chosen key-value pairs |
| `:WeightedChoice(container, totalWeight)` | Weighted pick from `{ { weight, item }, ... }`; returns `(item, weight)` |

### Roblox Types

| Method | Description |
|--------|-------------|
| `:Vector3(x, y, z, precision?)` | Random `Vector3` from axis ranges |
| `:Vector2(x, y, precision?)` | Random `Vector2` from axis ranges |
| `:UnitVector()` | Random unit direction as `Vector3` |
| `:Color3()` | Random `Color3` with RGB in `[0, 1]` |
| `:UDim2(x, y)` | Random offset `UDim2` from integer ranges |
| `:UDim2Scaled(x, y, precision?)` | Random scale `UDim2` from float ranges |
| `:CFrame(position, allowedAxes?, precision?)` | Random position and optional rotation |

`Range` is `{ min: number, max: number }`. For `:CFrame`, `position` is `{ x: Range, y: Range, z: Range }`.

### Object lifecycle

| Method | Description |
|--------|-------------|
| `:Clone()` | Clones the object and its internal `Random` instance |
| `:Destroy()` | Clears the object and removes its metatable |

---

## Warnings

* Avoid heavy blacklists on `:Integer` when more than ~90% of the range is excluded — performance degrades significantly. `:Choice` and `:ChooseMultiple` are not affected the same way.
* Always use `:` method syntax on `RandomObject` instances.
* `min` must not be greater than `max`.

---

## Benchmarks

A benchmark harness lives in `bench/` and is mapped in `default.project.json` as `Benchmark`. Run it from Studio to compare method performance on your target environment.

---

## Changelog

### 2.1.0

* Improved code organization with a separate `Types` module
* Improved Luau types (generics, `{ [K]: V }` table syntax)
* Performance improvements (including reservoir sampling for `:Choice`)
* `Vector3` and `UnitVector` now return `Vector3` via `Vector3.new`

### 2.0.6

* Fixed typos and small inconsistencies

### 2.0.5

* Added `RandomObject:WeightedChoice`
* Published Wally package

### 2.0.0

* Major performance improvements
* Cleaner API and documentation

---

## License

MIT — see [LICENSE](LICENSE).
