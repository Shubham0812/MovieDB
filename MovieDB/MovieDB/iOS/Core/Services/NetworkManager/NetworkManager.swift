//
//  NetworkManager.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import Foundation

struct NetworkManager {

    // MARK: - Variables
    private let apiKey = "75ed703c87cbed299a8b2ec2124aee17"
    private let baseURL = URL(string: "https://api.themoviedb.org/3")!

    // MARK: - Inits
    init() {}

    
    // MARK: - Functions
    func request<T: Decodable>(_ endpoint: APIEndpoint, as type: T.Type) async -> Result<T, APIError> {
        guard var urlComponents = URLComponents(url: baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: false) else {
            return .failure(.invalidURL)
        }

        // Add query items and api key
        var queryItems = endpoint.queryItems
        queryItems.append(URLQueryItem(name: "api_key", value: apiKey))
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                return .failure(.invalidResponse)
            }

            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch let decodingError as DecodingError {
            return .failure(.decodingFailed(decodingError))
        } catch {
            return .failure(.requestFailed(error))
        }
    }
}
