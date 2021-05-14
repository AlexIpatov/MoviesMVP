//
//  NetworkManager.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 16.04.2021.
//

import Foundation

protocol Networking {
    func request(url: URL, headers: [String: String], completion: @escaping (Data?, Error?) -> Void)
}
class NetworkService: Networking {
    func request(url: URL, headers: [String: String], completion: @escaping (Data?, Error?) -> Void) {
        var request = URLRequest(url: url)
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }

    private func createDataTask(from requst: URLRequest,
                                completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: requst,
                                          completionHandler: { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
}
