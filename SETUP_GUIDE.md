# LocalSpots - Xcode Project Setup Guide

Welcome to your first iOS app! This guide will walk you through setting up the project in Xcode.

## Prerequisites

- macOS with Xcode 15.0+ installed (for SwiftUI and SwiftData support)
- iOS 17.0+ deployment target

## Step-by-Step Setup

### 1. Open Xcode

Launch Xcode from your Applications folder or Spotlight.

### 2. Create a New Project

1. Click **"Create New Project"** (or File > New > Project)
2. Select **iOS** at the top
3. Choose **App** template
4. Click **Next**

### 3. Configure Your Project

Fill in the following details:

- **Product Name**: `LocalSpots`
- **Team**: Select your Apple Developer account (or leave as "None" for simulator-only testing)
- **Organization Identifier**: Use reverse domain notation, e.g., `com.yourname`
- **Bundle Identifier**: Will auto-populate (e.g., `com.yourname.LocalSpots`)
- **Interface**: Select **SwiftUI**
- **Storage**: Select **SwiftData**
- **Language**: Swift
- **Include Tests**: Unchecked (optional, you can add later)

Click **Next**.

### 4. Save the Project

1. Navigate to: `/Users/spencerfranks/Documents/explorer-app/`
2. Click **Create**

This will create an Xcode project in a folder called "LocalSpots" alongside the files I've already created.

### 5. Replace Generated Files

Xcode will create some default files. We need to replace them with our custom code:

1. In the **Project Navigator** (left sidebar), you'll see a folder structure
2. **Delete** these auto-generated files (right-click > Delete > Move to Trash):
   - `ContentView.swift` (we have our own)
   - `LocalSpotsApp.swift` (we have our own)
   - Any `Item.swift` or sample model files

### 6. Add Your Files to the Project

Now we'll add all the files I created for you:

1. In Finder, navigate to `/Users/spencerfranks/Documents/explorer-app/LocalSpots/`
2. You should see these folders:
   - `Models/`
   - `Views/`
   - `ViewModels/`
   - `Data/`
   - `LocalSpotsApp.swift`

3. **Add the main app file**:
   - Drag `LocalSpotsApp.swift` into the Xcode project (into the main "LocalSpots" folder)
   - When prompted, make sure **"Copy items if needed"** is UNCHECKED (files are already in the right place)
   - Ensure **"LocalSpots" target** is checked
   - Click **Finish**

4. **Add the folder groups**:
   - Drag the `Models/` folder into the Xcode project
   - Drag the `Views/` folder into the Xcode project
   - Drag the `ViewModels/` folder into the Xcode project
   - Drag the `Data/` folder into the Xcode project
   - For each, ensure **"Copy items if needed"** is UNCHECKED
   - Ensure **"Create groups"** is selected (not "Create folder references")
   - Ensure **"LocalSpots" target** is checked

Your project structure should now look like:
```
LocalSpots/
├── Models/
│   └── Place.swift
├── Views/
│   ├── ContentView.swift
│   ├── SwipeCardView.swift
│   ├── InterestedPlacesView.swift
│   └── PlaceDetailView.swift
├── ViewModels/
│   └── PlacesViewModel.swift
├── Data/
│   └── SamplePlaces.swift
└── LocalSpotsApp.swift
```

### 7. Configure Deployment Target

1. Click on the **project name** (LocalSpots) at the top of the Project Navigator
2. Under **TARGETS**, select **LocalSpots**
3. Go to the **General** tab
4. Under **Deployment Info**, set:
   - **Minimum Deployments**: iOS 17.0 or later
   - **Supported Destinations**: iPhone

### 8. Build and Run!

1. Select a simulator from the device menu at the top (e.g., "iPhone 15 Pro")
2. Click the **Play button** (▶️) or press **⌘R**

The app should build successfully and launch in the simulator!

## What You'll See

When the app launches, you'll have three tabs:

1. **Discover**: Swipe through 50 SF places
   - Swipe right (or drag right) = Interested
   - Swipe left (or drag left) = Not interested

2. **Eat**: View restaurants you're interested in
   - Tap any place to see details
   - Mark places as visited

3. **Explore**: View activities you're interested in
   - Same functionality as the Eat tab

## Troubleshooting

### Build Errors

If you see errors like "Cannot find 'Place' in scope":
- Make sure all files are added to the project target
- Clean the build folder: **Product > Clean Build Folder** (⇧⌘K)
- Restart Xcode

### Simulator Issues

- If the simulator doesn't launch, try selecting a different device
- Reset simulator: **Device > Erase All Content and Settings**

### SwiftData Issues

If you see SwiftData errors:
- Ensure your deployment target is iOS 17.0+
- Check that SwiftData is imported in relevant files

## Key Concepts for First-Time iOS Developers

### SwiftUI
- Declarative UI framework - you describe what you want, not how to build it
- Views automatically update when data changes
- Preview canvas lets you see changes in real-time

### SwiftData
- Apple's modern data persistence framework (introduced iOS 17)
- Uses Swift macros like `@Model` for automatic database setup
- Replaces Core Data with a simpler, more Swift-friendly API

### Project Structure
- **Models**: Data structures (`Place.swift`)
- **Views**: UI components (all SwiftUI views)
- **ViewModels**: Business logic and data management
- **Data**: Sample/mock data

### Navigation
- `NavigationStack`: Manages the navigation hierarchy
- `TabView`: Creates the bottom tab bar interface
- `NavigationLink`: Creates tappable items that navigate to detail views

## Next Steps

Now that your app is running:

1. Try swiping through some places
2. Mark a few as interested
3. Navigate to the Eat/Explore tabs to see your saved places
4. Tap a place to see the detail view
5. Mark a place as visited

In future sessions, we can:
- Customize the UI/colors
- Add more features
- Integrate real location data
- Add filtering and search
- Prepare for API integration (Phase 3)

## Best Practices Implemented

- **MVVM Architecture**: Separation of concerns (Model-View-ViewModel)
- **SwiftData for Persistence**: Modern, type-safe data storage
- **Reusable Components**: Cards, rows, and detail views
- **Environment Objects**: Clean dependency injection
- **Type Safety**: Enums for status and categories
- **Future-Ready**: Extensible data model for API integration

## Questions?

Common questions for first-time iOS developers:

**Q: Can I test on a real iPhone?**
A: Yes! Connect your iPhone, select it as the run destination, and you may need to add your Apple ID in Xcode settings (trust your device).

**Q: How do I customize the UI?**
A: Edit the View files. SwiftUI uses modifiers like `.font()`, `.foregroundColor()`, `.padding()` to style views.

**Q: Where is the data stored?**
A: SwiftData stores data in the app's container. It persists between app launches but is deleted if you delete the app.

**Q: Can I add more places?**
A: Yes! Edit `SamplePlaces.swift` and add more `Place` objects to the array.

Happy coding!
