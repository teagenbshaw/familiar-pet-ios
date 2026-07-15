import SwiftUI
struct SettingsView:View{@State private var reducedMotion=false;@State private var sounds=false;var body:some View{Form{Section("Experience"){Toggle("Reduced motion",isOn:$reducedMotion);Toggle("Sounds",isOn:$sounds)};Section("Data"){Button("Export save data"){};Button("Reset companion",role:.destructive){}}}.navigationTitle("Settings")}}
