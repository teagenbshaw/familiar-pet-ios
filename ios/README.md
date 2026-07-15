# Native iOS target

`Familiar/` contains the SwiftUI feature and domain source for an iOS 17+ app. The checked-in `project.yml` defines the app and WidgetKit extension targets. On a Mac with Xcode and XcodeGen installed, run `cd ios && xcodegen generate`, then open `Familiar.xcodeproj`.

The root owns one `@Observable` `FamiliarStore`. `TabView` and `NavigationStack` provide Home, Journey, Style, and Settings. `FamiliarStyle` is deliberately semantic: each style supplies world identity, dialogue voice, palette and art/cosmetic keys rather than acting as a simple color theme.

Both targets use the App Group `group.app.familiar.shared`; create the same App Group capability in your Apple Developer account before device signing. The widget works with the base Ember image now; final production art can add style/pose variants without changing the timeline or intent model.

After generation, use the Build iOS Apps plugin to select the `Familiar` scheme and a booted simulator, then build and run. The widget is added from the Simulator Home Screen after the containing app has launched once.

Native compilation must be performed on macOS with the current Xcode SDK. WidgetKit and Live Activity targets should be added only after the core app target is compiling and the shared save schema is mirrored in Codable fixtures.
