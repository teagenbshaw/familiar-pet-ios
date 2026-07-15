# Familiar — iOS companion

Familiar is now an iOS-first, local virtual-pet companion. Its style system can transform the entire experience for different audiences—Fantasy, Retro, Dark Fantasy, and Anime—covering pet art, world atmosphere, UI tokens, ornament, particles, dialogue voice, and cosmetics.

The native SwiftUI source is under `ios/Familiar`. The React app is a fast, phone-sized interaction prototype for reviewing the experience on non-macOS development machines. The old desktop direction is no longer the product target.

## Run locally

Requirements: Node.js 20+, Rust stable, and the [Tauri 2 prerequisites](https://v2.tauri.app/start/prerequisites/) for your OS.

```powershell
npm install
npm run dev
npm test
npm run build
npm run tauri dev
npm run tauri build
```

`npm run dev` previews the iPhone experience and interactive world selector in a browser. Open the native source in a generated Xcode iOS project on macOS and add `public/assets/ember.png` to the asset catalog as `Ember`.

## Architecture

- `src/domain`: framework-neutral rules for focus, progression, behavior, personality, dialogue, and shared types.
- `src/store`: app orchestration; React observes this layer, while domain functions stay testable and portable.
- `src/services`: versioned local persistence, backup, migration, import, and export behavior.
- `src/components`: settings and companion-window presentation.
- `src-tauri`: native windows, transparency, always-on-top behavior, tray menu, notifications, and startup integration.
- `src/data`: local pet definitions and categorized dialogue.
- `ios-planning`: honest SwiftUI and WidgetKit follow-on design.

Data is stored locally under the `familiar-save` key with a previous-save backup. A production Tauri release can swap the browser adapter for `tauri-plugin-store` without changing domain types.

See [docs/STATE_MACHINE.md](docs/STATE_MACHINE.md) and [docs/DATA_SCHEMA.md](docs/DATA_SCHEMA.md).

## Testing

`npm test` covers the timer lifecycle, XP/levels, legal state transitions, personality choices, defaults, save migration, dialogue filtering, and daily check-in behavior. Native tray/window behavior should also be smoke-tested with `npm run tauri dev` on each target OS and multiple-monitor arrangement.

## Current scope

The MVP includes the complete domain foundation and working desktop vertical slice. Fullscreen detection is represented by a setting and intentionally remains platform-specific follow-up work; Tauri does not expose a single reliable cross-platform fullscreen-app signal. Startup, notifications, click-through, and native store plugins are installed and permissioned for the next native integration pass.
