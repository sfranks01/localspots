# LocalSpots - Code Guide

A guide to understanding what each file does in your iOS app.

## Project Structure Overview

```
LocalSpots/
├── Models/              # Data structures
├── Views/               # User interface components
├── ViewModels/          # Business logic
├── Data/                # Sample data
└── LocalSpotsApp.swift # App entry point
```

## File Breakdown

### LocalSpotsApp.swift
**Purpose**: The main entry point of your iOS app

**Key Concepts**:
- `@main` attribute marks this as the app's starting point
- Creates the SwiftData `ModelContainer` for the Place model
- Initializes the `PlacesViewModel` with the database context
- Calls `initializeData()` to populate sample places on first launch
- Sets up the root view (`ContentView`)

**What happens here**:
1. App launches
2. SwiftData database is initialized
3. If database is empty, 50 sample places are added
4. Main UI is displayed

---

## Models/

### Place.swift
**Purpose**: Defines the core data model for a place

**Key Components**:

1. **Place class** (`@Model` macro)
   - Main data structure representing a restaurant or activity
   - Stored in SwiftData (persisted to disk)
   - Properties:
     - `id`: Unique identifier
     - `name`: Place name (e.g., "Tartine Bakery")
     - `category`: Restaurant or Activity
     - `subcategory`: More specific type (e.g., "Italian", "Museum")
     - `status`: Whether user has seen/swiped/visited it
     - `lastVisitedDate`: When user marked it as visited
     - `latitude/longitude`: Coordinates for map display
     - `address`, `phoneNumber`: Contact info
     - `priceLevel`, `notes`: Optional metadata
   - Methods:
     - `markAsVisited()`: Sets status to visited, records date
     - `markAsInterested()`: User swiped right
     - `markAsNotInterested()`: User swiped left

2. **PlaceStatus enum**
   - `notSeen`: User hasn't seen this place yet (shows in swipe deck)
   - `interested`: User swiped right (shows in Eat/Explore lists)
   - `notInterested`: User swiped left (hidden)
   - `visited`: User marked as visited (shows in "Visited" section)

3. **PlaceCategory enum**
   - `restaurant`: For places to eat
   - `activity`: For things to do
   - `displayName` property: Returns "Places to Eat" or "Things to Do"

**Why it's designed this way**:
- Status workflow supports the swipe-to-save-to-visit journey
- Extensible for future features (priceLevel, notes for Phase 2)
- Location data ready for map features (Phase 2+)
- Clean separation between "what it is" (category) and "what I think" (status)

---

## ViewModels/

### PlacesViewModel.swift
**Purpose**: Manages data operations and business logic

**Key Concepts**:
- `@Observable` macro makes this class work with SwiftUI's reactive system
- Acts as the intermediary between Views and SwiftData
- Handles all database queries and updates

**Methods Explained**:

1. `initializeData()`
   - Called once when app launches
   - Checks if database is empty
   - If empty, inserts all 50 sample places
   - You only see sample data on first launch

2. `getUnseenPlaces()` → [Place]
   - Queries all places with status = `.notSeen`
   - Used by SwipeView to populate the card deck
   - As user swipes, places are removed from this list

3. `getInterestedPlaces(category:)` → [Place]
   - Queries places where:
     - `status == .interested`
     - Matches the specified category (restaurant or activity)
   - Sorted alphabetically by name
   - Used by the "Saved" section in Eat/Explore tabs

4. `getVisitedPlaces(category:)` → [Place]
   - Queries places where:
     - `status == .visited`
     - Matches the specified category
   - Sorted by most recently visited
   - Used by the "Visited" section in Eat/Explore tabs

5. `swipeRight(on:)` / `swipeLeft(on:)`
   - Updates place status
   - Saves changes to database
   - Called by SwipeView when user swipes

6. `markAsVisited(_:)`
   - Updates place to visited status
   - Sets lastVisitedDate to now
   - Called from PlaceDetailView

7. `resetAllPlaces()`
   - Debugging/demo feature
   - Resets all places to unseen
   - Clears visit dates
   - Useful for testing the swipe flow again

**Why use a ViewModel?**
- Keeps Views simple and focused on UI
- Centralizes data logic in one place
- Makes testing easier
- Prevents duplicate query code across views

---

