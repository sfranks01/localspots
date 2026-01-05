import SwiftUI
import SwiftData

@main
struct LocalSpotsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Place.self)
    }
}
