//
//  NetworkManagerService.swift
//  MoviesSampleApp
//
//  Created by Sunil Kumar on 11/02/24.
//

import Foundation
import Combine

protocol APIClient {
    // Performs a network request for a given endpoint.
    /// - Parameter endpoint: The endpoint to request.
    /// - Returns: A publisher emitting the decoded response or an error.
    associatedtype EndpointType: APIEndpoint
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error>
}
// Implementation of APIClient using URLSession.
class URLSessionAPIClient<EndpointType: APIEndpoint>: APIClient {
    func request<T: Decodable>(_ endpoint: EndpointType) -> AnyPublisher<T, Error> {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        //endpoint.headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        // set up any other request parameters here
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