## Data/

### SamplePlaces.swift
**Purpose**: Provides 50 hardcoded SF places for Phase 1

**Structure**:
- Static array of `Place` objects
- 25 restaurants (diverse cuisines)
- 25 activities (museums, parks, landmarks)
- Real SF addresses and coordinates
- Mix of famous spots and hidden gems

**Phase 1 → 3 Evolution**:
- **Phase 1** (now): Hardcoded array, loaded once at app startup
- **Phase 2**: Add more metadata, keep hardcoded
- **Phase 3**: Replace with Yelp/Google Places API calls

**How to add more places**:
```swift
Place(
    name: "New Restaurant Name",
    category: .restaurant,
    subcategory: "Cuisine Type",
    latitude: 37.7749,  // Get from Google Maps
    longitude: -122.4194,
    address: "123 Main St, San Francisco, CA 94102"
)
```

---

## Views/

### ContentView.swift
**Purpose**: The root view with bottom tab navigation

**Structure**:
- `TabView` with 3 tabs:
  1. **Discover**: SwipeView (card swiping interface)
  2. **Eat**: InterestedPlacesView for restaurants
  3. **Explore**: InterestedPlacesView for activities

**Key Concepts**:
- `@Environment(PlacesViewModel.self)` injects the view model
- Each tab is independent but shares the same data
- Tab bar icons: "rectangle.stack", "fork.knife", "map"

---

### SwipeCardView.swift
**Purpose**: Tinder-style swipe interface

**Two Components**:

1. **SwipeCardView**
   - Individual card displaying one place
   - Drag gesture handling
   - Visual feedback (card rotates/moves as you drag)
   - Border changes color:
     - Green when dragging right (will mark interested)
     - Red when dragging left (will mark not interested)
     - Black when neutral
   - Callbacks: `onSwipeLeft`, `onSwipeRight`

2. **SwipeView**
   - Container that manages the deck of cards
   - Loads unseen places from ViewModel
   - Shows up to 3 cards stacked (only top one is interactive)
   - When you swipe:
     1. Triggers the callback (swipeLeft/swipeRight)
     2. Updates database via ViewModel
     3. Waits 0.3 seconds for animation
     4. Removes card from deck
   - "All done" state when no unseen places remain
   - "Reset" button to start over

**Key SwiftUI Concepts**:
- `DragGesture`: Detects swipe motion
- `offset`: Moves card based on finger position
- `rotationEffect`: Tilts card for realism
- `zIndex`: Controls which card is on top
- `scaleEffect`: Makes background cards slightly smaller

---

### InterestedPlacesView.swift
**Purpose**: Shows saved and visited places for a category

**Structure**:
- Two sections:
  1. **Saved**: Places you swiped right on (status = interested)
  2. **Visited**: Places you marked as visited
- Tapping a row navigates to PlaceDetailView
- Pull-to-refresh updates the lists
- Empty state when no places saved yet

**PlaceRowView**:
- Reusable component for displaying a place in a list
- Shows: name, subcategory, visit date (if visited)
- Green checkmark badge for visited places

**Key SwiftUI Concepts**:
- `NavigationStack`: Enables navigation to detail view
- `NavigationLink`: Tappable row that navigates
- `Section`: Groups list items with headers
- `ContentUnavailableView`: Modern empty state UI
- `.refreshable`: Pull-to-refresh gesture

---

### PlaceDetailView.swift
**Purpose**: Full details for a single place + "Mark as Visited" action

**Structure**:
- Map showing place location (using MapKit)
- Place name (large title)
- Subcategory and visited badge
- Address and phone number
- Last visited date (if applicable)
- Notes (if any)
- "Mark as Visited" button (if not already visited)

**User Flow**:
1. User taps button
2. Confirmation alert appears
3. User confirms
4. Place is updated to visited status with today's date
5. View dismisses back to list

**Key Concepts**:
- `Map` with `Marker`: SwiftUI's MapKit integration (iOS 17+)
- `@Environment(\.dismiss)`: Dismisses current view
- `.alert`: Confirmation dialog
- `CLLocationCoordinate2D`: Geographic coordinate type
- `MKCoordinateRegion`: Defines visible map area

