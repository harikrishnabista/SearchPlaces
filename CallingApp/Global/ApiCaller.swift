//
//  ApiCaller.swift
//  ReceipeBrowser
//
//  Created by Hari Bista on 10/6/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

enum NetworkError: Error {
    case failure(Error)
    case unknown
}

protocol ApiCallerProcol {
    associatedtype ResponseType: Decodable
    var baseUrl: String { get set }
    var queryItems: [URLQueryItem] { get set }
    func callApi(endPoint: String, completion: @escaping (Result<ResponseType,NetworkError>) -> Void)
}

extension ApiCallerProcol {
    func callApi(endPoint: String,
                 completion: @escaping (Result<ResponseType,NetworkError>) -> Void) {
        guard let url = URL(string: self.baseUrl + endPoint) else {
            completion(Result.failure(.unknown))
            return
        }

        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = self.queryItems
        
        guard let apiUrl = urlComponents?.url else {
            completion(Result.failure(.unknown))
            return
        }

        print("Loading Data from: \(apiUrl.absoluteString)")
        let urlRequest = URLRequest(url: apiUrl)

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, respose, error) in
            do {
                if let data = data, error == nil {
                    let returnObj = try JSONDecoder().decode(ResponseType.self, from: data)
                    completion(Result.success(returnObj))
                } else if let error = error {
                    completion(Result.failure(.failure(error)))
                }
            } catch let error {
                completion(Result.failure(.failure(error)))
            }
        }
        task.resume()
    }
}

class ImageDownloadHelper {
    public static let shared = ImageDownloadHelper()
    
    private var cache:[URL: UIImage] = [:]
    
    func downloadImage(url: URL, completion: @escaping (UIImage?)-> Void) {
        if let image = self.cache[url] {
            completion(image)
        } else {
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { (data, respose, error) in
                do {
                    if let data = data, error == nil {
                        let image = UIImage(data: data)
                        
                        if let image = image {
                            self.cache[url] = image
                        }
                        
                        completion(image)
                    } else if let error = error {
                        completion(nil)
                    }
                } catch _ {
                    if let error = error {
                        completion(nil)
                    }
                }
            }
            task.resume()
        }
    }
    
    /*
    func downloadImage(url: URL, completion: @escaping (UIImage?)-> Void) {
        if let image = self.cache[url] {
            completion(image)
        } else {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    
                    if let image = image {
                        self.cache[url] = image
                    }
                    
                    completion(image)
                } else {
                    completion(nil)
                }
            }
        }
    } */
}
