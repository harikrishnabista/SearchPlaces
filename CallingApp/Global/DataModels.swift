//
//  DataModels.swift
//  CallingApp
//
//  Created by Hari Bista on 10/9/21.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let places = try? newJSONDecoder().decode(Places.self, from: jsonData)

// MARK: - Places
struct Places: Codable {
    let results: [PlaceSummary]
}

// MARK: - Result
struct PlaceSummary: Codable {
    let businessStatus, formattedAddress: String
    let geometry: Geometry
    let icon: String
    let iconBackgroundColor: String
    let iconMaskBaseURI: String
    let name, placeID: String
    let plusCode: PlusCode
    let rating: Double
    let reference: String
    let types: [String]
    let userRatingsTotal: Int
    let openingHours: OpeningHoursSummary?
    let photos: [Photo]?
    
    enum CodingKeys: String, CodingKey {
        case businessStatus = "business_status"
        case formattedAddress = "formatted_address"
        case geometry, icon
        case iconBackgroundColor = "icon_background_color"
        case iconMaskBaseURI = "icon_mask_base_uri"
        case name
        case placeID = "place_id"
        case plusCode = "plus_code"
        case rating, reference, types
        case userRatingsTotal = "user_ratings_total"
        case openingHours = "opening_hours"
        case photos
    }
}

// MARK: - Geometry
struct Geometry: Codable {
    let location: Location
    let viewport: Viewport
}

// MARK: - Location
struct Location: Codable {
    let lat, lng: Double
}

// MARK: - Viewport
struct Viewport: Codable {
    let northeast, southwest: Location
}

// MARK: - OpeningHoursSummary
struct OpeningHoursSummary: Codable {
    let openNow: Bool

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}

// MARK: - OpeningHours
struct OpeningHours: Codable {
    let openNow: Bool
    let periods: [Period]
    let weekdayText: [String]

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
        case periods
        case weekdayText = "weekday_text"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let height: Int
    let photoReference: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case height
        case photoReference = "photo_reference"
        case width
    }
}

// MARK: - PlusCode
struct PlusCode: Codable {
    let compoundCode, globalCode: String

    enum CodingKeys: String, CodingKey {
        case compoundCode = "compound_code"
        case globalCode = "global_code"
    }
}

// MARK: - PlaceDetails
struct PlaceDetailData: Codable {
    let result: PlaceDetail
}

// MARK: - Result
struct PlaceDetail: Codable {
    let addressComponents: [AddressComponent]
    let adrAddress, businessStatus, formattedAddress: String
    let formattedPhoneNumber: String
    let geometry: Geometry
    let icon: String
    let iconBackgroundColor: String
    let iconMaskBaseURI: String
    let name: String
    let openingHours: OpeningHours?
    let photos: [Photo]
    let placeID: String
    let plusCode: PlusCode
    let rating: Double
    let reference: String
    let reviews: [Review]
    let types: [String]
    let url: String
    let userRatingsTotal, utcOffset: Int
    let vicinity: String
    let website: String

    enum CodingKeys: String, CodingKey {
        case addressComponents = "address_components"
        case adrAddress = "adr_address"
        case businessStatus = "business_status"
        case formattedAddress = "formatted_address"
        case formattedPhoneNumber = "formatted_phone_number"
        case geometry, icon
        case iconBackgroundColor = "icon_background_color"
        case iconMaskBaseURI = "icon_mask_base_uri"
        case name
        case openingHours = "opening_hours"
        case photos
        case placeID = "place_id"
        case plusCode = "plus_code"
        case rating, reference, reviews, types, url
        case userRatingsTotal = "user_ratings_total"
        case utcOffset = "utc_offset"
        case vicinity, website
    }
}

// MARK: - AddressComponent
struct AddressComponent: Codable {
    let longName, shortName: String
    let types: [String]

    enum CodingKeys: String, CodingKey {
        case longName = "long_name"
        case shortName = "short_name"
        case types
    }
}

// MARK: - Period
struct Period: Codable {
    let periodOpen: Open

    enum CodingKeys: String, CodingKey {
        case periodOpen = "open"
    }
}

// MARK: - Open
struct Open: Codable {
    let day: Int
    let time: String
}

// MARK: - Review
struct Review: Codable {
    let authorName: String
    let authorURL: String
    let language: String
    let profilePhotoURL: String
    let rating: Int
    let relativeTimeDescription, text: String
    let time: Int

    enum CodingKeys: String, CodingKey {
        case authorName = "author_name"
        case authorURL = "author_url"
        case language
        case profilePhotoURL = "profile_photo_url"
        case rating
        case relativeTimeDescription = "relative_time_description"
        case text, time
    }
}
