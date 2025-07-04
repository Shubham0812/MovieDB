//
//  APIError.swift
//  MovieDB
//
//  Created by Shubham on 29/06/25.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
    case invalidResponse

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let err):
            return "Request failed: \(err.localizedDescription)"
        case .decodingFailed(let err):
            return "Decoding failed: \(err.localizedDescription)"
        case .invalidResponse:
            return "Invalid response from server"
        }
    }
}
