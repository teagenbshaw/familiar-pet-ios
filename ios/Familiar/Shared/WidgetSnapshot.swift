import Foundation

struct WidgetSnapshot: Codable, Equatable {
    var petName: String
    var level: Int
    var mood: String
    var bond: Double
    var energy: Double
    var style: FamiliarStyle
    var pose: PetPose
    var focusEndDate: Date?
    var focusMinutesToday: Int
    var lastInteraction: Date

    static let preview = WidgetSnapshot(
        petName: "Ember", level: 4, mood: "Calm", bond: 0.68,
        energy: 0.72, style: .fantasy, pose: .idle,
        focusEndDate: nil, focusMinutesToday: 42, lastInteraction: .now
    )
}

enum PetPose: String, Codable, CaseIterable {
    case idle, curious, sleeping, focused, happy
}

enum FamiliarAppGroup {
    static let identifier = "group.app.familiar.shared"
    static let snapshotKey = "widgetSnapshot.v1"
}

struct SharedPetStore {
    private let defaults = UserDefaults(suiteName: FamiliarAppGroup.identifier)!

    func load() -> WidgetSnapshot {
        guard let data = defaults.data(forKey: FamiliarAppGroup.snapshotKey),
              let snapshot = try? JSONDecoder().decode(WidgetSnapshot.self, from: data)
        else { return .preview }
        return snapshot
    }

    func save(_ snapshot: WidgetSnapshot) {
        guard let data = try? JSONEncoder().encode(snapshot) else { return }
        defaults.set(data, forKey: FamiliarAppGroup.snapshotKey)
    }
}
