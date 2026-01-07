import SwiftUI

struct SwipeCardView: View {
    let place: Place
    let onSwipeLeft: () -> Void
    let onSwipeRight: () -> Void

    @State private var offset = CGSize.zero
    @State private var color: Color = .gray

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(radius: 5)

            VStack(spacing: 0) {
                // Image at top
                PlaceImageView(
                    imageName: place.imageName,
                    width: 340,
                    height: 240,
                    cornerRadius: 0
                )
                .clipShape(UnevenRoundedRectangle(
                    topLeadingRadius: 20,
                    topTrailingRadius: 20
                ))

                // Content at bottom
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(place.name)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .lineLimit(2)

                        Text(place.subcategory)
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text(place.address)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }

                    Spacer()

                    HStack {
                        Label("Swipe left to skip", systemImage: "xmark")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Spacer()

                        Label("Swipe right to save", systemImage: "heart.fill")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(20)
                .frame(height: 240)
            }
        }
        .frame(width: 340, height: 480)
        .offset(x: offset.width, y: offset.height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 20)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    withAnimation {
                        changeColor(width: offset.width)
                    }
                }
                .onEnded { _ in
                    withAnimation {
                        swipeCard(width: offset.width)
                    }
                }
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(color, lineWidth: 4)
                .frame(width: 340, height: 480)
        )
    }

    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-130):
            color = .red
        case 130...500:
            color = .green
        default:
            color = .gray
        }
    }

    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-130):
            offset = CGSize(width: -500, height: 0)
            onSwipeLeft()
        case 130...500:
            offset = CGSize(width: 500, height: 0)
            onSwipeRight()
        default:
            offset = .zero
        }
    }
}

struct SwipeView: View {
    @Environment(PlacesViewModel.self) private var viewModel
    @State private var unseenPlaces: [Place] = []

    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.systemGroupedBackground)
                    .ignoresSafeArea()

                VStack {
                    if unseenPlaces.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.green)

                            Text("All done!")
                                .font(.title)
                                .fontWeight(.bold)

                            Text("You've reviewed all places")
                                .font(.body)
                                .foregroundColor(.secondary)

                            Button("Reset All Places") {
                                viewModel.resetAllPlaces()
                                loadUnseenPlaces()
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.top)
                        }
                        .padding()
                    } else {
                        ZStack {
                            ForEach(Array(unseenPlaces.enumerated().prefix(3).reversed()), id: \.element.id) { index, place in
                                SwipeCardView(
                                    place: place,
                                    onSwipeLeft: {
                                        handleSwipeLeft(place)
                                    },
                                    onSwipeRight: {
                                        handleSwipeRight(place)
                                    }
                                )
                                .zIndex(index == 0 ? 1 : 0)
                                .offset(y: CGFloat(index * -10))
                                .scaleEffect(1 - CGFloat(index) * 0.05)
                            }
                        }
                        .padding(.bottom, 40)
                    }
                }
            }
            .navigationTitle("Discover")
            .onAppear {
                loadUnseenPlaces()
            }
        }
    }

    private func loadUnseenPlaces() {
        print("🔄 SwipeView: Loading unseen places...")
        unseenPlaces = viewModel.getUnseenPlaces()
        print("🔄 SwipeView: Loaded \(unseenPlaces.count) unseen places")
    }

    private func handleSwipeLeft(_ place: Place) {
        viewModel.swipeLeft(on: place)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                unseenPlaces.removeAll { $0.id == place.id }
            }
        }
    }

    private func handleSwipeRight(_ place: Place) {
        viewModel.swipeRight(on: place)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation {
                unseenPlaces.removeAll { $0.id == place.id }
            }
        }
    }
}
