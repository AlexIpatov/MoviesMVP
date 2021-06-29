//
//  URLPathParameterEncoder.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 29.06.2021.
//

import Foundation

public struct URLPathParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard var url = urlRequest.url
        else { throw NetworkingError.missingURL }
        guard !parameters.isEmpty else { return }
        for (_ ,value) in parameters {
            let string = String("\(value)")
            let pathComponent = string
            url.appendPathComponent(pathComponent)
        }
        urlRequest.url = url
    }
}
