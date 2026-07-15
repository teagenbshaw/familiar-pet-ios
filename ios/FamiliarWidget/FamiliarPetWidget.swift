import SwiftUI
import WidgetKit

struct FamiliarEntry: TimelineEntry {
    let date: Date
    let snapshot: WidgetSnapshot
}

struct FamiliarTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> FamiliarEntry { FamiliarEntry(date: .now, snapshot: .preview) }
    func getSnapshot(in context: Context, completion: @escaping (FamiliarEntry) -> Void) { completion(placeholder(in: context)) }
    func getTimeline(in context: Context, completion: @escaping (Timeline<FamiliarEntry>) -> Void) {
        let snapshot = SharedPetStore().load()
        let now = Date()
        let poses: [PetPose] = snapshot.focusEndDate.map { $0 > now ? [.focused] : [.happy, .idle] } ?? [.idle, .curious, .idle]
        let entries = poses.enumerated().map { index, pose in
            var value = snapshot
            value.pose = pose
            return FamiliarEntry(date: now.addingTimeInterval(Double(index) * 20 * 60), snapshot: value)
        }
        completion(Timeline(entries: entries, policy: .after(now.addingTimeInterval(60 * 60))))
    }
}

struct FamiliarWidgetView: View {
    @Environment(\.widgetFamily) private var family
    let entry: FamiliarEntry

    var body: some View {
        ZStack {
            background
            VStack(alignment: .leading, spacing: 5) {
                HStack { Text(entry.snapshot.petName).font(.headline); Spacer(); Text("Lv. \(entry.snapshot.level)").font(.caption) }
                Spacer()
                HStack(alignment: .bottom) {
                    Image("Ember").resizable().scaledToFit().accessibilityLabel("\(entry.snapshot.petName) is \(entry.snapshot.mood.lowercased())")
                    if family != .systemSmall { status }
                }
                Spacer()
                controls
            }.padding(14)
        }.containerBackground(for: .widget) { background }
    }

    private var background: some View {
        Rectangle().fill(entry.snapshot.style.background.gradient)
    }
    private var status: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(entry.snapshot.mood).font(.subheadline.bold())
            Label("\(entry.snapshot.focusMinutesToday) min today", systemImage: "timer").font(.caption)
            ProgressView(value: entry.snapshot.bond).tint(entry.snapshot.style.accent)
        }.frame(maxWidth: 110)
    }
    private var controls: some View {
        HStack {
            Button(intent: PetActionIntent(action: .pet)) { Label("Pet", systemImage: "hand.tap") }
            Spacer()
            Button(intent: PetActionIntent(action: .startFocus)) { Label("Focus", systemImage: "sparkles") }
        }.font(.caption.bold()).tint(entry.snapshot.style.accent)
    }
}

struct FamiliarPetWidget: Widget {
    let kind = "FamiliarPetWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: FamiliarTimelineProvider()) { FamiliarWidgetView(entry: $0) }
            .configurationDisplayName("Your Familiar")
            .description("Keep your pet, mood, bond, and focus progress on your Home Screen.")
            .supportedFamilies([.systemSmall, .systemMedium])
    }
}
