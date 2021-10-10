//
//  PlacesListViewModel.swift
//  CallingApp
//
//  Created by Hilen Adhikari on 10/9/21.
//

import Foundation
import CoreLocation

class PlacesApiCaller<T:Decodable>: ApiCallerProcol {
    var queryItems: [URLQueryItem] = []
    typealias ResponseType = T
    var baseUrl = "https://maps.googleapis.com/maps/api/"
}

class PlacesListViewModel {

    var places: [Place] = []
    
    private let apiKey = "AIzaSyBPUsycPYmVE2Nkccw7z0IliWM_i80YzZQ"
    
    private var endPoint = "place/textsearch/json"

    func fetchPlacesFor(query:String, completion: @escaping (Bool,String?) -> Void) {
        let locaTionValue = "\(DistanceCalculater.userLocation.coordinate.latitude), \(DistanceCalculater.userLocation.coordinate.longitude)"
        
        let apiCaller = PlacesApiCaller<Places>()
        apiCaller.queryItems = [
            URLQueryItem(name: "key", value: self.apiKey),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "location", value: locaTionValue)
        ]
        
        apiCaller.callApi(endPoint: self.endPoint) { result in
            switch result {
            case .success(let places):
                self.places = places.results
                completion(true,nil)
            case .failure(let error):
                completion(false,error.localizedDescription)
            }
        }
    }
}
