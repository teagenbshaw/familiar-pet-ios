import AppIntents
import WidgetKit

enum WidgetPetAction: String, AppEnum {
    case pet, startFocus
    static var typeDisplayRepresentation = TypeDisplayRepresentation(name: "Pet action")
    static var caseDisplayRepresentations: [Self: DisplayRepresentation] = [
        .pet: "Pet your familiar",
        .startFocus: "Start a focus session"
    ]
}

struct PetActionIntent: AppIntent {
    static var title: LocalizedStringResource = "Interact with Familiar"
    static var description = IntentDescription("Pet your companion or begin focusing from a widget.")
    static var openAppWhenRun = false

    @Parameter(title: "Action") var action: WidgetPetAction

    init() {}
    init(action: WidgetPetAction) { self.action = action }

    func perform() async throws -> some IntentResult {
        let store = SharedPetStore()
        var snapshot = store.load()
        switch action {
        case .pet:
            snapshot.bond = min(1, snapshot.bond + 0.01)
            snapshot.mood = "Happy"
            snapshot.pose = .happy
            snapshot.lastInteraction = .now
        case .startFocus:
            snapshot.pose = .focused
            snapshot.focusEndDate = Date().addingTimeInterval(25 * 60)
        }
        store.save(snapshot)
        WidgetCenter.shared.reloadTimelines(ofKind: "FamiliarPetWidget")
        return .result()
    }
}

struct FamiliarShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(intent: PetActionIntent(action: .pet), phrases: ["Pet my familiar in \(.applicationName)"], shortTitle: "Pet Familiar", systemImageName: "hand.tap")
        AppShortcut(intent: PetActionIntent(action: .startFocus), phrases: ["Focus with \(.applicationName)"], shortTitle: "Focus Together", systemImageName: "timer")
    }
}
