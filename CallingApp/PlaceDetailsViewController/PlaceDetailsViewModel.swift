//
//  PlaceDetailsViewModel.swift
//  CallingApp
//
//  Created by Hari Bista on 10/10/21.
//

import UIKit

class PlaceDetailsViewModel {
    var placeDetails: PlaceDetail?
    var place: PlaceSummary?
    
    private let apiKey = "AIzaSyBPUsycPYmVE2Nkccw7z0IliWM_i80YzZQ"
    private var endPoint = "place/details/json"

    func fetchPlaceDetails(completion: @escaping (Bool,String?) -> Void) {
        guard let placeId = place?.placeID else {
            completion(false,nil)
            return
        }

        let apiCaller = PlacesApiCaller<PlaceDetailData>()
        apiCaller.queryItems = [
            URLQueryItem(name: "place_id", value: placeId),
            URLQueryItem(name: "key", value: apiKey),
        ]
        
        apiCaller.callApi(endPoint: self.endPoint) { result in
            switch result {
            case .success(let placeDetailsData):
                self.placeDetails = placeDetailsData.result
                completion(true,nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(false,error.localizedDescription)
            }
        }
    }
}

extension PlaceSummary {
    var businessType: String {
        if isCarType {
            return "Car Rental".uppercased()
        } else if isHotelType {
            return "Hotel".uppercased()
        } else {
            return "Other".uppercased()
        }
    }
}

extension OpeningHours {
    var displayOpenHoursValue: String {
        var result = ""
        for item in self.weekdayText {
            result = result + item + "\n\n"
        }
        return result
    }
}

extension PlaceSummary {
    var isCarType: Bool {
        for type in self.types {
            if type.lowercased().contains("car") {
                return true
            }
        }
        return false
    }
    
    var isHotelType: Bool {
        for type in self.types {
            if type.lowercased().contains("hotel") {
                return true
            }
        }
        return false
    }
}
