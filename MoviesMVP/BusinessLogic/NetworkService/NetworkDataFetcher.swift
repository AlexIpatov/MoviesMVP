//
//  NetworkDataFetcher.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 16.04.2021.
//

import Foundation

protocol DataFetcher {
    func fetchGenericJSONData<T: Decodable>(url: URL, headers: [String : String], response: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcher {
    var networking: Networking
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    func fetchGenericJSONData<T: Decodable>(url: URL, headers: [String : String], response: @escaping (T?) -> Void) {
        networking.request(url: url, headers: headers) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            let decoded = self.decodeJSON(type: T.self, from: data)
            response(decoded)
        }
    }
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
