import SwiftUI
import MapKit

struct PlaceDetailView: View {
    @Environment(PlacesViewModel.self) private var viewModel
    @Environment(\.dismiss) private var dismiss

    let place: Place
    @State private var showingVisitConfirmation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Map(initialPosition: .region(region)) {
                    Marker(place.name, coordinate: coordinate)
                }
                .frame(height: 250)
                .cornerRadius(12)

                VStack(alignment: .leading, spacing: 16) {
                    Text(place.name)
                        .font(.title)
                        .fontWeight(.bold)

                    HStack {
                        Label(place.subcategory, systemImage: categoryIcon)
                            .font(.headline)
                            .foregroundColor(.secondary)

                        Spacer()

                        if place.status == .visited, let lastVisited = place.lastVisitedDate {
                            HStack(spacing: 4) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Text("Visited")
                                    .fontWeight(.medium)
                                    .foregroundColor(.green)
                            }
                        }
                    }

                    Divider()

                    VStack(alignment: .leading, spacing: 12) {
                        Label(place.address, systemImage: "mappin.and.ellipse")
                            .font(.body)

                        if let phone = place.phoneNumber {
                            Label(phone, systemImage: "phone.fill")
                                .font(.body)
                        }
                    }

                    if let lastVisited = place.lastVisitedDate {
                        Divider()

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Last Visited")
                                .font(.headline)

                            Text(lastVisited.formatted(date: .long, time: .omitted))
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }

                    if let notes = place.notes, !notes.isEmpty {
                        Divider()

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Notes")
                                .font(.headline)

                            Text(notes)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }

                    Spacer(minLength: 20)

                    if place.status != .visited {
                        Button(action: {
                            showingVisitConfirmation = true
                        }) {
                            Label("Mark as Visited", systemImage: "checkmark.circle.fill")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                                .fontWeight(.semibold)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .alert("Mark as Visited?", isPresented: $showingVisitConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Mark Visited") {
                viewModel.markAsVisited(place)
                dismiss()
            }
        } message: {
            Text("This will mark \(place.name) as visited with today's date.")
        }
    }

    private var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)
    }

    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }

    private var categoryIcon: String {
        switch place.category {
        case .restaurant:
            return "fork.knife"
        case .activity:
            return "figure.walk"
        }
    }
}
