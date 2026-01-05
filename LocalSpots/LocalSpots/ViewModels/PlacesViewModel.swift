import Foundation
import SwiftData
import SwiftUI

@Observable
class PlacesViewModel {
    var modelContext: ModelContext?

    init() {}

    func initializeData() {
        guard let context = modelContext else {
            print("❌ No model context available")
            return
        }

        let descriptor = FetchDescriptor<Place>()
        let existingPlaces = (try? context.fetch(descriptor)) ?? []

        print("📊 Existing places count: \(existingPlaces.count)")

        // TEMPORARY: Force delete all existing places to start fresh
        if !existingPlaces.isEmpty {
            print("🗑️ Deleting all existing places to reset database...")
            for place in existingPlaces {
                context.delete(place)
            }
            try? context.save()
        }

        // Now insert fresh data
        print("✅ Inserting \(SamplePlaces.all.count) sample places")
        for samplePlace in SamplePlaces.all {
            print("   Inserting: \(samplePlace.name) with status: \(samplePlace.status)")
            context.insert(samplePlace)
        }
        do {
            try context.save()
            print("✅ Successfully saved sample data")

            // Verify the data was saved correctly
            let verifyDescriptor = FetchDescriptor<Place>()
            let allPlaces = (try? context.fetch(verifyDescriptor)) ?? []
            print("📊 Verification: Total places in DB: \(allPlaces.count)")
            if let firstPlace = allPlaces.first {
                print("   First place: \(firstPlace.name), status: \(firstPlace.status)")
            }
        } catch {
            print("❌ Error saving: \(error)")
        }
    }

    func getUnseenPlaces() -> [Place] {
        guard let context = modelContext else {
            print("❌ getUnseenPlaces: No model context")
            return []
        }

        // First try to get ALL places to debug
        let allDescriptor = FetchDescriptor<Place>()
        let allPlaces = (try? context.fetch(allDescriptor)) ?? []
        print("🔍 DEBUG: Total places in DB: \(allPlaces.count)")
        if let first = allPlaces.first {
            print("🔍 DEBUG: First place status: \(first.status), comparing to .notSeen: \(first.status == .notSeen)")
        }

        // Now manually filter to see what we get
        let manualFilter = allPlaces.filter { $0.status == .notSeen }
        print("🔍 DEBUG: Manual filter found: \(manualFilter.count) notSeen places")

        // Try the predicate
        let targetStatus = PlaceStatus.notSeen
        let descriptor = FetchDescriptor<Place>(
            predicate: #Predicate { $0.status == targetStatus }
        )

        let results = (try? context.fetch(descriptor)) ?? []
        print("📋 getUnseenPlaces returned: \(results.count) places")

        // Return manual filter for now
        return manualFilter
    }

    func getInterestedPlaces(category: PlaceCategory) -> [Place] {
        guard let context = modelContext else { return [] }

        // Use manual filter as workaround for predicate issues
        let allDescriptor = FetchDescriptor<Place>()
        let allPlaces = (try? context.fetch(allDescriptor)) ?? []

        return allPlaces
            .filter { $0.category == category && $0.status == .interested }
            .sorted { $0.name < $1.name }
    }

    func getVisitedPlaces(category: PlaceCategory) -> [Place] {
        guard let context = modelContext else { return [] }

        // Use manual filter as workaround for predicate issues
        let allDescriptor = FetchDescriptor<Place>()
        let allPlaces = (try? context.fetch(allDescriptor)) ?? []

        return allPlaces
            .filter { $0.category == category && $0.status == .visited }
            .sorted { ($0.lastVisitedDate ?? .distantPast) > ($1.lastVisitedDate ?? .distantPast) }
    }

    func swipeRight(on place: Place) {
        place.markAsInterested()
        try? modelContext?.save()
    }

    func swipeLeft(on place: Place) {
        place.markAsNotInterested()
        try? modelContext?.save()
    }

    func markAsVisited(_ place: Place) {
        place.markAsVisited()
        try? modelContext?.save()
    }

    func resetAllPlaces() {
        guard let context = modelContext else { return }

        let descriptor = FetchDescriptor<Place>()
        let allPlaces = (try? context.fetch(descriptor)) ?? []

        for place in allPlaces {
            place.status = .notSeen
            place.lastVisitedDate = nil
        }

        try? context.save()
    }
}
