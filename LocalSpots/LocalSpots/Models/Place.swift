import Foundation
import SwiftData

@Model
final class Place: Identifiable {
    var id: UUID
    var name: String
    var category: PlaceCategory
    var subcategory: String
    var status: PlaceStatus
    var lastVisitedDate: Date?
    var latitude: Double
    var longitude: Double
    var address: String
    var phoneNumber: String?
    var priceLevel: Int?
    var notes: String?

    init(
        id: UUID = UUID(),
        name: String,
        category: PlaceCategory,
        subcategory: String,
        status: PlaceStatus = .notSeen,
        lastVisitedDate: Date? = nil,
        latitude: Double,
        longitude: Double,
        address: String,
        phoneNumber: String? = nil,
        priceLevel: Int? = nil,
        notes: String? = nil
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.subcategory = subcategory
        self.status = status
        self.lastVisitedDate = lastVisitedDate
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.phoneNumber = phoneNumber
        self.priceLevel = priceLevel
        self.notes = notes
    }

    func markAsVisited() {
        self.status = .visited
        self.lastVisitedDate = Date()
    }

    func markAsInterested() {
        self.status = .interested
    }

    func markAsNotInterested() {
        self.status = .notInterested
    }
}

enum PlaceStatus: String, Codable, Hashable, Sendable {
    case notSeen = "not_seen"
    case interested = "interested"
    case notInterested = "not_interested"
    case visited = "visited"
}

enum PlaceCategory: String, Codable, Hashable, Sendable {
    case restaurant = "restaurant"
    case activity = "activity"

    var displayName: String {
        switch self {
        case .restaurant:
            return "Places to Eat"
        case .activity:
            return "Things to Do"
        }
    }
}
