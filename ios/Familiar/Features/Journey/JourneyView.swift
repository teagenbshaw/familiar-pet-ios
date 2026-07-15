import SwiftUI
struct JourneyView:View{let store:FamiliarStore;var body:some View{List{Section("Today"){Label("42 focus minutes",systemImage:"timer");Label("2 completed sessions",systemImage:"checkmark.seal")};Section("Your bond"){ProgressView(value:store.bond)}}.navigationTitle("Journey")}}
