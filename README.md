# Random V2.0.6

A high-performance, feature-complete randomization utility for **Luau**. This module is a heavily optimized rework of the original Random library, designed specifically for Roblox developers who require precision, speed, and advanced filtering like blacklisting and weighted distribution.

---

## Key Features

* **⚡ Native Performance:** Uses `--!native` and `--!optimize 2` to leverage AOT (Ahead-Of-Time) compilation into machine code on supported environments.
* **Smart Blacklisting:** Built-in support for excluding specific values from your random results without manual loops.
* **Weighted Choice:** statistically accurate linear-scan algorithm for drop tables, rarities, and loot systems.
* **Spatial Randomization:** Dedicated methods for `Vector3`, `Vector2`, `CFrame`, and `UnitVector`.
* **UI & Visuals:** Easy generation for `Color3`, `UDim2` (Offset), and `UDim2Scaled`.
* **Developer Friendly:** Fully typed with Luau strict mode and compatible with the **Rojo + Wally + VS Code** workflow.

---

## 📦 Installation

### Wally
Add the following to your `wally.toml`:
```toml
Random = "elentium/random@2.0.62"
```

### Github
"https://https://github.com/Elentium/Random"