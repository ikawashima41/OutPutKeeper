//
//  RouteEntity.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/09/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation

struct MapEntity: Decodable {
    let route: String
}

// MARK: - GeocodedWaypoint
struct GeocodedWaypoint: Decodable {
    let geocoderStatus: String?
    let placeID: String?
    let types: [String]
    let partialMatch: Bool?

    enum CodingKeys: String, CodingKey {
        case geocoderStatus = "geocoder_status"
        case placeID = "place_id"
        case types
        case partialMatch = "partial_match"
    }
}

// MARK: - Route
struct Route: Decodable {
    let bounds: Bounds
    let copyrights: String?
    let legs: [Legs]
}

// MARK: - Bounds
struct Bounds: Decodable {
    let northeast: Double?
    let southwest: Double?
}

// MARK: - Northeast
struct Northeast: Decodable {
    let lat: Double?
    let lng: Double?
}

// MARK: - Leg
struct Legs: Decodable {
    let distance: String?
    let duration: Double?
    let endAddress: String?
    let endLocation: Double?
    let startAddress: String?
    let startLocation: Double?

    enum CodingKeys: String, CodingKey {
        case distance
        case duration
        case endAddress = "end_address"
        case endLocation = "end_location"
        case startAddress = "start_address"
        case startLocation = "start_location"
    }
}

// MARK: - Distance
struct Distance: Decodable {
    let text: String?
    let value: Int?
}
