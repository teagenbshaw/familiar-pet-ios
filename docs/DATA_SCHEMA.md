# Save schema

Schema version 2 stores four top-level records: `pet`, `settings`, `daily`, and `windowPosition`.

`pet` contains identity, type, level, experience, mood, bond, energy, hunger, traits, lifetime focus totals, adoption date, unlocks, and equipped cosmetics. `settings` covers companion rhythm, desktop behavior, focus, and accessibility. `daily` is keyed by a local ISO date. Coordinates are physical desktop pixels and should be clamped into the union of current monitor bounds during native restore.

All new fields require defaults. Migrations are pure functions and preserve unknown cosmetic keys for forward compatibility. A failed parse recovers to defaults; each meaningful write copies the preceding JSON to a backup first. Exported files are human-readable JSON.
