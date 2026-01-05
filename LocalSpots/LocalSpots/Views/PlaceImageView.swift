import SwiftUI

struct PlaceImageView: View {
    let imageName: String?
    let width: CGFloat?
    let height: CGFloat
    let cornerRadius: CGFloat

    init(imageName: String?, width: CGFloat? = nil, height: CGFloat, cornerRadius: CGFloat = 0) {
        self.imageName = imageName
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        Group {
            if let imageName = imageName {
                if imageName.starts(with: "http") {
                    // Remote URL - use AsyncImage
                    AsyncImage(url: URL(string: imageName)) { phase in
                        switch phase {
                        case .empty:
                            loadingView
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            placeholderView
                        @unknown default:
                            placeholderView
                        }
                    }
                } else {
                    // Bundled asset - use Image
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            } else {
                placeholderView
            }
        }
        .frame(width: width, height: height)
        .clipped()
        .cornerRadius(cornerRadius)
    }

    private var loadingView: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .overlay(
                ProgressView()
            )
    }

    private var placeholderView: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .overlay(
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            )
    }
}
