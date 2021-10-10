//
//  DataModels.swift
//  CallingApp
//
//  Created by Hilen Adhikari on 10/9/21.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let places = try? newJSONDecoder().decode(Places.self, from: jsonData)

// MARK: - Places
struct Places: Codable {
    let results: [Place]
}

// MARK: - Result
struct Place: Codable {
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
    let openingHours: OpeningHours?
    let photos: [Photo]?
    let permanentlyClosed: Bool?

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
        case permanentlyClosed = "permanently_closed"
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

// MARK: - OpeningHours
struct OpeningHours: Codable {
    let openNow: Bool

    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
    }
}

// MARK: - Photo
struct Photo: Codable {
    let height: Int
    let htmlAttributions: [String]
    let photoReference: String
    let width: Int

    enum CodingKeys: String, CodingKey {
        case height
        case htmlAttributions = "html_attributions"
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
