import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = PlacesViewModel()

    var body: some View {
        TabView {
            SwipeView()
                .tabItem {
                    Label("Discover", systemImage: "rectangle.stack")
                }

            InterestedPlacesView(category: .restaurant)
                .tabItem {
                    Label("Eat", systemImage: "fork.knife")
                }

            InterestedPlacesView(category: .activity)
                .tabItem {
                    Label("Explore", systemImage: "map")
                }
        }
        .environment(viewModel)
        .onAppear {
            print("🚀 ContentView appeared")
            viewModel.modelContext = modelContext
            print("🔗 ModelContext assigned to viewModel")
            viewModel.initializeData()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Place.self, inMemory: true)
        .environment(PlacesViewModel())
}
