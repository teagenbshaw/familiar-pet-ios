# Familiar on iOS and WidgetKit

The iOS follow-on should be a small SwiftUI companion app plus WidgetKit extension, not a port of the permanent desktop overlay.

## Surfaces

- Home-screen widgets: pet pose, name, mood, daily focus minutes, and one App Intent action where the OS supports it.
- Lock-screen widget: a compact pose and focus progress.
- Live Activity: current focus interval, pause/end deep links, and a completion pose.
- Companion app: profile, settings, cosmetics, history, import/export, and focus controls.

Widgets do not run continuously and cannot provide a permanently animated creature. Use a small set of static timeline poses, system-controlled timeline refreshes, and a Live Activity for active sessions. Refresh timing is budgeted by iOS and must never be presented as real-time background execution. Interactive widget actions are App Intents with constrained execution, not an always-running game loop.

## Shared specification

Treat `src/domain/types.ts`, the transition table, progression formulas, schema fixtures, dialogue categories, and JSON pet configuration as the platform-neutral specification. Reimplement these small deterministic functions in Swift and run identical JSON fixtures in Vitest and XCTest. Avoid embedding React or JavaScript in the widget extension.

Use Codable value types, an enum for `PetState`, a pure transition reducer, and `Duration`/`Date` based timer math. Store shared data in an App Group container with atomic file replacement. The app owns migrations and writes a compact widget snapshot; the widget reads without mutating progression. Never synchronize a once-per-second countdown through App Group storage.

## Update model

1. App writes canonical save and a small `WidgetSnapshot`.
2. App calls `WidgetCenter.reloadTimelines(ofKind:)` after meaningful changes.
3. Widget timelines choose static poses for now/morning/evening.
4. Live Activity uses an end date so the system renders remaining focus time without background ticks.
5. Optional cloud sync, if ever added, belongs behind a repository interface and is not required for local use.

Recommended targets: current stable iOS, SwiftUI, WidgetKit, ActivityKit, App Intents, and an App Group shared container. Validate exact availability when iOS implementation begins.