**Map Calculation**:
- Uses place's latitude/longitude
- `latitudeDelta/longitudeDelta: 0.01` = ~1km zoom level
- Shows enough context to see surrounding streets

---

## Data Flow Example

Let's trace what happens when you swipe right on "Tartine Bakery":

1. **SwipeCardView.swift**: User drags card to the right
   - `DragGesture.onEnded` detects the swipe
   - Calls `onSwipeRight()` callback

2. **SwipeView.swift**: Handles the swipe
   - `handleSwipeRight()` is called
   - Calls `viewModel.swipeRight(on: place)`

3. **PlacesViewModel.swift**: Updates data
   - `swipeRight()` calls `place.markAsInterested()`
   - Saves changes: `modelContext?.save()`

4. **Place.swift**: Data model updates
   - `markAsInterested()` sets `status = .interested`

5. **SwiftData**: Persists to disk
   - Change is automatically saved to database

6. **SwipeView.swift**: Updates UI
   - Removes place from `unseenPlaces` array
   - Next card automatically appears

7. **InterestedPlacesView.swift**: Will now show it
   - Next time user opens "Eat" tab
   - `getInterestedPlaces(category: .restaurant)` will include Tartine

---

## iOS Architecture Pattern: MVVM

This app uses **Model-View-ViewModel**:

### Model (Place.swift)
- Pure data structures
- Business rules (how to mark as visited)
- Persisted with SwiftData

### View (all in Views/)
- SwiftUI components
- Handle user interaction
- Display data
- NO direct database access

### ViewModel (PlacesViewModel.swift)
- Queries database
- Prepares data for views
- Handles user actions
- Bridge between Model and View

**Benefits**:
- Views stay simple
- Easy to test business logic
- Reusable components
- Clean separation of concerns

---

## Key SwiftUI & SwiftData Patterns

### @Observable (new in iOS 17)
Replaces `@ObservableObject` and `@Published`:
```swift
@Observable class PlacesViewModel {
    var places: [Place] = []  // Automatically tracked!
}
```
Views automatically update when properties change.

### @Model (SwiftData)
Turns a Swift class into a database-backed model:
```swift
@Model
final class Place {
    var name: String
    // SwiftData handles storage automatically
}
```

### @Environment
Dependency injection in SwiftUI:
```swift
@Environment(PlacesViewModel.self) private var viewModel
```
Makes ViewModel available to all child views.

### #Predicate (SwiftData queries)
Type-safe database queries:
```swift
#Predicate { $0.status == .interested }
```
Compiler checks validity, autocomplete works!

---

## Extending the App

### Adding a new property to Place
1. Add property to `Place.swift`
2. Delete app from simulator (to reset database)
3. Run again

### Adding a new view
1. Create new SwiftUI View file
2. Add to project
3. Reference from navigation or tabs

### Changing swipe behavior
Edit `SwipeCardView.swift` → `swipeCard(width:)` method

### Customizing UI
All styling is in View files using SwiftUI modifiers:
- `.font()`, `.foregroundColor()`, `.padding()`
- `.background()`, `.cornerRadius()`, `.shadow()`

---

## Common Beginner Questions

**Q: Why do some views need `@Environment` and others don't?**
A: Only views that need to read/update data need the ViewModel. Pure UI components (like cards) just receive data as parameters.

**Q: What's the difference between `@State` and `@Observable`?**
A: `@State` is for local view data. `@Observable` is for shared data across views.

**Q: How does SwiftUI know when to update?**
A: When `@Observable` or `@State` properties change, SwiftUI automatically re-renders affected views.

**Q: Can I change the sample data?**
A: Yes! Edit `SamplePlaces.swift`. Delete app from simulator to reload data.

**Q: Why use enums for Status and Category?**
A: Type safety! Compiler prevents typos and guarantees valid values.

---

## Next Steps for Learning

1. **Experiment**: Change colors, fonts, layout in the Views
2. **Add features**: Try adding a search bar to InterestedPlacesView
3. **Customize data**: Edit sample places, add your favorite spots
4. **Read SwiftUI docs**: Apple's official tutorials are excellent
5. **Explore SwiftData**: Learn about relationships, indexes, migrations

For Phase 2, we can:
- Add filtering by distance
- Implement cost level indicators
- Add photos to places
- Create custom map view
- Add sharing features

Happy learning!
