import Foundation

struct SamplePlaces {
    static let all: [Place] = [
        // RESTAURANTS
        Place(
            name: "Tartine Bakery",
            category: .restaurant,
            subcategory: "Bakery",
            latitude: 37.761435,
            longitude: -122.420865,
            address: "600 Guerrero St, San Francisco, CA 94110",
            imageName: "bakery-generic"
        ),
        Place(
            name: "Swan Oyster Depot",
            category: .restaurant,
            subcategory: "Seafood",
            latitude: 37.791234,
            longitude: -122.420567,
            address: "1517 Polk St, San Francisco, CA 94109",
            imageName: "seafood-generic"
        ),
        Place(
            name: "Zuni Café",
            category: .restaurant,
            subcategory: "American",
            latitude: 37.776234,
            longitude: -122.422456,
            address: "1658 Market St, San Francisco, CA 94102",
            imageName: "restaurant-generic"
        ),
        Place(
            name: "State Bird Provisions",
            category: .restaurant,
            subcategory: "American",
            latitude: 37.784523,
            longitude: -122.434567,
            address: "1529 Fillmore St, San Francisco, CA 94115",
            imageName: "restaurant-generic"
        ),
        Place(
            name: "Liholiho Yacht Club",
            category: .restaurant,
            subcategory: "Hawaiian",
            latitude: 37.784012,
            longitude: -122.411234,
            address: "871 Sutter St, San Francisco, CA 94109",
            imageName: "asian-food-generic"
        ),
        Place(
            name: "Foreign Cinema",
            category: .restaurant,
            subcategory: "California",
            latitude: 37.758901,
            longitude: -122.419876,
            address: "2534 Mission St, San Francisco, CA 94110",
            imageName: "restaurant-generic"
        ),
        Place(
            name: "La Taqueria",
            category: .restaurant,
            subcategory: "Mexican",
            latitude: 37.749234,
            longitude: -122.418765,
            address: "2889 Mission St, San Francisco, CA 94110",
            imageName: "restaurant-generic"
        ),
        Place(
            name: "House of Prime Rib",
            category: .restaurant,
            subcategory: "Steakhouse",
            latitude: 37.788901,
            longitude: -122.421345,
            address: "1906 Van Ness Ave, San Francisco, CA 94109",
            imageName: "restaurant-generic"
        ),
        Place(
            name: "Gary Danko",
            category: .restaurant,
            subcategory: "Fine Dining",
            latitude: 37.805678,
            longitude: -122.419234,
            address: "800 North Point St, San Francisco, CA 94109",
            imageName: "restaurant-generic"
        ),
        Place(
            name: "Tonkotsu Ramen",
            category: .restaurant,
            subcategory: "Japanese",
            latitude: 37.785432,
            longitude: -122.408765,
            address: "1728 Buchanan St, San Francisco, CA 94115",
            imageName: "asian-food-generic"
        ),
        Place(
            name: "Rich Table",
            category: .restaurant,
            subcategory: "California",
            latitude: 37.779234,
            longitude: -122.418901,
            address: "199 Gough St, San Francisco, CA 94102",
            imageName: "restaurant-generic"
        ),
        Place(
            name: "Delfina",
            category: .restaurant,
            subcategory: "Italian",
            latitude: 37.759876,
            longitude: -122.421234,
            address: "3621 18th St, San Francisco, CA 94110",
            imageName: "restaurant-generic"
        ),
        Place(
            name: "NOPA",
            category: .restaurant,
            subcategory: "American",
            latitude: 37.774567,
            longitude: -122.438901,
            address: "560 Divisadero St, San Francisco, CA 94117",
            imageName: "restaurant-generic"
        ),
        Place(
            name: "Kin Khao",
            category: .restaurant,
            subcategory: "Thai",
            latitude: 37.785234,
            longitude: -122.408123,
            address: "55 Cyril Magnin St, San Francisco, CA 94102",
            imageName: "asian-food-generic"
        ),
        Place(
            name: "Cotogna",
            category: .restaurant,
            subcategory: "Italian",
            latitude: 37.796345,
            longitude: -122.401234,
            address: "490 Pacific Ave, San Francisco, CA 94133",
            imageName: "restaurant-generic"
        ),
        Place(
            name: "Burma Superstar",
            category: .restaurant,
            subcategory: "Burmese",
            latitude: 37.782901,
            longitude: -122.446789,
            address: "309 Clement St, San Francisco, CA 94118",
            imageName: "asian-food-generic"
        ),
        Place(
            name: "Marufuku Ramen",
            category: .restaurant,
            subcategory: "Japanese",
            latitude: 37.785123,
            longitude: -122.407654,
            address: "1581 Webster St, San Francisco, CA 94115",
            imageName: "asian-food-generic"
        ),
        Place(
            name: "The Slanted Door",
            category: .restaurant,
            subcategory: "Vietnamese",
            latitude: 37.795678,
            longitude: -122.393456,
            address: "1 Ferry Building, San Francisco, CA 94111",
            imageName: "asian-food-generic"
        ),
        Place(
            name: "Kokkari Estiatorio",
            category: .restaurant,
            subcategory: "Greek",
            latitude: 37.794567,
            longitude: -122.401890,
            address: "200 Jackson St, San Francisco, CA 94111",
            imageName: "restaurant-generic"
        ),
        Place(
            name: "Mama's on Washington Square",
            category: .restaurant,
            subcategory: "Breakfast",
            latitude: 37.800234,
            longitude: -122.410123,
            address: "1701 Stockton St, San Francisco, CA 94133",
            imageName: "bakery-generic"
        ),
        Place(
            name: "Boulevard",
            category: .restaurant,
            subcategory: "American",
            latitude: 37.791234,
            longitude: -122.391567,
            address: "1 Mission St, San Francisco, CA 94105",
            imageName: "restaurant-generic"
        ),
        Place(
            name: "Farmhouse Kitchen Thai",
            category: .restaurant,
            subcategory: "Thai",
            latitude: 37.769876,
            longitude: -122.426543,
            address: "710 Florida St, San Francisco, CA 94110",
            imageName: "asian-food-generic"
        ),
        Place(
            name: "Flour + Water",
            category: .restaurant,
            subcategory: "Italian",
            latitude: 37.760987,
            longitude: -122.420876,
            address: "2401 Harrison St, San Francisco, CA 94110",
            imageName: "restaurant-generic"
        ),
        Place(
            name: "Mensho Tokyo",
            category: .restaurant,
            subcategory: "Japanese",
            latitude: 37.779654,
            longitude: -122.418234,
            address: "672 Geary St, San Francisco, CA 94102",
            imageName: "asian-food-generic"
        ),
        Place(
            name: "Anchor Oyster Bar",
            category: .restaurant,
            subcategory: "Seafood",
            latitude: 37.762345,
            longitude: -122.433210,
            address: "579 Castro St, San Francisco, CA 94114",
            imageName: "seafood-generic"
        ),

        // ACTIVITIES
        Place(
            name: "Golden Gate Park",
            category: .activity,
            subcategory: "Park",
            latitude: 37.769421,
            longitude: -122.486214,
            address: "Golden Gate Park, San Francisco, CA 94122",
            imageName: "park-generic"
        ),
        Place(
            name: "California Academy of Sciences",
            category: .activity,
            subcategory: "Museum",
            latitude: 37.769868,
            longitude: -122.466103,
            address: "55 Music Concourse Dr, San Francisco, CA 94118",
            imageName: "museum-generic"
        ),
        Place(
            name: "Exploratorium",
            category: .activity,
            subcategory: "Museum",
            latitude: 37.801483,
            longitude: -122.397450,
            address: "Pier 15, San Francisco, CA 94111",
            imageName: "museum-generic"
        ),
        Place(
            name: "Ferry Building Marketplace",
            category: .activity,
            subcategory: "Shopping",
            latitude: 37.795422,
            longitude: -122.393494,
            address: "1 Ferry Building, San Francisco, CA 94111",
            imageName: "landmark-generic"
        ),
        Place(
            name: "Alcatraz Island",
            category: .activity,
            subcategory: "Historic Site",
            latitude: 37.826977,
            longitude: -122.422956,
            address: "Alcatraz Island, San Francisco, CA 94133",
            imageName: "landmark-generic"
        ),
        Place(
            name: "Palace of Fine Arts",
            category: .activity,
            subcategory: "Landmark",
            latitude: 37.802826,
            longitude: -122.448578,
            address: "3601 Lyon St, San Francisco, CA 94123",
            imageName: "landmark-generic"
        ),
        Place(
            name: "Coit Tower",
            category: .activity,
            subcategory: "Landmark",
            latitude: 37.802394,
            longitude: -122.405789,
            address: "1 Telegraph Hill Blvd, San Francisco, CA 94133",
            imageName: "landmark-generic"
        ),
        Place(
            name: "San Francisco Museum of Modern Art",
            category: .activity,
            subcategory: "Museum",
            latitude: 37.785719,
            longitude: -122.400815,
            address: "151 3rd St, San Francisco, CA 94103",
            imageName: "museum-generic"
        ),
        Place(
            name: "Lands End Trail",
            category: .activity,
            subcategory: "Hiking",
            latitude: 37.786234,
            longitude: -122.504567,
            address: "680 Point Lobos Ave, San Francisco, CA 94121",
            imageName: "park-generic"
        ),
        Place(
            name: "Dolores Park",
            category: .activity,
            subcategory: "Park",
            latitude: 37.759773,
            longitude: -122.427063,
            address: "Dolores St & 19th St, San Francisco, CA 94114",
            imageName: "park-generic"
        ),
        Place(
            name: "Twin Peaks",
            category: .activity,
            subcategory: "Viewpoint",
            latitude: 37.754089,
            longitude: -122.447528,
            address: "501 Twin Peaks Blvd, San Francisco, CA 94114",
            imageName: "landmark-generic"
        ),
        Place(
            name: "de Young Museum",
            category: .activity,
            subcategory: "Museum",
            latitude: 37.771478,
            longitude: -122.468595,
            address: "50 Hagiwara Tea Garden Dr, San Francisco, CA 94118",
            imageName: "museum-generic"
        ),
        Place(
            name: "Japanese Tea Garden",
            category: .activity,
            subcategory: "Garden",
            latitude: 37.770454,
            longitude: -122.470234,
            address: "75 Hagiwara Tea Garden Dr, San Francisco, CA 94118",
            imageName: "park-generic"
        ),
        Place(
            name: "Presidio of San Francisco",
            category: .activity,
            subcategory: "Park",
            latitude: 37.798456,
            longitude: -122.466234,
            address: "103 Montgomery St, San Francisco, CA 94129",
            imageName: "park-generic"
        ),
        Place(
            name: "Ghirardelli Square",
            category: .activity,
            subcategory: "Shopping",
            latitude: 37.805702,
            longitude: -122.422873,
            address: "900 North Point St, San Francisco, CA 94109",
            imageName: "landmark-generic"
        ),
        Place(
            name: "Mission Dolores",
            category: .activity,
            subcategory: "Historic Site",
            latitude: 37.764123,
            longitude: -122.426789,
            address: "3321 16th St, San Francisco, CA 94114",
            imageName: "landmark-generic"
        ),
        Place(
            name: "Baker Beach",
            category: .activity,
            subcategory: "Beach",
            latitude: 37.793567,
            longitude: -122.484234,
            address: "Gibson Rd, San Francisco, CA 94129",
            imageName: "landmark-generic"
        ),
        Place(
            name: "Painted Ladies",
            category: .activity,
            subcategory: "Landmark",
            latitude: 37.776235,
            longitude: -122.432980,
            address: "710-720 Steiner St, San Francisco, CA 94117",
            imageName: "landmark-generic"
        ),
        Place(
            name: "Ocean Beach",
            category: .activity,
            subcategory: "Beach",
            latitude: 37.759890,
            longitude: -122.510654,
            address: "Great Highway, San Francisco, CA 94122",
            imageName: "landmark-generic"
        ),
        Place(
            name: "Lombard Street",
            category: .activity,
            subcategory: "Landmark",
            latitude: 37.802198,
            longitude: -122.419784,
            address: "Lombard St, San Francisco, CA 94133",
            imageName: "landmark-generic"
        ),
        Place(
            name: "AT&T Park",
            category: .activity,
            subcategory: "Sports",
            latitude: 37.778456,
            longitude: -122.389234,
            address: "24 Willie Mays Plaza, San Francisco, CA 94107",
            imageName: "landmark-generic"
        ),
        Place(
            name: "Pier 39",
            category: .activity,
            subcategory: "Entertainment",
            latitude: 37.808673,
            longitude: -122.409821,
            address: "Beach St & The Embarcadero, San Francisco, CA 94133",
            imageName: "landmark-generic"
        ),
        Place(
            name: "Legion of Honor",
            category: .activity,
            subcategory: "Museum",
            latitude: 37.784567,
            longitude: -122.500234,
            address: "100 34th Ave, San Francisco, CA 94121",
            imageName: "museum-generic"
        ),
        Place(
            name: "Castro Theatre",
            category: .activity,
            subcategory: "Entertainment",
            latitude: 37.762012,
            longitude: -122.434789,
            address: "429 Castro St, San Francisco, CA 94114",
            imageName: "landmark-generic"
        ),
        Place(
            name: "Conservatory of Flowers",
            category: .activity,
            subcategory: "Garden",
            latitude: 37.771890,
            longitude: -122.460123,
            address: "100 John F Kennedy Dr, San Francisco, CA 94118",
            imageName: "park-generic"
        )
    ]
}
