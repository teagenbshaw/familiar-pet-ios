import SwiftUI
@main struct FamiliarApp:App{@State private var store=FamiliarStore();var body:some Scene{WindowGroup{AppView(store:store)}}}
