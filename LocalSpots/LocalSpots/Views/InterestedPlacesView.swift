import SwiftUI

struct InterestedPlacesView: View {
    @Environment(PlacesViewModel.self) private var viewModel
    let category: PlaceCategory

    @State private var interestedPlaces: [Place] = []
    @State private var visitedPlaces: [Place] = []

    var body: some View {
        NavigationStack {
            List {
                if !interestedPlaces.isEmpty {
                    Section("Saved") {
                        ForEach(interestedPlaces) { place in
                            NavigationLink(destination: PlaceDetailView(place: place)) {
                                PlaceRowView(place: place)
                            }
                        }
                    }
                }

                if !visitedPlaces.isEmpty {
                    Section("Visited") {
                        ForEach(visitedPlaces) { place in
                            NavigationLink(destination: PlaceDetailView(place: place)) {
                                PlaceRowView(place: place)
                            }
                        }
                    }
                }

                if interestedPlaces.isEmpty && visitedPlaces.isEmpty {
                    ContentUnavailableView(
                        "No Places Yet",
                        systemImage: category == .restaurant ? "fork.knife" : "map",
                        description: Text("Swipe right on places you're interested in")
                    )
                }
            }
            .navigationTitle(category.displayName)
            .onAppear {
                loadPlaces()
            }
            .refreshable {
                loadPlaces()
            }
        }
    }

    private func loadPlaces() {
        interestedPlaces = viewModel.getInterestedPlaces(category: category)
        visitedPlaces = viewModel.getVisitedPlaces(category: category)
    }
}

struct PlaceRowView: View {
    let place: Place

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(place.name)
                .font(.headline)

            Text(place.subcategory)
                .font(.subheadline)
                .foregroundColor(.secondary)

            if let lastVisited = place.lastVisitedDate {
                HStack(spacing: 4) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.caption)
                        .foregroundColor(.green)

                    Text("Last visited: \(lastVisited.formatted(date: .abbreviated, time: .omitted))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.top, 2)
            }
        }
        .padding(.vertical, 4)
    }
}
